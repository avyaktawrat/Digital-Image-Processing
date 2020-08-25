%% MyMainScript
addpath('myShrinkImageByFactorD.m');
addpath('myNearestNeighborInterpolation.m');
tic;
%% Your code here

%circ_conc = imread('circles_concentric.png')
barbara_small = imread('barbaraSmall.png');

%%%%%%%%%%%%%%%%%%%%%1a%%%%%%%%%%%%%%%%%%
% subplot(1,3,1), imshow(circ_conc)
% axis on
% colorbar
% title('Original Image')
% 
% scale_2 = myShrinkImageByFactorD(circ_conc, 2)
% subplot(1,3,2), imshow(scale_2)
% axis on
% colorbar
% title('Scale by 2')
% 
% scale_3 = myShrinkImageByFactorD(circ_conc, 3)
% subplot(1,3,3), imshow(scale_3)
% axis on
% colorbar
% title('scale by 3')

%%%%%%%%%%%%%%%%%%%%%1c%%%%%%%%%%%%%%%%%%
final_image = myNearestNeighbor(barbara_small, 3, 2) 

subplot(1,2,1), imshow(barbara_small);
axis on;
colorbar;
title('Original Image');

subplot(1,2,2), imshow(final_image, [0,255]);
axis on;
colorbar;
title('nearest neighbour');

toc;

