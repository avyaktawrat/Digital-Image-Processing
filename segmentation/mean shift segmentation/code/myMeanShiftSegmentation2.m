function [final_img] = myMeanShiftSegmentation2(img_1,h_s, h_r)
    lr_s      = 2;
    lr_r      = 1.5;
    window_range = 4 * h_s;
    
    %downsampling by facror 2
    sampled_img = imresize(double(img_1),0.5);
    %applying gaussian blurring 
    sampled_img = imgaussfilt(sampled_img,2);
    
   [r,c,cha] = size(sampled_img);    
    I = zeros(r,c,5);
    
    %5D vector of rgbxy space
    for iter = 1:r
        for iter2 = 1:c
            I(iter, iter2, 1) = sampled_img(iter, iter2,1);
            I(iter, iter2, 2) = sampled_img(iter, iter2,2);
            I(iter, iter2, 3) = sampled_img(iter, iter2,3);
            I(iter, iter2, 4) = iter;
            I(iter, iter2, 5) = iter2;
        end
    end 
    
    temp = zeros(r,c,5);     % stores changes over iteration n then updates I
    for iter = 1:10
        for i=1:r
            for j=1:c
                %creating a box of 4 sigma lengh around the query point
                x_max_range = min(i + window_range / 2,r);
                x_min_range = max(i - window_range / 2,1);
                y_max_range = min(j + window_range / 2,c);
                y_min_range = max(j - window_range / 2,1);
                
                weighted_factor =zeros(5,1);
                factor = 0;
                for k=x_min_range : x_max_range
                    for l=y_min_range : y_max_range
                        %rgb space difference norm 
                        X = double((I(k,l,1) - I(i,j,1)) ^ 2 + (I(k,l,2) - I(i,j,2)) ^ 2 + (I(k,l,3) - I(i,j,3)) ^ 2);
                        b = exp(-(X/(2 * h_r^2)));                                 %colour space gaussian
                        Y = (I(k,l,4) - I(i,j,4))^2 + (I(k,l,5) - I(i,j,5))^2 ;            
                        a = exp(-(Y/(2 * h_s^2)));                                 %spatial space gaussian
                         %sum (weighted average)
                        for m=1:cha
                            weighted_factor(m) = weighted_factor(m) +  lr_r * a * b * double((I(k,l,m)) - I(i,j,m));      
                        end
                        for m=4:5     %sum (G_s * G_c)
                            weighted_factor(m) = weighted_factor(m) +  lr_s * a * b * double((I(k,l,m)) - I(i,j,m));       
                        end
                        factor = factor + a * b;                                                               
                    end
                end %window end
                for m= 1:cha+2    %mean shifts
                    temp(i,j,m) = I(i,j,m)+ weighted_factor(m)/factor; 
                end
            end  
        end
         I= temp;
    end
    
    toc;
    final_img = I(:,:,1:3); 
    
     figure;
     subplot(1,2,1);
     myNumOfColors = 1000000;
     myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
     colormap (myColorScale);
     colormap jet; axis tight;
     daspect ([1 1 1]);
     imshow(mat2gray(sampled_img));
     title("Original Image"); h = gca; h.Visible = 'on';
     cb=colorbar;
     cb.Position = cb.Position + [0.1, 0.01,0,0];
     
     subplot(1,2,2);  
     myNumOfColors = 1000000;
     myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
     colormap (myColorScale);
     colormap jet; axis tight;
     daspect ([1 1 1]);
     imshow(mat2gray(final_img));
     title("Image"); h = gca; h.Visible = 'on';
     cb=colorbar;
     cb.Position = cb.Position + [0.1, 0.01,0,0];
end
    
    