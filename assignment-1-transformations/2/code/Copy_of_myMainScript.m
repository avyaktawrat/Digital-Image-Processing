clear;
%% MyMainScript
addpath('bitmask.m');
addpath('myLinearContrastStretching.m');
addpath('myHE.m');
addpath('myHM.m');
tic;
%% Your code here


img_1 = imread('../data/barbara.png');
% img_2 = imread('../data/TEM.png');
% img_3 = imread('../data/canyon.png');
% img_4 = imread('../data/retina.png');
% img_4ref = imread('../data/retinaRef.png');
img_5 = imread('../data/church.png');
% img_6 = imread('../data/chestXray.png');

% img_7 = imread('../data/statue.png');
% zeros(size(img_3))
% R = img_3(:,:,1); 
% G = img_3(:,:,2); 
% B = img_3(:,:,3);
% figure(1)
% myHE(img_3);
figure(2);
myHE(img_1);
figure(3);
myHE(img_5);
%myHE(img_3);
% figure(5);
% myHE(img_5);
% figure(3);
% myHM(img_4,img_4ref);


%%%%%%%%%%%%%%%%%%%%%2a%%%%%%%%%%%%%%%%%%


toc;

