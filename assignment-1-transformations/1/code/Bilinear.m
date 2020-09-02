function value = Bilinear(image,x,y)
 x1 = double(floor(x));
 y1 = double(floor(y));
 xf = x - x1;
 yf = y - y1;
 value = xf*yf*double(image(x1+1,y1+1)) + (1-xf)*(1-yf)*double(image(x1,y1)) + (1-xf)*yf*double(image(x1,y1+1)) + (1-yf)*xf*double(image(x1+1,y1));
 return;