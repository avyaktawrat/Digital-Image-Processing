close all;
clearvars;
tic;
for p = 16 : 16
    if p < 10
        root = "dataset1/dataset/image_000";
    else
        root = "dataset1/dataset/image_00";
    end
    filename = strcat(root, int2str(p));
    filename = strcat(filename, '.jpg');

im = imread(filename);
img = double(im);
%%
a = 24;  % Quantization Factor
img_smooth = img;
%% Apply Median Filter to remove Salt and Pepper noise
img_smooth(:,:,1) = medfilt2(img(:,:,1),[7,7]);
img_smooth(:,:,2) = medfilt2(img(:,:,2),[7,7]);
img_smooth(:,:,3) = medfilt2(img(:,:,3),[7,7]);

%% Apply Bilateral filter multiple times
for i=1:3
%     tic;
    img_smooth = myFastBilateral(img_smooth,4,8,2,2);
%     toc;
end
% tic
% img_smooth = bilateral_video(img_smooth);
% toc
filtered = img_smooth;

%% Obtain edges of the image using Canny Edge Detection
edges = cannyEdgeDetection(im);

%% Edge Dilation
edges = conv2(edges/255, [1,1;1,1], 'same');
for i = 1 : size(edges,1)
    for j = 1 : size(edges,2)
        if edges(i,j) > 0
            edges(i,j) = 1;
        end
    end
end
edges = edges * 255;
% imshow(edges);
% edges = edgedetector(img);
% disp(size(edges));
% edges = edges/max(edges(:));
cartoon_img = filtered;

%% Quantisation
for i = 1:3
    % Quantize the Values
    t = a*floor(filtered(:,:,i)./a);
%     t(edges>0.18) = 0;
    t(edges==255) = 0;
    cartoon_img(:,:,i) = t;
end

%% Display Results
figure
subplot(1,3,3)
imshow(mat2gray(cartoon_img));
title('Cartoon')
subplot(1,3,1)
imshow(mat2gray(img));
title('Original')
subplot(1,3,2)
imshow(mat2gray(edges));
impixelinfo;
% colorbar;
title('Edges')

end
toc