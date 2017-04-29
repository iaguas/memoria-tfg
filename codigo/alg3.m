 % Segmentación utilizando REF y maximizando SM
 % Proyecto Beca 2014 - ALGORITMO 3, del umbral óptimo.
 % Iñigo Aguas Ardaiz
 % 19/07/2014

function [tseg, segImg, similitud] = alg3(I)
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
        [t, ~] = alg2(I, i);
        allt(i) = t;
        Qt = fuzzySets(hq, i, t, L);

        % 1. Seleccionamos un operador M y una REF3.
          % M = Media aritmética.
          % REF3 = 1-|x-y|^2.

        % 2. Para cada uno de los mejores umbrales t
            % 2.1. Construir el conjunto Ht
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

    % 3. Elegir aquel con máxima similitud.
    invt = find(similitud == max(similitud)); % Funciona siempre que exista un sólo máximo local.
    tseg = allt(invt(1));

    % Muestra de la imagen y el resultado.
    figure;
    segImg=I;
    segImg(I>tseg(1))=255;
    segImg(I<=tseg(1))=0;
%     subplot(1,2,1); imshow(I)
%     subplot(1,2,2); imshow(segImg)
end

% Función de similitud
function s = SM(h,Qt,HQt)
    sumHist = sum(h(:,2));
    mult1 = 1 / sumHist;
    mult2 = (1 - (Qt - HQt).^2)*h(:,2);
    s = mult1 * mult2;
end

% Para calcular Qt
function Qt = fuzzySets(hq, tipoREF, t, L)

    Lminus1 = L-1;

    % Creamos los L conjuntos difusos para una t dada.
    for q=0:t
        Qt(q+1) = REF1(q/Lminus1, mb(hq, t)/Lminus1, tipoREF);
    end
    for q = t+1:Lminus1
        Qt(q+1) = REF1(q/Lminus1, mo(hq, t, L)/Lminus1, tipoREF);
    end
end

% Funciones REF utilizadas en para calcular Qt que corresponde con la REF
% que dan los automorfimos en cada caso.
function eql = REF1(x,y,tipo)
    if tipo==1
        eql = 1 - abs(x-y);
    elseif tipo==2
        eql = (1 - abs(x-y)).^0.5;
    elseif tipo==3
        eql = (1 - abs(x-y)).^2;
    elseif tipo==4
        eql = 1 - abs(x-y).^2;
    end
end

% Media de los píxeles del fondo (background).
function m = mb(Q, t)
    m = sum(Q(1:t+1,2).*Q(1:t+1,1))/sum(Q(1:t+1,2));
    if isnan(m)
        m=0;
    end
end

% Media de los píxeles del objeto.
function m = mo(Q, t, L)
    m = sum(Q(t+2:L,2).*Q(t+2:L,1))/sum(Q(t+2:L,2));
    if isnan(m)
        m=0;
    end
end
