function final_image = myBicubicInterpolation(input_image);
[m,n] = size(input_image);
%padding the image on all 4 sides to ease computation of derivatives at the
%boundary
input_image = [input_image(:,1),input_image,input_image(:,103)];
input_image = [input_image(1,:);input_image;input_image(103,:)];
a_1 = cast([1,0,0,0 ; 0,0,1,0 ; -3,3,-2,-1 ; 2,-2,1,1],'double');
a_2 = cast([1,0,-3,2 ; 0,0,3,-2 ; 0,1,-2,1 ; 0,0,-1,1], 'double');
final_image = zeros(3*m-2,2*n-1);
for y1 = 2:m
    for x1 = 2:m
%computing values for the matrix 
    f00 = input_image(y1,x1);
    f10 = input_image(y1, x1+1);
    f01 = input_image(y1+1,x1);
    f11 = input_image(y1+1, x1+1);
    
    fx00 = 0.5 * (input_image(y1, x1+1) - input_image(y1, x1-1));
    fx10 = 0.5 * (input_image(y1, x1+2) - input_image(y1, x1));
    fx01 = 0.5 * (input_image(y1+1,x1+1) - input_image(y1+1,x1-1));
    fx11 = 0.5 * (input_image(y1+1,x1+2) - input_image(y1+1,x1));
    
    fy00 = 0.5 * (input_image(y1+1,x1) - input_image(y1-1,x1));
    fy10 = 0.5 * (input_image(y1+1, x1+1) - input_image(y1-1,x1+1));
    fy01 = 0.5 * (input_image(y1+2, x1) - input_image(y1, x1));
    fy11 = 0.5 * (input_image(y1+2, x1+1) - input_image(y1,x1+1));
    
    fxy00 = 0.25 * (input_image(y1+1, x1+1) - input_image(y1+1, x1-1) - input_image(y1-1,x1+1) + input_image(y1-1,x1-1));
    fxy10 = 0.25 * (input_image(y1+1, x1+2) - input_image(y1+1, x1) - input_image(y1-1,x1+2) + input_image(y1-1, x1));
    fxy01 = 0.25 * (input_image(y1+2, x1+1) - input_image(y1+2, x1-1) - input_image(y1, x1+1) + input_image(y1, x1-1));
    fxy11 = 0.25 * (input_image(y1+1, x1+2) - input_image(y1+1, x1) - input_image(y1-1,x1+2) + input_image(y1-1, x1));
    
    B = double([f00 f01 fy00 fy01;
                f10 f11 fy10 fy11;
                fx00 fx01 fxy00 fxy01;
                fx10 fx11 fxy10 fxy11]);
    %computing the coefficients of the bicubic equation 
        b_matrix = a_1 * B;
        a_matrix = b_matrix * a_2;
        for b = 0:3
            for a = 0:2
                %finding values at the pixels
                value = [1,(a/2),(a/2)^2,(a/2)^3]*a_matrix*[1;(b/3);(b/3)^2;(b/3)^3];
                final_image(3*(y1-1)-2+b,2*(x1-1)-1+a) = value;
            end;
        end;
    end;
end;
return;