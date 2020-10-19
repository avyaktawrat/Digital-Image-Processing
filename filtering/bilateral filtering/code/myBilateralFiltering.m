function [final_image, rmsd,ans1] = myBilateralFiltering(image_2, sd_distance1, sd_intensity1);
dim = size(image_2);
maxInt = max(max(image_2));
minInt = min(min(image_2));

noise_2 = randn(dim(1));
ogImage = image_2;
noiseAmp = 0.05 * cast((maxInt-minInt),'double');
noise_2 = noiseAmp * noise_2;
image_2 = cast(image_2,'double') + noise_2;
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(image_2);
title("Noisy Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
sizeD = size(sd_distance1);
sizeI = size(sd_intensity1);
ans1 = zeros(sizeD(2),sizeI(2));
for i = 1:dim(1)
    for j = 1:dim(2)
        if image_2(i,j) < 0
            image_2(i,j) = 0;
        elseif image_2(i,j) > maxInt
            image_2(i,j) = maxInt;
        end;
    end;
end;
final_image = zeros(dim);
k=0;l=0;
for sigmaS =  sd_distance1
    l = l+1;
    k=0;
    for sigmaI =  sd_intensity1
        k=k+1;
        
        windowSize = min(dim(1),ceil(sigmaS));
        [X,Y] = meshgrid(-windowSize:windowSize,-windowSize:windowSize);
        weightS = exp(-((X).^2+(Y).^2)/(2*sigmaS^2));
        disp("sd_distance = " + sigmaS +" sd_intensity = "+sigmaI+" window = "+(2*windowSize+1) );
        figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(weightS);
title("Gaussian Mask"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
        for i = 1:dim(1)
            for j = 1:dim(2)   
                iMin = max(i-windowSize,1);
                jMin = max(j-windowSize,1);
                iMax = min(windowSize+i,dim(1));
                jMax = min(windowSize+j,dim(2));

                %image in window
                I = image_2(iMin:iMax,jMin:jMax);

                weightI = exp(-((I - image_2(i,j)).^2/(2*sigmaI*sigmaI)));

                weights = weightI.*weightS((iMin:iMax)-i+windowSize+1,(jMin:jMax)-j+windowSize+1);
                final_image(i,j) = sum(weights(:).*I(:))/sum(weights(:)); 
            end
        end
        rmsd = final_image - cast(ogImage,'double');
        rmsd = rmsd.*rmsd;
        rmsd = sum(rmsd, 'all');
        rmsd = rmsd / (dim(2)*dim(2));
        rmsd = nthroot(rmsd,2);
        ans1(k,l)=rmsd;
    end
end