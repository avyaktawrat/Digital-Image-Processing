function myHM(orig_img,ref_img)
    %UNTITLED Summary of this function goes here
    %   Detailed explanation goes here
    %     h1 = imhist(orig_img); %// Compute histograms
    %     h2 = imhist(ref_img);
    %     cdf_1 = cumsum(h1) / numel(orig_img); %// Compute CDFs
    %     cdf_2 = cumsum(h2) / numel(ref_img);
    %
    [m1,n1,k1] = size(orig_img);
    [m2,n2,k2] = size(ref_img);
    fin_img = zeros(size(orig_img));

    for l = 1:k1  %number of channels
        val1 = zeros(256, 1);
        val2 = zeros(256, 1);
        %finding probability distribution
        for i = 1:m1  %row
            for j = 1:n1 %col
                val1(orig_img(i,j,l) + 1, 1) = val1(orig_img(i,j,l) + 1, 1) + 1;
            end
        end
        for i = 1:m2  %row
            for j = 1:n2 %col
                val2(ref_img(i,j,l) + 1, 1) = val2(ref_img(i,j,l) + 1, 1) + 1;
            end
        end
        %finding cumulative distribution

        B1 = cumsum(val1);
        B1 = B1/max(B1,[],'all');

        B2 = cumsum(val2);
        B2 = B2/max(B2,[],'all');

%       discrete values in array
        for i = 1:m1
            for j = 1:n1
                cdf_tem = B1(orig_img(i,j,l)+1,1);
                closeval = min(abs(B2-cdf_tem));
                idx = find(abs(B2-cdf_tem)==closeval,1,'first');
                fin_img(i,j,l) = (idx-1);
            end
        end
    end

     fin_img = uint8(fin_img);

    figure('Name','origial histogram matching','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(orig_img);
    title("Original Image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];

    figure('Name','histogram matching ref','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(ref_img);
    title("histogram matching ref"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];

    figure('Name','histogram matching','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(fin_img);
    title("histogram matching"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
end
