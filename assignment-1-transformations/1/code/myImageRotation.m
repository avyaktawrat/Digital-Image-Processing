function im2 = myImageRotation(im1, theta);
im1copy = im1;
[m,n] = size(im1);

for i = 1:m
    for j = 1:floor((n)/2)
        temp = im1(i,j);
        im1(i,j) = im1(i,m-j);
        im1(i,m-j) = temp;
    end;
end;
        
im2 = zeros(uint8(m*sqrt(3)),uint8(n*sqrt(3)));
[mm,nn] = size(im2);
for i = 1:2*m-1
    for j = 1:2*n-1
        x1 = 52 - sin(theta)*(j-mm/2)+cos(theta)*(i-nn/2);
        y1 = 52 - sin(theta)*(i-nn/2)-cos(theta)*(j-mm/2);
        if x1<=m && x1>=1 && y1<=m && y1>=1
            %x = floor(x1);
            %y = floor(y1);
            %xf = x1 - x;
            %yf = y1 - y;
            %value = xf*yf*im1(x+1,y+1) + (1-xf)*(1-yf)*im1(x,y) + (1-xf)*yf*im1(x,y+1) + (1-yf)*xf*im1(x+1,y);
            value = Bilinear(im1,x1,y1);
            im2(i,j) = value;
        end;
    end;
end;