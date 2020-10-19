function [final_image,rmsd,noise] = myPatchBasedFiltering(image_2,h)
dim = size(image_2);
maxInt = max(max(image_2));
minInt = min(min(image_2));

noise_2 = randn(dim(1));
ogImage = image_2;
noiseAmp = 0.05 * cast((maxInt-minInt),'double');
noise_2 = noiseAmp * noise_2;
image_2 = cast(image_2,'double') + noise_2;
noise = image_2;
sigmaS = 4;
for i = 1:dim(1)
    for j = 1:dim(2)
        if image_2(i,j) < 0
            image_2(i,j) = 0;
        elseif image_2(i,j) > maxInt
            image_2(i,j) = maxInt;
        end
    end
end

final_image = zeros(dim);

windowSize = 4;
for i = 1:dim(1)
    for j = 1:dim(2)
        %current patch coor
        iMin = max(i-windowSize,1);
        jMin = max(j-windowSize,1);
        iMax = min(windowSize+i,dim(1));
        jMax = min(windowSize+j,dim(2));
        left = i- iMin;
        r = iMax- i;
        u = j - jMin;
        b = jMax - j;
        %image in window
        
        kmin = max(i-12,1);
        kmax = min(i+12,dim(1));
        lmin = max(j-12,1);
        lmax = min(j+12,dim(2));
        
        count = 0;
        expWeight = zeros(625,1);
        Icount = 0;
        for k = kmin:kmax
            for l = lmin:lmax
                count = count +1;
                %neigh patch coor
                i1Min = max(k-windowSize,1);
                j1Min = max(l-windowSize,1);
                i1Max = min(windowSize+k,dim(1));
                j1Max = min(windowSize+l,dim(2));
                
                left1 = k- i1Min;
                r1 = i1Max- k;
                u1 = l - j1Min;
                b1 = j1Max - l;
                
                if left > left1 || r > r1 || u > u1 || b > b1
                    continue;
                end
                
                I_neigh = image_2(k-left:k+r , l-u:l+b);
                
                
                Iorg = image_2(i-left:i+r,j-u:j+b);
                [X,Y] = meshgrid(-u:b,-left:r);
                weightS = exp(-((X).^2+(Y).^2)/(2*sigmaS^2));

                I_neigh = I_neigh.*weightS;
                Iorg = Iorg.*weightS;
                
                expWeight(count) = exp(-(sum((Iorg-I_neigh).^2,'all'))/(2*h^2) );
                Icount = Icount + expWeight(count) * image_2(k,l);
            end
        end
        s = sum(expWeight);
        final_image(i,j) = Icount/s ;
        
    end

end
rmsd = final_image - cast(ogImage,'double');
rmsd = rmsd.*rmsd;
rmsd = sum(rmsd, 'all');
rmsd = rmsd / (dim(2)*dim(2));
rmsd = nthroot(rmsd,2);



