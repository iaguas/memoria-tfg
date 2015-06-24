% TRABAJO FINAL DE GRADO - ALGORITMO 3, DEL UMBRAL OPTIMO
% Inigo Aguas
% UPNA, 25 de junio de 2015.

 % Función que implementa el algoritmo 3 para varios valores w de la funcion
 % de Dombi.
function [tseg, segImg, similitud] = alg3c(I)

    % Cardinal total de intensidades de gris.
    L = 256;
    Lminus1 = L-1;

    % Muestreo la pertenencia de cada elemento a la imagen.
    hq = [(0:L-1)' imhist(I)]; % Vectores columna, [t, hist(t)].

    % 0. Hacemos el algoritmo 1 con diferentes REF y guardamos los mejores
    % umbrales.
    allt = zeros(1, 6);
    similitud = zeros(1, 6);
    HQt = zeros(1, L);
    d = [0.1, 0.5, 0.75, 1, 1.25, 1.5, 2, 5];
    for i=1:length(d)  
        [t, ~] = alg1(I, 6, d(i));
        allt(i) = t;
        Qt = fuzzySets(hq, 6, t, d(i), L);

        % 1. Seleccionamos un operador M y una REF3.
          % M = Media aritmética.
          % REF3 = 1-|x-y|^2.

        % 2. Para cada uno de los mejores umbrales t 
            % 2.1. Construir el conjunto HQt
            for q=0:L-1
                if q <= t
                    HQt(q+1) = mb(hq, t) / Lminus1;
                else
                    HQt(q+1) = mo(hq, t, L) / Lminus1;
                end
            end
            HQt(isnan(HQt))=0;

            % 2.2. Calcular la similitud
            similitud(i) = SM(hq, Qt, HQt);    
    end 

    % 3. Elegir aquel con maxima similitud. 
    invt = find(similitud == max(similitud)); 
    tseg = allt(invt(1));
    
    % Crea la imagen final.
    segImg=I;
    segImg(I>tseg(1))=255;
    segImg(I<=tseg(1))=0;
end