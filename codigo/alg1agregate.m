% TRABAJO FINAL DE GRADO - UMBRALIZACION GLOBAL
% Inigo Aguasç
% UPNA, 25 de junio de 2015.

% Funcion que implementa el algoritmo 1 para las funciones de Dombi
% utilizando las funciones penalti.
function [tseg, segImg] = alg1agregate(I, tipoREF1)

% Cardinal total de intensidades de gris.
L = 256;
Lminus1 = 255;
% Muestro la pertenencia de cada elemento a la imagen.
hq = [(0:L-1)' imhist(I)]; % Vectores columna, [t, hist(t)].

    % 1. Creamos los L conjuntos difusos paçra una t dada.
    for t=0:Lminus1
        % 1.1. Dividimos la imagen en dos clases, Cb y Co y calculamos su media.
        % 1.2. Calculamos la función de pertenencia a través de las medias de 1.1.
        for q=0:t
            Qt(q+1, t+1) = agregateREF1(q/Lminus1, mb(hq, t)/Lminus1); 
        end
        for q = t+1:Lminus1
            Qt(q+1, t+1) = agregateREF1(q/Lminus1, mo(hq, t, L)/Lminus1); 
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



