% Agregación de las posibles funciones REF.
function eql = agregateREF1(a, b)
    % Sacamos todas las REF posibles.
    tipos = [1:5 6];
    for i=1:length(tipos)
        r(i) = REF1(a,b,tipos(i));
    end
    r(isnan(r))=0;

    % Agregamos los resultados anteriores en todas sus formas.
    numAgregate = 7;
    for i=1:numAgregate
        ag(i) = agregate(r,i);
    end

    n = 6;
    numPenalty = numAgregate;
    for i=1:numPenalty
        p(i) = sum(abs(r-ag(i))) / n;
    end

    where = find(p == min(p));
    eql = ag(where(1));
end
