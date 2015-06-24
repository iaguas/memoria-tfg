function eql = agregate(r, tipo)
    n=6;
    if tipo==1
        eql = mean(r);
    elseif tipo==2
        %w = [1/3, 1/3, 1/3, 0, 0, 0];
        rsort = sort(r);
        eql = sum(w.*rsort);
    elseif tipo==3
        [xsigma, sig] = sort(r);
        m0 = (sig(1:n)/n).^2;
        m1 = [(sig(2:n)/n).^2 0];
        w = m0-m1;
        eql = sum(w.*xsigma);
    elseif tipo==4
        eql = min(r);
    elseif tipo==5
        eql = max(r);
    elseif tipo==6
        eql = max(0, sum(r-(n-1))) * geomean(r);
    elseif tipo==7
        eql = geomean(r);
    end
end