function [masked_img] = myForegroundMask(orig_img)
    
    thres = mean(orig_img,'all');
    
    bin_mask = orig_img>thres;
    bin_mask = uint8(bin_mask);
    
    masked_img = orig_img .* bin_mask;
    bin_mask = bin_mask * 255;
    
    figure('Name','origial_bitmask','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap gray; axis tight;
    daspect ([1 1 1]);
    imshow(orig_img);
    title("Original Image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
    
    figure('Name','bitmask','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap gray; axis tight;
    daspect ([1 1 1]);
    imshow(bin_mask);
    title("Bitmask"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
     
    figure('Name','masked image','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap gray;axis tight;
    daspect ([1 1 1]);
    imshow(masked_img);
    title("masked Image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];

end