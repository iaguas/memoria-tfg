% Media de los píxeles del fondo (background).
function m = mb(Q, t)
    m = sum(Q(1:t+1,2).*Q(1:t+1,1))/sum(Q(1:t+1,2));
    if isnan(m)
        m=0;
    end
end
