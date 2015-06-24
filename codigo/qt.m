% Para calcular Qt
function Qt = fuzzySets(hq, tipoREF, t, d, L)
    Lminus1 = L-1;

    % Creamos los L conjuntos difusos para una t dada.
    Qt = zeros(1, L);
    for q=0:t
        Qt(q+1) = REF1(q/Lminus1, mb(hq, t)/Lminus1, tipoREF, d);
    end
    for q = t+1:Lminus1
        Qt(q+1) = REF1(q/Lminus1, mo(hq, t, L)/Lminus1, tipoREF, d);
    end
end