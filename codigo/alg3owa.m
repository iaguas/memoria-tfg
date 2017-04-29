% TRABAJO FINAL DE GRADO - ALGORITMO 3, DEL UMBRAL OPTIMO
% Inigo Aguas Ardaiz
% UPNA, 25 de junio de 2015.

% Algoritmo 3 para segmentar la imagen utilizando el algoritmo 2 como base.
function [tseg, segImg, similitud] = alg3owa(I, tipoOWA)
    % Cardinal total de intensidades de gris.
    L = 256;
    Lminus1 = L-1;

    % Muestreo la pertenencia de cada elemento a la imagen.
    hq = [(0:L-1)' imhist(I)]; % Vectores columna, [t, hist(t)].

    % 0. Hacemos el algoritmo 1 con diferentes REF y guardamos los mejores
    % umbrales.
    allt = zeros(1,4);
    similitud = zeros(1, 6);
    HQt = zeros(1, L);
    for i=1:4
        [t, ~] = alg2owa(I, i, tipoOWA);
        allt(i) = t;
        Qt = fuzzySets(hq, i, t, L, tipoOWA);

        % 1. Seleccionamos un operador M y una REF3.
          % M = Media aritmética.
          % REF3 = 1-|x-y|^2.

        % 2. Para cada uno de los mejores umbrales t
            % 2.1. Construir el conjunto Ht
            for q=0:L-1
                if q <= t
                    HQt(q+1) = owab(hq, t, tipoOWA);
                else
                    HQt(q+1) = owao(hq, t, L, tipoOWA);
                end
            end
            HQt(isnan(HQt))=0;

            % 2.2. Calcular la similitud
            similitud(i) = SM(hq, Qt, HQt);
    end

    % 3. Elegir aquel con máxima similitud.
    invt = find(similitud == max(similitud));
    tseg = allt(invt(1));

    % Muestra de la imagen y el resultado.
    segImg=I;
    segImg(I>tseg(1))=255;
    segImg(I<=tseg(1))=0;
end
