function final_image = myShrinkImageByFactorD(input_image,d)
tic;
%undersampling the image by a factor of d
final_image = input_image(1:d:end,1:d:end);
return;