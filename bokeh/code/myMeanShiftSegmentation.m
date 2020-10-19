function [output_img] = myMeanShiftSegmentation(sampled_img,h_r,h_s,iteration)

  [r,c,cha] = size(sampled_img);
    output_img = sampled_img;
    output_img1 = zeros(r,c,cha);
window_range = 4 * h_s;
    for iter = 1:iteration
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
                        a = exp( - ((k - i) ^ 2 + (l - j) ^ 2) / (2 * (h_s)^2));              %spatial gaussian
                        b = exp(-(X/(2 * h_r^2)));                                            %colour space gaussian
                        for m=1:cha
                            weighted_factor(m) = weighted_factor(m) + a * b * double((output_img(k,l,m)));      %sum (weighted average) 
                        end
                        factor = factor + a * b;                                              %sum (G_s * G_c)
                    end
                end %window end
                for m= 1:cha    %mean shifts
                    output_img1(i,j,m) = weighted_factor(m)/factor; 
                end
            end  
        end
         output_img = output_img1;
     end
     end