%% MyMainScript
clear
load('./data/boat.mat');
w_size = 7;
sig1 = 0.5;
sig2 = 0.9;
k = 0.22;
tic;
%% Your code here
myHarrisCornerDetector(imageOrig,sig1,sig2,w_size,k);

toc;