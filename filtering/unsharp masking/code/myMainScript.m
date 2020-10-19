%% MyMainScript
clear;
tic;
%% Your code here
%% image lion
inp_img1 = load('../data/lionCrop.mat').imageOrig;

grid_size = 5;
scale_p = 3;
sigma = 2;

myUnsharpMasking(inp_img1, grid_size, scale_p, sigma);


%% image moon
% inp_img2 = load('../data/superMoonCrop.mat').imageOrig; 
% 
% grid_size = 7;
% scale_p = 8;
% sigma = 2;
% 
% myUnsharpMasking(inp_img2, grid_size, scale_p, sigma);
toc;
