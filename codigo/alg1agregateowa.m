% TRABAJO FINAL DE GRADO - ALGORITMO 1 AGREGADO Y OWA
% Inigo Aguas
% UPNA, 25 de junio de 2015.

% Algoritmo 1 para segmentar la imagen agregado con funciones penalti
% y utilizando owa para crear los conjuntos difusos.
function [tseg, segImg] = alg1agregateowa(I, tipoOWA)

% Cardinal total de intensidades de gris.
    L = 256;
    Lminus1 = 255;
    % Muestro la pertenencia de cada elemento a la imagen.
    hq = [(0:L-1)' imhist(I)]; % Vectores columna, [t, hist(t)].

    % 1. Creamos los L conjuntos difusos para una t dada.
    for t=0:Lminus1
        % 1.1. Dividimos la imagen en dos clases, Cb y Co y calculamos su media.
        % 1.2. Calculamos la función de pertenencia a través de las medias de 1.1.
        for q=0:t
            Qt(q+1, t+1) = agregateREF1(q/Lminus1, owab(hq, t, tipoOWA)); % TODO OPTIMIZAR!!
        end
        for q = t+1:Lminus1
            Qt(q+1, t+1) = agregateREF1(q/Lminus1, owao(hq, t, L, tipoOWA)); % TODO OPTIMIZAR!!
        end
    end
    % Para retirar el NaN que se produce
    Qt(isnan(Qt))=0;

    % 2. Seleccionamos la REF2 como x y M como la media aritmética. TODO!
    % En realidad ya esta seleccionada. REF2(x,y)=1-|x-y|^2.
        
    % 3. Calcular la similitud entre el conjunto Qt y el conjunto 1.
    sumHist = sum(hq(:,2));
    for t = 0:L-1
        similitud(t+1) = sum(hq(:,2).*REF2(1,Qt(:,t+1))) / sumHist;
    end
    % 4. Tomar como umbral el mejor valor de similud para el apartado
    % anterior.
    invt = find(similitud == max(similitud))-1; % Funciona siempre que exista un solo maximo local.
    tseg = round(mean(invt));
    

    % Muestra de la imagen y el resultado.
    segImg=I;
    segImg(I>tseg(1))=255;
    segImg(I<=tseg(1))=0;
end