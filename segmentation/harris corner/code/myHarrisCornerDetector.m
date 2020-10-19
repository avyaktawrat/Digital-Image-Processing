function myHarrisCornerDetector(imageOrig,s1,s2,w_size,k)
    %%
    [m,n] = size(imageOrig);
    a_min = (w_size+1)/2;
    a_max = m + (w_size+1)/2 - 1;

    imgOrig = imageOrig;
    imageOrig = (imageOrig - min(imageOrig,[],'all'))/(max(imageOrig,[],'all')-min(imageOrig,[],'all'));
    imgOrigPad = zeros(m+w_size-1,n+w_size-1);
    imgOrigPad(a_min:a_max, a_min:a_max)= imageOrig;

    gaussian_mat = fspecial('gaussian', 5, s1);
    sobel_mat = fspecial('sobel');
    image_gaus  = imfilter(imgOrigPad, gaussian_mat);
    image_y_der = imfilter(image_gaus,sobel_mat);
    image_x_der = imfilter(image_gaus,transpose(-sobel_mat));

    %% structure tensor for corner point (a1,a2)
    A = zeros(m+w_size-1,n+w_size-1,2,2);
    w_gaus_mat = fspecial('gaussian', w_size, s2);

    for a1= a_min:a_max
        for a2= a_min:a_max
            % all computations for u,v in a w_size patch around a1,a2
            for u = 1:w_size
                for v = 1:w_size
                    % x and y are absolute coordinates of patch
                    x = a1 + u - (w_size+1)/2;
                    y = a2 + v - (w_size+1)/2;
                    Ix_sq = (image_x_der(x,y))*(image_x_der(x,y));
                    Iy_sq = (image_y_der(x,y))*(image_y_der(x,y));
                    Ixy = image_x_der(x,y)*image_y_der(x,y);
                    deriv_mat = [Ix_sq, Ixy; Ixy, Iy_sq];

                    w_temp = w_gaus_mat(u,v).*deriv_mat;
                    %w_temp = deriv_mat/5;
                    A(a1,a2,1,1) = A(a1,a2,1,1) + w_temp(1,1);
                    A(a1,a2,2,1) = A(a1,a2,2,1) + w_temp(2,1);
                    A(a1,a2,1,2) = A(a1,a2,1,2) + w_temp(1,2);
                    A(a1,a2,2,2) = A(a1,a2,2,2) + w_temp(2,2);

                end
            end
        end
    end
    %% remove padding 516X516X2X2 -> 512X512X2X2
    A = A(a_min:a_max,a_min:a_max,:,:);

    %%
    % update eigen values for each pixel (a1,a2)
    imgEigenP = zeros(m,n);
    imgEigenQ = zeros(m,n);
    imgC1 = zeros(m,n);
    %%
    for a1 = 1:m
        for a2 = 1:n
            B(1,1) = A(a1,a2,1,1);
            B(1,2) = A(a1,a2,1,2);
            B(2,1) = A(a1,a2,2,1);
            B(2,2) = A(a1,a2,2,2);

            V = eigs(B);
            imgEigenP(a1,a2) = V(1);
            imgEigenQ(a1,a2) = V(2);
            imgC1(a1,a2) = V(1)*V(2) - k*(V(1) + V(2))*(V(1) + V(2));
        end
    end
    %% Non Maximal Suppression
    for a1 = 1:m
        for a2 = 1:n
            cor = imgC1(a1,a2);
            condn = false;
            for i=a1-1:a1+1
                for j=a2-1:a2+1
                    if(i>0 && i< m+1 && j>0 && j<n+1)
                        condn = condn || (cor<imgC1(i,j));
                    end
                end
            end
            if (condn)
                imgC1(a1,a2) = min(imgC1,[],'all');
            end
        end
    end
    %%
    image_gaus = image_gaus(a_min:a_max,a_min:a_max);
    figure(1)
    subplot(1,2,1)
    imagesc(imageOrig);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Original Image');
    
    subplot(1,2,2)
    imagesc(image_gaus);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Blurred Image');
    
    figure(2)
    imagesc(image_y_der);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Derivative along Y');
%     
    figure(3)
    imagesc(image_x_der);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Derivative along X');
    
    figure(4)
    imagesc(imgEigenP);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Principal Eigen Value Plot');

    figure(5)    
    imagesc(imgEigenQ);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Second Eigen Value');
    
    figure(6)
    imgC2 = imgC1;
    for i = 1:512
        for j = 1:512
            if imgC1(i,j) < 0.02*max(imgC1,[],'all')
                imgC2(i,j) = min(imgC1,[],'all');
            end
        end
    end
    
    imagesc(imgC2);
    myNumofColors = 200;
    myColorScale = [[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]',[0:1/(myNumofColors-1):1]'];
    colormap jet;
    daspect([1 1 1]);
    axis tight;
    colormap(myColorScale);
    colorbar;
    title('Cornerness');
    %image_gaus = image_gaus(a_min:a_max,a_min:a_max);
    figure(10); imshow(uint8(image_gaus*256), []); 
    title('Corners Label');
    hold on;
    %mx = max(max(imgC2));
    for i= 1:512
        for j = 1:512
            if imgC1(i, j) >= 0.05*max(imgC1,[],'all')
                plot(j, i, 'r+');
            end
        end
    end
end
