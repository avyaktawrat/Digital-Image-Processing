function [filteredImage]= myFastBilateral(img, sigma_S, sigma_R, s_s, s_r)
% tic;
[ n, m, d ] = size(img);
filteredImage = zeros(n,m,d);
% s_s and s_r are sampling rates for s and r space resp
subsig_S = sigma_S / s_s;
subsig_R = sigma_R / s_r;

pad_s = floor(subsig_S);
pad_r = floor(subsig_R);
% downsampled (x,y)
subWidth = floor( ( m - 1 ) / s_s ) + 1 + 2 * pad_s;
subHeight = floor( ( n - 1 ) / s_s ) + 1 + 2 * pad_s;

% compute downsampled indices
[ jj, ii ] = meshgrid( 0 : m - 1, 0 : n - 1 );

di = ( ii / s_s ) + pad_s + 1;
dj = ( jj / s_s ) + pad_s + 1;

% Defining gaussian kernel for convolution step 11a
ker_wid_s = 2 * floor(subsig_S) + 1;
ker_wid_r = 2 * floor(subsig_R) + 1;

[gridX, gridY, gridZ] = meshgrid( - floor( ker_wid_s / 2 ) : floor( ker_wid_s / 2 ), - floor( ker_wid_s / 2 ) :  floor( ker_wid_s / 2 ), - floor( ker_wid_r / 2 ) : floor( ker_wid_r / 2 )) ;
gridRSq = ( gridX .^2 + gridY .^2 ) / ( subsig_S .^2 ) + ( gridZ .^2 )/( subsig_R .^2);
kernel = exp( -0.5 * gridRSq );
for a = 1:d
    img_a = double(img(:,:,a));
    img_aMin = min(img_a( : ));
    img_aMax = max(img_a( : ));
    img_adiff = img_aMax - img_aMin;

    subR_dim = floor( img_adiff / s_r ) + 1 + 2 * pad_r;

    data_mat = zeros( subHeight, subWidth, subR_dim );
    weights_mat = zeros( subHeight, subWidth, subR_dim );

    % compute downsampled indices
    dz =  ( img_a - img_aMin ) / s_r + pad_r + 1;
 
    dz_n = round(dz);
    k_size = size(dz_n);
        for k1 = 1 : s_s : k_size(1)
            for k2 = 1 : s_s : k_size(2)  
                k1_in = round((k1-1)/s_s ) + pad_s + 1;
                k2_in = round((k2-1)/s_s ) + pad_s + 1;
                data_mat(k1_in, k2_in, dz_n(k1, k2)) = img_a(k1,k2);
                weights_mat(k1_in, k2_in, dz_n(k1, k2)) = 1;
            end
        end


    wi_bp_sub = convn( data_mat, kernel, 'same' ); % grid data is downsampled wi
    w_bp_sub = convn( weights_mat, kernel, 'same' ); %grid weights is downsampled w

    % divide
    w_bp_sub( w_bp_sub == 0 ) = -2; % avoid divide by 0, won't read there anyway
    normalized_submat = wi_bp_sub ./ w_bp_sub;
    normalized_submat( w_bp_sub < -1 ) = 0; % put 0s where it's undefined
    filteredImage(:,:,a) = interpn( normalized_submat, di, dj, dz );
end
end