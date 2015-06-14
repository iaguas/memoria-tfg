 % Segmentacion utilizando REF y maximizando SM
 % Proyecto Beca 2014 - ALGORITMO 1, general.
 % Iñigo Aguas Ardaiz
 % 16/07/2014
 
function [tseg, segImg] = alg1(I, tipoREF1, d)

    % Si no se introduce d, automaticamente se utiliza 1.
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
        % 1.2. Calculamos la función de pertenencia a traves de las medias de 1.1.
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

% Funciones REF utilizadas en el primer lugar.
function eql = REF1(x, y, tipo, d)
    if tipo==1
        eql = 1 - abs(x-y);
    elseif tipo==2
        eql = 1 - abs(x-y).^2;
    elseif tipo==3
        eql = 1 - abs(x-y).^0.5;
    elseif tipo==4
        eql = (1 - abs(x-y)).^2;
    elseif tipo==5
        eql = (1 - abs(x-y)).^0.5;
    elseif tipo==6 % Con los operadores de equivalencia de Dombi d=0.5 (No es una REF)
        eql = .5*(1+((1-2*x)^d)*((1-2*y)^d));
    end
end

%Funciones REF utilizadas en el segundo lugar.
function eql = REF2(x, y)
    eql = 1 - abs(x-y).^2;
end

% Media de los pixeles del fondo (background).
function m = mb(Q, t)
    m = sum(Q(1:t+1,2).*Q(1:t+1,1))/sum(Q(1:t+1,2));
    if isnan(m)
        m=0;
    end
end

% Media de los pixeles del objeto.
function m = mo(Q, t, L)
    m = sum(Q(t+2:L,2).*Q(t+2:L,1))/sum(Q(t+2:L,2));
    if isnan(m)
        m=0;
    end
end