function val = myNearVal(img, i, j, p, q, n, m)
    
    t = floor(i/p);
    r = floor(j/q);

    if(t == 0)
        t = 1;
    end
    if(r == 0)
        r = 1;
    end
    val = img(t,r);
    mini = i-t + j-r;
    if(t+p-i+j-r < mini && t+1 < n)       
        mini = t+p-i+j-r;
        val = img(t+1, r);
    end
    if(i-t+r+q-j < mini && r+1 < m)
        mini = i-t+r+q-j;
        val = img(t, r+1);
    end
    if(t+p-i+r+q-j < mini && t+1 < n && r+1 < m)
        val = img(t+1, r+1);
    end
return;