%%
close all;
rng 'default' 
tic;
%%  
alpha_f = 10;
alpha_b = 20;
Iflower = imread('../data/flower.jpg');
IBird = imread('../data/bird.jpg');

sampled_img = imresize(double(Iflower),0.5);
%applying gaussian blurring 
I_down_flower = imgaussfilt(sampled_img,0.66);

sampled_img = imresize(double(IBird),0.5);
%applying gaussian blurring 
I_down_bird = imgaussfilt(sampled_img,0.66);


load('../images/bird.mat') 
load('../images/flower.mat')
%%
%[output_img_f] = myMeanShiftSegmentation(I_down_flower,20,15,15);
% [output_img_b] = myMeanShiftSegmentation(I_down_bird,30,20,15);

%mask_flower = mask_gen(output_img_f);
% mask_bird = mask_gen(output_img_b);

%[output_img_flower,distance_f] =  mySpatiallyVaryingKernel(I_down_flower, alpha_f,~mask_flower);
% [output_img_bird,distance_b] =  mySpatiallyVaryingKernel(I_down_bird, alpha_b,~mask_bird);

toc;
%%
figure;
subplot(2,2,1);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mat2gray(I_down_flower)); title('Original Image');
 h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];

subplot(2,2,2);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mat2gray(output_img_flower)); title('Background blurred');
h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];

subplot(2,2,3);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mat2gray(distance_f)); title('Radius'); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];

subplot(2,2,4);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mask_flower); title('Mask'); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
%%
figure;

subplot(2,2,1);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mat2gray(I_down_bird)); title('Original Image');
 h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];

subplot(2,2,2);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mat2gray(output_img_bird)); title('Background blurred');
h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];

subplot(2,2,3);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mat2gray(distance_b)); title('Radius'); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];

subplot(2,2,4);
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
colormap (myColorScale);
colormap jet; axis tight;
daspect ([1 1 1]);
imshow(mask_bird); title('Mask'); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
%%
function [mask1] = mask_gen(I)
    [r,c,~] = size(I);
    mask= rgb2gray(mat2gray(I))>0.4;
    a=bwconncomp(mask);
    linear_idx=a.PixelIdxList;

    for i=1:size(linear_idx,2)
        sizes(i)=size(linear_idx{1,i},1);
    end
    [b,c1]=max(sizes);
    linear_idx = linear_idx{1,c1};
    mask1 = zeros(r,c);
    for i = 1:b
        mask1( mod(linear_idx(i),r),round(linear_idx(i)/r)) =1;
    end
    mask1 = imfill(mask1);
end