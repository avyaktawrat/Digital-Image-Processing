function [final_image1,distance] =  mySpatiallyVaryingKernel(I_down, alpha,Mask_bin)

    dim = size(I_down);
    distance = zeros(dim(1:2));
    for i=1:dim(1)
        for j=1:dim(2)
            distance(i,j) = minDist(i,j,Mask_bin,alpha);
        end
    end


    final_image = zeros(dim);
    for i=1:dim(1)
        for j=1:dim(2)
            radius=round(distance(i,j));
            l=min(radius,i-1);
            r=min(dim(1)-i,radius);
            u= min(radius,j-1);
            b = min(radius,dim(2)-j);
            [X,Y] = meshgrid(-u:b,-l:r);
            X = X.^2+Y.^2;
            X = sqrt(X);
            rad_mask = X <= radius;
            I_crop = I_down(i-l:i+r,j-u:j+b,:);
            if(sum(rad_mask,'all')==0)
                continue;
            end
            final_image(i,j,:)=sum(I_crop.*rad_mask,[1,2])/sum(rad_mask,'all');
        end
    end
    final_image1 = final_image.*Mask_bin + I_down.*(~Mask_bin);
end

function k = minDist(a,b,Mask_bin,alpha)
dim = size(Mask_bin);
k=alpha;
for i = max(1,a-alpha):min(a+alpha,dim(1))
    for j = max(1,b-alpha):min(b+alpha,dim(2))
        if(Mask_bin(i,j) == 0)
            if(k > sqrt((i-a)^2 + (j-b)^2))
                k = sqrt((i-a)^2 + (j-b)^2);
            end
        end
    end
end

end