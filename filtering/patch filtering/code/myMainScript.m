%% MyMainScript
clear all;
close all;
tic;
rng('default')
%% Your code here
tic;
load('../data/barbara.mat');
imageOrig1 = imageOrig(:,:)/100;
gaussian_mat = fspecial('gaussian', 5, 0.66);
imageOrig1  = imfilter(imageOrig1, gaussian_mat);
imageOrig2 = imageOrig1(1:2:end, 1:2:end);

imageOrig_grass = im2double(imread('../data/Grass.png'));

imageOrig_honey = im2double(imread('../data/honeyCombReal.png'));
imageOrig_honey1 = imageOrig_honey(:,:);
imageOrig_honey1  = imfilter(imageOrig_honey1, gaussian_mat);
imageOrig_honey2 = imageOrig_honey1(1:2:end, 1:2:end);

%% The final tuned parameters are as follows
h1 = 0.238;
h2 = 0.227;
h3 = 0.24;
%%
[final_image_1,ans1,noise_1] = myPatchBasedFiltering(imageOrig2,h1);
[final_image_2,ans2,noise_2] = myPatchBasedFiltering(imageOrig_grass,h2);
[final_image_3,ans3,noise_3] = myPatchBasedFiltering(imageOrig_honey2,h3);
toc;
%%

subplot(1,3,1);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (imageOrig2)); % phantom is a popular test image
title('Original Image'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
subplot(1,3,2);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc ( (noise_1)); % phantom is a popular test image
title('Noise added Image'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
subplot(1,3,3);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (final_image_1)); % phantom is a popular test image
title('Filtered Image' ); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;

figure;
subplot(1,3,1);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (imageOrig_grass)); % phantom is a popular test image
title('Original Image'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
subplot(1,3,2);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc ( (noise_2)); % phantom is a popular test image
title('Noise added Image'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
subplot(1,3,3);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (final_image_2)); % phantom is a popular test image
title('Filtered Image' ); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;


figure ;
subplot(1,3,1);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (imageOrig_honey2)); % phantom is a popular test image
title('Original Image'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
subplot(1,3,2);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc ( (noise_3)); % phantom is a popular test image
title('Noise added Image'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
subplot(1,3,3);
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (final_image_3)); % phantom is a popular test image
title('Filtered Image'  ); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;
%%
[X,Y] = meshgrid(-4:4,-4:4);
weightS = exp(-((X).^2+(Y).^2)/(2*4^2));
figure
myNumOfColors = 100000;
myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
imagesc (single (weightS)); % phantom is a popular test image
title('Gaussian Mask'); h =gca; h.Visible = 'on';
colormap (myColorScale);
colormap gray;
daspect ([1 1 1]);
axis tight;