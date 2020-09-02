function final_image = myNearestNeighbor(img, p, q)  
    [n,m] = size(img);
    r = p*(n-1)+1;
    s = q*(m-1)+1;
    final_image = zeros(r, s);
    
    for i = 1:r %row
        for j = 1:s %column
            if(rem(i,p)==1 && rem(j,q)==1)
                final_image(i,j) = img(floor(i/p)+1, floor(j/q)+1);
            else
                final_image(i,j) = myNearVal(img, i, j, p, q, n, m);
            end %if else
        end %for col 
    end %for row
    
return;