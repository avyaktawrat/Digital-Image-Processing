function myLinearContrastStretching(orig_img)
    max_val = (max(orig_img,[],'all'));
    min_val = (min(orig_img,[],'all'));
    
    fin_img = (orig_img - min_val) / (max_val - min_val);
    fin_img = fin_img .* 255;
    
    subplot(1,2,1), imshow(orig_img)
    axis on
    colorbar
    title('Original Image')
    
    subplot(1,2,2), imshow(fin_img)
    axis on
    colorbar
    title('Linear Contrast Image')
    
end