function rgbImage = myHE(orig_img)
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
        while(B(ind) == 0)
            ind = ind +1;
        end
        
        C = [B, B];
        
        %finding hist value for each pixel
        x = B(ind);
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
    
    
    figure('Name','origial_he','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(orig_img);
    title("Original Image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
    
    figure('Name','HE','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap gray;axis tight;
    daspect ([1 1 1]);
    imshow(rgbImage);
    title("he"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
    
end
