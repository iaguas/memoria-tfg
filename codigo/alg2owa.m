% TRABAJO FINAL DE GRADO - ALGORITMO 2, DEL ÁREA
% Inigo Aguas Ardaiz
% UPNA, 25 de junio de 2015.

% Algoritmo 2 para segmentar la imagen utilizando funciones OWA
% para la creación de los conjuntos difusos.
function [tseg, segImg] = alg2owa(I, tipoREF, tipoOWA)

    % Cardinal total de intensidades de gris.
    L = 256;
    Lminus1 = L-1;

    % Se muestrea la pertenencia de cada elemento a la imagen.
    hq = [(0:Lminus1)' imhist(I)]; % Vectores columna, [t-1, hist(t-1)].
    sumHist = sum(hq(:,2)); % Constante para acelerar el cómputo.

    % 1. Seleccionamos los automorfismos 1 y 2. (Se indican en cada tipo).

    % 2. Bucle sobre los umbrales t
    A = zeros(0,L);
    % 2.1. Calculamos el área
    if(tipoREF==1)
        % (i) aut1=x y aut2=x
        for t=0:Lminus1
            A(t+1) = sumHist - (sum(hq(1:t+1,2)'.* abs((0:t)/Lminus1 - owab(hq,t,tipoOWA))) + ...
                sum(hq(t+2:L,2)'.* abs((t+1:Lminus1)/Lminus1 - owao(hq,t,L,tipoOWA))));
        end
    elseif(tipoREF==2)
        % (ii) aut1=x^d, aut2=x y d=0.5
        d=1/2;
        for t=0:Lminus1
           A(t+1) = sum(hq(1:t+1,2)'.*(1-abs((0:t)/Lminus1 - owab(hq,t,tipoOWA))).^(1/d)) + ...
                sum(hq(t+2:L,2)'.*(1-abs((t+1:Lminus1)/Lminus1 - owao(hq,t,L,tipoOWA))).^(1/d));
        end
    elseif(tipoREF==3)
        % (ii) aut1=x^d, aut2=x y d=2
        d=2;
        for t=0:Lminus1
            A(t+1) = sum(hq(1:t+1,2)'.*(1-abs((0:t) - owab(hq,t,tipoOWA))).^(1/d)) + ...
                sum(hq(t+2:L,2)'.*(1-abs((t+1:Lminus1) - owao(hq,t,L,tipoOWA))).^(1/d));
        end
    else
        % (iii) aut1=1-(1-x)^0.5 y aut2=x
        for t=0:Lminus1
            A(t+1) = sumHist - (sum(hq(1:t+1,2)'.*((0:t)/Lminus1 - owab(hq,t,tipoOWA)).^2) + ...
                sum(hq(t+2:L,2)'.*((t+1:Lminus1)/Lminus1 - owao(hq,t,L,tipoOWA)).^2));
        end
    end

    % 3. Tomar como umbral el valor con mayor área en 2.1.
        invt = find(A == max(A))-1;
        tseg = round(mean(invt));

        segImg=I;
        segImg(I>tseg(1))=255;
        segImg(I<=tseg(1))=0;
end
