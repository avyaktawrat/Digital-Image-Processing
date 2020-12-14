function [final_image] = myBilateral(image_2, sd_distance1, sd_intensity1)
dim = size(image_2);

final_image = zeros(dim);

windowSize = min(dim(1),ceil(sd_distance1));
[X,Y] = meshgrid(-windowSize:windowSize,-windowSize:windowSize);
weightS = exp(-((X).^2+(Y).^2)/(2*sd_distance1^2));

for i = 1:dim(1)
    for j = 1:dim(2)   
        iMin = max(i-windowSize,1);
        jMin = max(j-windowSize,1);
        iMax = min(windowSize+i,dim(1));
        jMax = min(windowSize+j,dim(2));

        for u = 1:3
        %image in window
        I = image_2(iMin:iMax,jMin:jMax,u);
        weightI = exp(-((I - image_2(i,j,u)).^2/(2*sd_intensity1*sd_intensity1)));
        weights = weightI.*weightS((iMin:iMax)-i+windowSize+1,(jMin:jMax)-j+windowSize+1);
        final_image(i,j,u) = sum(weights(:).*I(:))/sum(weights(:)); 
        end
    end
end
