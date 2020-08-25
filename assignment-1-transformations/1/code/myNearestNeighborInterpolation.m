function val = nearval(img, i, j, p, q, n, m)
    t = fix(i/p) + 1;
    r = fix(j/q) + 1;
    val = img(t,r);
    mini = i-t + j-r;
    if(t+p-i+j-r < mini && t+1 < n)
        mini = t+p-i+j-r;
        val = img(t+1, r);
    elseif(i-t+r+q-j < mini && r+1 < m)
        mini = i-t+r+q-j;
%         disp(r)
%         disp(m)
        val = img(t, r+1);
    elseif(t+p-i+r+q-j < mini && t+1 < n && r+1 < m)
        %mini = t+p-i+j-r;
        val = img(t+1, r+1);
    end
end

function final_image = myNearestNeighbor(img, p, q)  
    [n,m] = size(img);
    r = p*(n-1)+1;
    s = q*(m-1)+1;
    final_image = zeros(r, s);
    
    for i = 1:r %row
        for j = 1:s %column
            if(rem(i,p)==1 && rem(j,q)==1)
                final_image(i,j) = img(fix(i/p)+1, fix(j/q)+1);
            else
                final_image(i,j) = nearval(img, i, j, p, q, n, m);
            end %if else
        end %for col 
    end %for row
    
end