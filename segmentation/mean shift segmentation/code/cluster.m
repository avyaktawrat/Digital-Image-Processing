function cluster(img, segments)

[x,y,~] = size(img);

img_matrix = zeros(x,y,5);
for i = 1:x
    for j = 1:y
        img_matrix(i, j, 1) = img(i,j,1);
        img_matrix(i, j, 2) = img(i,j,2);
        img_matrix(i, j, 3) = img(i,j,3);
        img_matrix(i, j, 4) = i;
        img_matrix(i, j, 5) = j;
    end
end

P = reshape(img_matrix, [x*y, 5]);
[idx,C,] = kmeans(P,segments);

%assigning values of centroid to the segment
for i = 1:(x*y)
    c_no = idx(i);
    P(i,:) = C(c_no,:);
end

clustered = reshape(P, [x,y, 5]);
clustered = clustered(:,:,1:3);

     figure;
     subplot(1,2,1);
     myNumOfColors = 1000000;
     myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
     colormap (myColorScale);
     colormap jet; axis tight;
     daspect ([1 1 1]);
     imshow(mat2gray(img));
     title("Original Image"); h = gca; h.Visible = 'on';
     cb=colorbar;
     cb.Position = cb.Position + [0.1, 0.01,0,0];
     
     subplot(1,2,2);  
     myNumOfColors = 1000000;
     myColorScale = [ [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]', [0:1/(myNumOfColors-1):1]' ];
     colormap (myColorScale);
     colormap jet; axis tight;
     daspect ([1 1 1]);
     imshow(mat2gray(clustered));
     title("clustured Image"); h = gca; h.Visible = 'on';
     cb=colorbar;
     cb.Position = cb.Position + [0.1, 0.01,0,0];
end
     