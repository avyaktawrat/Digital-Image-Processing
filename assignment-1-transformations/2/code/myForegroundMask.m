function [masked_img] = myForegroundMask(thres, orig_img)

    max_val = (max(orig_img,[],'all'));
    %[m,n] = size(orig_img);
    
    bin_mask = orig_img>thres; % max_val = ?
    bin_mask = uint8(bin_mask);
    
    masked_img = orig_img .* (bin_mask);
   
    subplot(1,3,1), imshow(orig_img)
    axis on
    colorbar
    title('Original Image')
    
    subplot(1,3,2), imshow(bin_mask * max_val)
    axis on
    colorbar
    title('bit mask')
    
    subplot(1,3,3), imshow(masked_img)
    axis on
    colorbar
    title('masked image')

end