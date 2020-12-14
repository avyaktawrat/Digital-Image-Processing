close all;
clear;
tic;
for p = 13 : 13
    if p < 10
        root = "dataset1/dataset/image_000";
    else
        root = "dataset1/dataset/image_00";
    end
    filename = strcat(root, int2str(p));
    filename = strcat(filename, '.jpg');

im = imread(filename);
img = double(im);
for i=1:5
    tic;
    img_smooth = myBilateral(img,4,8);
    toc;
end
end