function final_image = myBilinearInterpolation(input_image,a,b)
%a = new pixels to be added along the columns for each square 
%b = new pixels to be added along the rows for each square
tic;
[m,n] = size(input_image);
mf = m + a*(m-1);
nf = n + b*(n-1);
for i = 1:m-1
    for j = 1:n-1
        for x = 0:(a+1)
            if x~=(a+1)
                for y = 0:(b+1) 
                    if y ~= b+1
                        value = Bilinear(input_image,(i+(x/(a+1))),(j+(y/(b+1))));
                        final_image((i-1)*(a+1)+x+1,(j-1)*(b+1)+y+1) = value;
                    elseif y==b+1
                        %edge case, giving a value here almost = 1 and not
                        %1 so as to prevent going out of bounds
                        value = Bilinear(input_image,(i+(x/(a+1))),0.9999999999999*(j+(y/(b+1))));
                        final_image((i-1)*(a+1)+x+1,(j-1)*(b+1)+y+1) = value;
                    end;
                end;
            elseif x==a+1
                for y = 0:(b+1) 
                    %edge case, giving a value here almost = 1 and not
                    %1 so as to prevent going out of bounds
                    if y ~= b+1
                        value = Bilinear(input_image,(i+(0.999999999999*x/(a+1))),(j+(y/(b+1))));
                        final_image((i-1)*(a+1)+x+1,(j-1)*(b+1)+y+1) = value;
                    elseif y==b+1
                        value = Bilinear(input_image,(i+(0.999999999999*x/(a+1))),0.99999999999*(j+(y/(b+1))));
                        final_image((i-1)*(a+1)+x+1,(j-1)*(b+1)+y+1) = value;
                    end;
                end;
            end;
        end;
    end;
end;