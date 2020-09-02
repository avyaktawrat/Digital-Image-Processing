%% MyMainScript
clear
tic;
%% Your code here
% The code will be equalizing two sub-histograms seperately, unlike
% histogram equalization. Hence referred to as Bi-Histogram equalization.
% Division is done about a = median

orig_img = imread('../data/statue.png');
[m,n,k] = size(orig_img);
fin_img = zeros(size(orig_img));


figure(1);
myHE(orig_img);

%% find Histogram
val = zeros(256, 1);
%finding probability distribution
for i = 1:m  %row
    for j = 1:n %col
        val(orig_img(i,j,1) + 1, 1) = val(orig_img(i,j,1) + 1, 1) + 1;  
    end
end 
%finding cumulative distribution
B = cumsum(val);
B_eq = cumsum(val); % for doing a comparision with hist equalized img
%finding median a

cdf_half = B(256) / 2;
a = 1;

while(B(a)<=cdf_half)
    a = a+1;
end
sum1 = B(a);

for i = a+1:256
    B(i) = B(i) - B(a);
end
sum2 = B(256);

%finding min cdf for hist 1 and hist 2

ind1 = 1;
while(B(ind1) == 0)
    ind1 = ind1 + 1;
end

ind2 = a+1;
while(B(ind2) == 0)
    ind2 = ind2 + 1;
end

C = [B, B];

%finding hist value for each pixel
cdf_min1 = B(ind1);
cdf_min2 = B(ind2);
for i = ind1:a
    C(i,2) = round(((a-1) * (C(i,1) - cdf_min1))/(sum1 - cdf_min1));
end

for i = ind2:256
    C(i,2) = round(((257-a) * (C(i,1) - cdf_min2))/(sum2 - cdf_min2));
end

for i = 1:m  %row
    for j = 1:n %col
        fin_img(i,j,1) = C(orig_img(i,j,1) + 1 ,2);  
    end
end

fin_img = uint8(fin_img);

figure(2);
subplot(1,2,1), imshow(orig_img)
axis on
axis tight
cb = colorbar;
cb.Position = cb.Position + [0,0,0,0];
title('Original Image')

subplot(1,2,2), imshow(fin_img)
axis on
axis tight
cb = colorbar;
cb.Position = cb.Position + [0,0,0,0];
title('Bi-Histogram about Median')
toc;