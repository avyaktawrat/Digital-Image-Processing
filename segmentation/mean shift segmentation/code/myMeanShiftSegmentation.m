function [output_img] = myMeanShiftSegmentation(img_1,h_s, h_r)

    window_range = 4 * h_s;
    
    %downsampling by facror 2
    sampled_img = imresize(double(img_1),0.5);
    %applying gaussian blurring 
    sampled_img = imgaussfilt(sampled_img,2);
    
   [r,c,cha] = size(sampled_img);
    output_img = sampled_img;
    output_img1 = zeros(r,c,cha); % stores changes over iteration n then updates 
%
    for iter = 1:10
        disp(iter);
        for i=1:r
            for j=1:c
                %creating a box of 4 sigma lengh around the query point
                x_max_range = min(i + window_range / 2,r);
                x_min_range = max(i - window_range / 2,1);
                y_max_range = min(j + window_range / 2,c);
                y_min_range = max(j - window_range / 2,1);
                
                weighted_factor =zeros(cha,1);
                factor = 0;
                for k=x_min_range : x_max_range
                    for l=y_min_range : y_max_range
                        %rgb space difference norm 
                        X = double((output_img(k,l,1) - output_img(i,j,1)) ^ 2 + (output_img(k,l,2) - output_img(i,j,2)) ^ 2 + (output_img(k,l,3) - output_img(i,j,3)) ^ 2);
                        a = exp( - ((k - i) ^ 2 + (l - j) ^ 2) / (2 * (h_s)^2));                               %spatial gaussian
                        b = exp(-(X/(2 * h_r^2)));                                                             %colour space gaussian
                        for m=1:cha
                            weighted_factor(m) = weighted_factor(m) + a * b * double((output_img(k,l,m)));     %sum (weighted average) 
                        end
                        factor = factor + a * b;                                                               %sum (G_s * G_c)
                    end
                end %window end
                for m= 1:cha    %mean shifts
                    output_img1(i,j,m) = weighted_factor(m)/factor; 
                end
            end  
        end
         output_img = output_img1;
     end
   
     
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
     imshow(mat2gray(output_img));
     title("Image"); h = gca; h.Visible = 'on';
     cb=colorbar;
     cb.Position = cb.Position + [0.1, 0.01,0,0];
toc; 
    
    