function fin_img = myHE(orig_img)
    [m,n,k] = size(orig_img);
    fin_img = zeros(size(orig_img));
    
    for l = 1:k  %number of channels
        val = zeros(256, 1);
        %finding probability distribution
        for i = 1:m  %row
            for j = 1:n %col
                val(orig_img(i,j,l) + 1, 1) = val(orig_img(i,j,l) + 1, 1) + 1;  
            end
        end 
        %finding cumulative distribution
        B = cumsum(val);
        %finding first non zero term 
        x = B(1);
        ind = 1;
        while(x==0)
            ind = ind +1;
            x = B(ind);
        end
        
        C = [B, B];
        
        %finding hist value for each pixel
        for i = ind:256
            C(i,2) = round((255 * (C(i,1) - x))/(m*n - x));
        end
        
        for i = 1:m  %row
            for j = 1:n %col
                fin_img(i,j,l) = C(orig_img(i,j,l) + 1 ,2);  
            end
        end   
        
        rgbImage(:,:,l) = uint8(fin_img(:,:,l));
    end  
    
    subplot(1,2,1), imshow(orig_img)
    axis on;
    axis tight;
    cb = colorbar;
    cb.Position = cb.Position + [.1, 0,0,0];
    title('Original Image')
    
    
    subplot(1,2,2), imshow(rgbImage);
    axis on;
    axis tight;
    cb = colorbar;
    cb.Position = cb.Position + [.1, 0,0,0];
%     bb = colorbar('location','EastOutside');
    title('hist eq Image')
    
end

% 
% function fin_img = myHE(orig_img)
%     [m,n,k] = size(orig_img);
%     fin_img = zeros(size(orig_img));
%     
%     for l = 1:k  %number of channels
%         val = zeros(256, 1);
%         %finding probability distribution
%         for i = 1:m  %row
%             for j = 1:n %col
%                 val(orig_img(i,j,l) + 1, 1) = val(orig_img(i,j,l) + 1, 1) + 1;  
%             end
%         end 
%         %finding cumulative distribution
%         B = cumsum(val);
%         %finding first non zero term 
%         x = B(1);
%         ind = 1;
%         while(x==0)
%             ind = ind +1;
%             x = B(ind);
%         end
%         
%         C = [B, B];
%         
%         %finding hist value for each pixel
%         for i = ind:256
%             C(i,2) = round((255 * (C(i,1) - x))/(m*n - x));
%         end
%         
%         for i = 1:m  %row
%             for j = 1:n %col
%                 fin_img(i,j,l) = C(orig_img(i,j,l) + 1 ,2);  
%             end
%         end   
%         
%         rgbImage(:,:,l) = uint8(fin_img(:,:,l));
%     end  
%     
%     subplot(1,2,1), imshow(orig_img)
%     axis on;
%     cb = colorbar;
% %     cb.Position = cb.Position + [.1, 0,0,0];
%     title('Original Image')
%     
%     
%     subplot(1,2,2), imshow(rgbImage);
%     axis on;
%     cb = colorbar;
% %     cb.Position = cb.Position + [.2, 0,0,0];
%     title('hist eq Image')
%     
% end
% 
% 
