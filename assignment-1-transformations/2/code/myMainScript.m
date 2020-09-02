%% MyMainScript
clear;
addpath('./bitmask.m');
addpath('./myLinearContrastStretching.m');
addpath('./myHE.m');
addpath('./myHM.m');
addpath('./myCLAHE.m');
tic;
%% Your code here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img1 = imread('../data/barbara.png');
img2 = imread('../data/TEM.png');
img3 = imread('../data/canyon.png');
img4 = imread('../data/retina.png');
img4ref = imread('../data/retinaRef.png');
img5 = imread('../data/church.png');
img6 = imread('../data/chestXray.png');
img8 = imread('../data/statue.png');
img9 = imread('../data/masked_image.PNG');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Foreground Mask
out = myForegroundMask(img8);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linear Contrast Stretching
myLinearContrastStretching(img1);
%myLinearContrastStretching(img2);
%myLinearContrastStretching(img3);
%myLinearContrastStretching(img5);
%myLinearContrastStretching(img6);
%myLinearContrastStretching(img9);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Histogram Equalization
% myHE(img1);
% myHE(img2);
% myHE(img3);
myHE(img5);
% myHE(img6);
% myHE(img9);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Histogram Matching (HM) 
myHM(img4, img4ref);
myHE(img4);

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Contrast-Limited Adaptive Histogram Equalization (CLAHE)
%%%%img1%%%%
myCLAHE(img1, 64, 0.1);
% myCLAHE(img1, 256, 0.1);
% myCLAHE(img1, 32, 0.1);
% myCLAHE(img1, 64, 0.05);
% %%%%img2%%%%
% myCLAHE(img2, 64, 0.1);
% myCLAHE(img2, 256, 0.1);
% myCLAHE(img2, 32, 0.1);
% myCLAHE(img2, 64, 0.05);
% %%%%img3%%%%
% myCLAHE(img3, 64, 0.1);
% myCLAHE(img3, 256, 0.01);
% myCLAHE(img3, 32, 0.01);
% myCLAHE(img3, 32, 0.005);
% %%%%img6%%%%
% myCLAHE(img6, 64, 0.1);
% myCLAHE(img6, 256, 0.1);
% myCLAHE(img6, 32, 0.1);
% myCLAHE(img6, 64, 0.05);