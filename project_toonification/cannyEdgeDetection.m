function [edge_final ]= cannyEdgeDetection(img)

%Input image
img = rgb2gray(img);
img = double (img);

%Value for Thresholding
T_Low = 0.075;
T_High = 0.1;

[x,y] = meshgrid(-2:2,-2:2);
space_gaussian = exp(-(x.^2+y.^2)/(2*(2^2)));
space_gaussian = space_gaussian /sum(sum(space_gaussian));

%Convolution of image by Gaussian Coefficient
A=conv2(img, space_gaussian, 'same');

%Sobel Filter for horizontal and vertical direction
KGx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy = [1, 2, 1; 0, 0, 0; -1, -2, -1];
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');

%Calculate directions/orientations
grad_angle = atan2 (Filtered_Y, Filtered_X);
grad_angle = grad_angle*180/pi;
n_rows=size(A,1);
n_cols=size(A,2);
%Adjustment for negative directions, making all directions positive
for i=1:n_rows
    for j=1:n_cols
        if (grad_angle(i,j)<0) 
            grad_angle(i,j)=360+grad_angle(i,j);
        end
    end
end

%Calculate magnitude
magnitude = (Filtered_X.^2) + (Filtered_Y.^2);
magnitude2 = sqrt(magnitude);
BW = zeros (n_rows, n_cols);
%Non-Maximum Supression
for i = 3 : n_rows-2
    for j = 3 : n_cols-2
        sgnx = -1;
        sgny = -1;
         if (grad_angle(i,j) >= 0 && grad_angle(i,j) <=90) || (grad_angle(i,j) >= 270 && grad_angle(i,j) <= 360)
             sgnx = +1;
         end
         if (grad_angle(i,j) >= 0 && grad_angle(i,j) <=180)
             sgny = +1;
         end
         costheta = abs(cos(grad_angle(i,j)*2*pi/360));
         sintheta = abs(sin(grad_angle(i,j)*2*pi/360));
         mag1 = magnitude2(i,j) * ((1-costheta)*(1-sintheta)) + magnitude2(i,j+1*sgny) * (costheta*(1-sintheta)) + magnitude2(i-1*sgnx,j) * (sintheta*(1-costheta)) + magnitude2(i-1*sgnx,j+1*sgny) * (sintheta*costheta);
         mag2 = magnitude2(i,j) * ((1-costheta)*(1-sintheta)) + magnitude2(i,j-1*sgny) * (costheta*(1-sintheta)) + magnitude2(i+1*sgnx,j) * (sintheta*(1-costheta)) + magnitude2(i+1*sgnx,j-1*sgny) * (sintheta*costheta); 
         if magnitude2(i,j) < mag1 || magnitude2(i,j) < mag2
             magnitude2(i,j) = 0;
         end
         mag3 = magnitude2(i,j) * ((1-costheta)*(1-sintheta)) + magnitude2(i,j+2*sgny) * (costheta*(1-sintheta)) + magnitude2(i-2*sgnx,j) * (sintheta*(1-costheta)) + magnitude2(i-2*sgnx,j+2*sgny) * (sintheta*costheta);
         mag4 = magnitude2(i,j) * ((1-costheta)*(1-sintheta)) + magnitude2(i,j-2*sgny) * (costheta*(1-sintheta)) + magnitude2(i+2*sgnx,j) * (sintheta*(1-costheta)) + magnitude2(i+2*sgnx,j-2*sgny) * (sintheta*costheta);
         if magnitude2(i,j) < mag3 || magnitude2(i,j) < mag4
             magnitude2(i,j) = 0;
         end
    end
end
BW = magnitude2;

%Hysteresis Thresholding
T_Low = T_Low * max(max(BW));
T_High = T_High * max(max(BW));
T_res = zeros (n_rows, n_cols);
for i = 2  : n_rows-1
    for j = 2 : n_cols-1
        if (BW(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (BW(i, j) > T_High)
            T_res(i, j) = 1;
        elseif ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High && BW(i,j) > T_Low)
            T_res(i,j) = 1;
        end
    end
end
% for c = 1: 10
%     for i = 2 : n_rows - 1
%         for j = 2 : n_cols - 1
%             if  ((BW(i+1,j)>T_Low && T_res(i+1,j) == 1)|| (BW(i-1,j)>T_Low && T_res(i-1,j) == 1)|| (BW(i,j+1)>T_Low && T_res(i,j+1) == 1)|| (BW(i,j-1)>T_Low && T_res(i,j-1) == 1)&& BW(i,j) > T_Low)
%                 T_res(i,j) = 1;
%             end
%         end
%     end
% end
edge_final = uint8(T_res.*255);
%Show final edge detection result
% figure, imshow(edge_final);
end