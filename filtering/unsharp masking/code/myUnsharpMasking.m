function myUnsharpMasking(inp_img, grid_size, scale_p, sigma)
    
    gaussian_mat = fspecial('gaussian', grid_size, sigma);
    output_img1  = imfilter(inp_img, gaussian_mat);
    output_img1 = inp_img + scale_p * (inp_img - output_img1);
    output_img = mat2gray(output_img1);
    output_img2 = imadjust(output_img1, stretchlim(output_img1),[0,1]);
    
    figure('Name','origial_unsharp_mask','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)' ]; 
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(inp_img);
    title("Original Image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];

    figure('Name','output_of_unsharp_mask','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)' ]; 
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(output_img1);
    title("output image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
    
    figure('Name','manual_lcs_unsharp mask','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)' ]; 
    colormap (myColorScale);
    colormap gray;axis tight;
    daspect ([1 1 1]);
    imshow(output_img);
    title("linear contrasted image"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
    
    figure('Name','inbuild_lcs_unsharp_mask','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)', (0:1/(myNumOfColors-1):1)' ]; 
    colormap (myColorScale);
    colormap jet; axis tight;
    daspect ([1 1 1]);
    imshow(output_img2);
    title("lcs using inbuild func"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];
end
