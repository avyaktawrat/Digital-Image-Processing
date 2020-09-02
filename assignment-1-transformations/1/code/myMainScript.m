%% Question1 : Image Resize and Rotation

%% myShrinkImageByFactorD
%%
% We aim to demonstrate the Moire Effect in this case by undersampling the
% original image by 2 and 3 times
%% 
circ_conc = imread('../data/circles_concentric.png');
 d_2 = myShrinkImageByFactorD(circ_conc,2);
 d_3 = myShrinkImageByFactorD(circ_conc,3);
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(circ_conc);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(d_2);
title("Subsampled Image with d = 2"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.2, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(d_3);
title("Subsampled Image with d = 3"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.3, 0.01,0,0];
%%
% Every alternate pixel has been selected in the middle image and every
% third pixel has been selected in the right image. Moire Effect is evident
% here and as d = 3 has a higher level of undersampling, the effect is
% better observed there
%% myBilinearInterpolation
%%
% We enlarge the image in this case by using a simple bilinear
% interpolation technique, wherein we've specifically given inputs to our
% function such that an image of size [m,n] is enlarged into an image of
% size [3m-2,2n-1]
%%
barbara_small = imread('../data/barbaraSmall.png');
 bilinear = myBilinearInterpolation(barbara_small,2,1);%2 new pixels to be added between 2 rows and 1 new pixel to be added between 2 columns
 figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(barbara_small);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
figure;
myNumOfColors = 100000;
 myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
 imagesc (single (bilinear)); % phantom is a popular test image
 title('Bilinear Interpolation Result'); h =gca; h.Visible = 'on';
 colormap (myColorScale);
 colormap gray;
 daspect ([1 1 1]);
 axis tight;
 colorbar
cb.Position = cb.Position + [0.2, 0.01,0,0];
%%
% We've implemented Bilinear interpolation by reading 2x2 squares across
% the image matrix and interpolating the values for pixels midway and
% storing the new 4x3 rectangle obtained in this case in a new matrix. The
% height has been roughly increased to 3x and width to 2x
 %% myNearestNeighborInterpolation
 %%
% We enlarge the image in this case by using the Nearest Neighbor interpolation technique, wherein we've specifically given inputs to our
% function such that an image of size [m,n] is enlarged into an image of
% size [3m-2,2n-1]
%%
nearestneighbor = myNearestNeighbor(barbara_small,(2+1),(1+1));
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(barbara_small);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
figure;
myNumOfColors = 100000;
 myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
 imagesc (single (nearestneighbor)); % phantom is a popular test image
 title('Nearest Neighbor Interpolation Result'); h =gca; h.Visible = 'on';
 colormap (myColorScale);
 colormap gray;
 daspect ([1 1 1]);
 axis tight;
 colorbar
cb.Position = cb.Position + [0.2, 0.01,0,0];
%%
% We've implemented Nearest Neighbor interpolation by reading 2x2 squares across
% the image matrix and interpolating the values for pixels midway and
% storing the new 4x3 rectangle obtained in this case in a new matrix. The
% height has been roughly increased to 3x and width to 2x
%% myBicubicInterpolation
%%
% We enlarge the image in this case by using the Bicubic Interpolation technique, wherein we've specifically given inputs to our
% function such that an image of size [m,n] is enlarged into an image of
% size [3m-2,2n-1]
% %%
% [m, n, C] = size(barbara_small);
% mf = 3*m-2; nf = 2*n-1;
% bicubic = zeros(mf, nf, C);
% for i = 0:mf-1
%     i_scaled = i/(mf-1);
%     for j = 0:nf-1
%        j_scaled = j/(nf-1);
%        bicubic(i+1, j+1, :) = myBicubicInterpolation(origBarbara, j_scaled, i_scaled);
%     end
% end
bicubic = myBicubicInterpolation(barbara_small)
 figure;
 
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(barbara_small);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
figure;
myNumOfColors = 100000;
 myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
 imagesc (single (bicubic)); % phantom is a popular test image
 title('Bicubic Interpolation Result'); h =gca; h.Visible = 'on';
 colormap (myColorScale);
 colormap gray;
 daspect ([1 1 1]);
 axis tight;
 colorbar
cb.Position = cb.Position + [0.2, 0.01,0,0];

%%
% We've implemented Bicubic interpolation by reading 2x2 squares across
% the image matrix and interpolating the values for pixels midway and
% storing the new 4x3 rectangle obtained in this case in a new matrix. The
% height has been roughly increased to 3x and width to 2x
%% Analyse all the enlargements
%%
% We will analyse the results of the 3 methods obtained above using the jet
% colormap to compare the methods

%%
[m,n] = size(barbara_small);
bilinear_crop = bilinear(1:m,n:end);
nearestneighbor_crop = nearestneighbor(1:m,n:end);
bicubic_crop = bicubic(1:m,n:end);
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap jet;axis tight;
daspect ([1 1 1]);
imagesc(bilinear_crop);
title("Bilinear Cropped Picture"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap jet;axis tight;
daspect ([1 1 1]);
imagesc(nearestneighbor_crop);
title("Nearest Neighbor Cropped Picture"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.2, 0.01,0,0];
figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap jet;axis tight;
daspect ([1 1 1]);
imagesc(bicubic_crop);
title("Bicubic Cropped Picture"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.3, 0.01,0,0];
%%
% Bicubic gives the best that is the smoothest results compared to bilinear
% interpolation. Also, nearest neighbor gives the worst results as expected
%% myImageRotation
%%
% We will rotate the image clockwise by 30 degrees in this part
%%
imrotated = myImageRotation(barbara_small, pi/6);
 figure;
myNumOfColors = 1000000;
myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ]; 
colormap (myColorScale);
colormap gray;axis tight;
daspect ([1 1 1]);
imshow(barbara_small);
title("Original Image"); h = gca; h.Visible = 'on';
cb=colorbar;
cb.Position = cb.Position + [0.1, 0.01,0,0];
figure;
myNumOfColors = 100000;
 myColorScale = [ [0:1/(myNumOfColors-1):1]' ,[0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
 imagesc (single (imrotated)); % phantom is a popular test image
 title('Rotation Result'); h =gca; h.Visible = 'on';
 colormap (myColorScale);
 colormap gray;
 daspect ([1 1 1]);
 axis tight;
 colorbar
cb.Position = cb.Position + [0.2, 0.01,0,0];
%%
% The image has been rotated in the clockwise direction by rotating the
% pixels of the final image anti clockwise by 30 degrees and finding the
% value there using bilinear interpolation. One could interpret this as
% basically rotating the entire grid anticlockwise by 30 degrees