% TRABAJO FINAL DE GRADO - UMBRALIZACION GLOBAL
% Inigo Aguas
% UPNA, 25 de junio de 2015.

% Funcion que implementa el algoritmo 1 para las funciones de Dombi.
function [tseg, segImg] = alg1(I, tipoREF1, d)

    % Si no se introduce d, autom?ticamente se utiliza 1.
    if nargin < 3
        d = 1;
    end

    % Cardinal total de intensidades de gris.
    L = 256;
    Lminus1 = 255;

    % Muestro la pertenencia de cada elemento a la imagen (histograma).
    hq = [(0:L-1)' imhist(I)]; % Vectores columna, [t, hist(t)].

    % 1. Creamos los L conjuntos difusos para una t dada.
    Qt = zeros(L);
    for t=0:Lminus1
        % 1.1. Dividimos la imagen en dos clases, Cb y Co y calculamos su media.
        % 1.2. Calculamos la funcion de pertenencia a traves de las medias de 1.1.
        for q=0:t
            Qt(q+1, t+1) = REF1(q/Lminus1, mb(hq, t)/Lminus1, tipoREF1, d);
        end
        for q = t+1:Lminus1
            Qt(q+1, t+1) = REF1(q/Lminus1, mo(hq, t, L)/Lminus1, tipoREF1, d);
        end
    end
    Qt(isnan(Qt))=0; % Se retiran los NaN que se producen.

    % 2. Seleccionamos la REF2 como x y M como la media aritmetica.
    % Se dispone de la funcion REF2(x,y) que implementa 1-|x-y|^2.

    % 3. Calcular la similitud entre el conjunto Qt y el conjunto 1.
    sumHist = sum(hq(:,2));
    similitud = zeros(1, L);
    for t = 0:L-1
        similitud(t+1) = sum(hq(:,2).*REF2(1,Qt(:,t+1))) / sumHist;
    end
    
    % 4. Tomar como umbral el mejor valor de similud para el apartado
    % anterior.
    invt = find(similitud == max(similitud))-1;
    tseg = round(mean(invt));
    
    % Se crea la imagen resultado.
    segImg=I;
    segImg(I>tseg(1))=255;
    segImg(I<=tseg(1))=0;
end