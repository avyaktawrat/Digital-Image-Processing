%% MyMainScript
clear all;
tic;
rng('default')
%% Barbara
load('../data/barbara.mat');
[final_image_2, rmsd_2,ans1] = myBilateralFiltering(imageOrig, 1.3, 10.4);
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(imageOrig);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(final_image_2);
title("Bilateral Filtered Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
%% Grass
imageOrig = imread('../data/grass.png');
[final_image_2, rmsd_2,ans1] = myBilateralFiltering(imageOrig, 1, 38.3);
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(imageOrig);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(final_image_2);
title("Bilateral Filtered Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
%% HoneyCombReal
imageOrig = imread('../data/honeyCombReal.png');
[final_image_2, rmsd_2,ans1] = myBilateralFiltering(imageOrig, 1, 43.4);
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(imageOrig);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imagesc(final_image_2);
title("Bilateral Filtered Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.09, 0.01,0,0];