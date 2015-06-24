% Media de los pixeles del objeto.
function m = mo(Q, t, L)
    m = sum(Q(t+2:L,2).*Q(t+2:L,1))/sum(Q(t+2:L,2));
    if isnan(m)
        m=0;
    end
end