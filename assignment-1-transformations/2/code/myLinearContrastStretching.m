function myLinearContrastStretching(orig_img)
    
    [~,~,k] = size(orig_img);
    fin_img = double(zeros(size(orig_img)));
    for i=1:k
        max_val = double(max(orig_img(:,:,i),[],'all'));
        min_val = double(min(orig_img(:,:,i),[],'all'));
        
        fin_img(:,:,i) = (double(orig_img(:,:,i)) - min_val) / (max_val - min_val);
        fin_img(:,:,i) = (fin_img(:,:,i)) * 255.0;
    end
    
    fin_img = uint8(fin_img);
   
    figure('Name','origial linear contrast','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap gray; axis tight;
    daspect ([1 1 1]);
    imshow(orig_img);
    title("Original Image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
    
    figure('Name','linear_contrast','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(fin_img);
    title("linear contrast"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
 
    
end