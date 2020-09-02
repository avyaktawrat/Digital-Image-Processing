
function myCLAHE(img_1, grid_size, thresh)
    [m,n,g] = size(img_1);
    thresh = thresh * grid_size*grid_size;
    c = floor( grid_size/ 2 );
    %applying padding to image
    pad_img = padarray(img_1,[c, c], 0, 'both');
    output_img = zeros(size(img_1));

    for l = 1:g  %number of channels
        for a = grid_size:m+2*c-1 %row
            val = zeros(256, 2);

            %find distribtion
            for i = 1:grid_size %row
                for j = 1:grid_size %col
                    if(pad_img(a-grid_size+i,j,l) > 0)
                        val(pad_img(a-grid_size+i,j,l) + 1, 1) = val(pad_img(a-grid_size+i,j,l) + 1, 1) + 1;
                    end
                end
            end
            %extra grid_sizeixels & cdf
            num=0;
            if(val(1,1) > thresh)
                val(1,2) = thresh;
                num = val(1,1) - thresh;
            else
                val(1,2) = val(1,1);
            end

            for j = 2:256
                if(val(j,1) > thresh)
                    num = num +val(j,1) - thresh;
                    val(j,2) = val(j-1,2) + thresh;
                else
                    val(j,2) = val(j-1,2) + val(j,1);
                end
            end
            %adding extra pi
            multiple = floor(num /256);
            remainder =  rem(num, 256);

            for j = 1:256
                if(j<=remainder)
                    val(j,2) = val(j,2) + j + j * multiple;
                else
                    val(j,2) = val(j,2) + j * multiple;
                end
            end

            ind = 1;
            while(val(ind,2)==0 && ind < 256)
                ind = ind +1;
            end
            x = val(ind,2);

            j = pad_img(a-c+1 ,a-c+1, l) + 1;
            output_img(a-grid_size+1, 1, l) = round((255 * (val(j,2) - x))/(grid_size*grid_size - x));


            for b = grid_size+1:n+2*c-1  %col
                %after moving one stegrid_size ahead in matrix conv, only the values of
                %one column(last) get's added and the first column of last
                %convolution grid gets deleted
                for j = 1:grid_size
                    if(pad_img(a-grid_size+j,b,l) > 0)
                        val(pad_img(a-grid_size+j,b,l) + 1, 1) = val(pad_img(a-grid_size+j,b,l) + 1, 1) + 1;
                    end
                    if(pad_img(a-grid_size+j,b-grid_size,l) > 0)
                        val(pad_img(a-grid_size+j,b-grid_size,l) + 1, 1) = val(pad_img(a-grid_size+j,b-grid_size,l) + 1, 1) - 1;
                    end
                end% updated grid_size(x)
                %finding num of pixels > thresh and cdf
                num=0;
                if(val(1,1) > thresh)
                    val(1,2) = thresh;
                    num = val(1,1) - thresh;
                else
                    val(1,2) = val(1,1);
                end
                %cdf
                for k = 2:256
                    if(val(k,1) > thresh)
                        num = num +val(k,1) - thresh;
                        val(k,2) = val(k-1,2) + thresh;
                    else
                        val(k,2) = val(k-1,2) + val(k,1);
                    end
                end

                %adding extra grid_sizeixels equally to all
                multiple = num /256;
                remainder =  rem(num, 256);

                for j = 1:256
                    if(j<=remainder)
                        val(j,2) = val(j,2) + j + j * multiple;
                    else
                        val(j,2) = val(j,2) + j * multiple;
                    end
                end

                %finding minimum non emgrid_sizety entry
                ind = 1;
                while(val(ind,2)==0 && ind < 256)
                    ind = ind +1;
                end
                x = val(ind,2);
                j = pad_img(a-c+1 ,b-c, l) + 1;
                output_img(a-grid_size+1, b-grid_size+1, l) = round((255 * (val(j,2) - x))/(grid_size*grid_size - x));

            end %col

        end %row
        rgbImage(:,:,l) = uint8(output_img(:,:,l));

    end %channel

     figure('Name','origial_clahe','NumberTitle','off');
     myNumOfColors = 1000000;
     myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
     colormap (myColorScale);
     colormap jet; axis tight;
     daspect ([1 1 1]);
     imshow(img_1);
     title("Original Image"); h = gca; h.Visible = 'on';
     cb=colorbar;
     cb.Position = cb.Position + [0.1, 0.01,0,0];

    figure('Name','clahe_transformed','NumberTitle','off');
    myNumOfColors = 1000000;
    myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
    colormap (myColorScale);
    colormap jet;axis tight;
    daspect ([1 1 1]);
    imshow(rgbImage);
    title("clahe"); h = gca; h.Visible = 'on';
    cb=colorbar;
    cb.Position = cb.Position + [0.1, 0.01,0,0];

end
