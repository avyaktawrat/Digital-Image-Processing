% clear all;
% close all;
% rng 'default';

%% flower
tic;
img_1 = imread("../data/flower.jpg");
h_s      = 8;
h_r      = 15;
segments = 18;
segmented_img = myMeanShiftSegmentation(img_1, h_s, h_r);
cluster(segmented_img, segments);
toc;
%% baboon
% tic;
% img_2 = imread("../data/baboonColor.png");
% h_s       = 8;
% h_r       = 15;
% segments  = 20;
% segmented_img = myMeanShiftSegmentation(img_2, h_s, h_r);
% cluster(segmented_img, segments);
% toc;
% this takes a some time to run the image is stored can can be seen by
% uncommenting the below code
% load('../data/baboon_colorspace.mat');
% cluster(output_img, 20);
%% bird
% tic;
% img_3 = imread("../data/bird.jpg");
% h_s       = 20;
% h_r       = 30;
% segments  = 10;
% segmented_img = myMeanShiftSegmentation(img_3, h_s, h_r);
% cluster(segmented_img, segments);
% toc;
% this takes a some time to run the image is stored can can be seen by
% uncommenting the below code
% load('../data/bird__colorspace.mat');
% cluster(output_img, 10);
%% when both spatial and rgb coordinates are updated
% clear all;
% close all;
% rng 'default';
% tic;
%% flower
% img_1 = imread("../data/flower.jpg");
% h_s      = 8;
% h_r      = 15;
%segments = 15;
%segmented_img = myMeanShiftSegmentation2(img_1, h_s, h_r);
%cluster(segmented_img, segments);
% toc;
%% baboon
% tic;
% img_2 = imread("../data/baboonColor.png");
% h_s       = 15;
% h_r       = 15;
% segments  = 22;
% segmented_img = myMeanShiftSegmentation2(img_2, h_s, h_r);
% cluster(segmented_img, segments);
% toc;
% this takes a some time to run the image is stored can can be seen by
% uncommenting the below code
%load('../data/baboon_both_gradient.mat');
%cluster(imgh, 22);
%% bird
% tic;
% img_3 = imread("../data/bird.jpg");
% h_s       = 20;
% h_r       = 30;
% segments  = 15;
% segmented_img = myMeanShiftSegmentation2(img_3, h_s, h_r);
% cluster(segmented_img, segments);
% toc;
% this takes a some time to run the image is stored can can be seen by
% uncommenting the below code
% load('../data/bird_both_gradient.mat');
% cluster(imgh, 15);