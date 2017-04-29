% TRABAJO FINAL DE GRADO - UMBRALIZACIÓN GLOBAL
% Inigo Aguas Ardaiz
% UPNA, 25 de junio de 2015.

% Este sencillo método propone una forma rápida de obtener un umbral.
function [t, segImg] = globalThresholding(I)

    % 1. Seleccionamos un umbral inicial.
    t0 = 128;

    % 2. Se segmenta la imagen usando t0. Esto producirá dos grupos de pixeles,
    % G1 y G2.
    G1 = I(I>t0);
    G2 = I(I<=t0);

    % 3. Se computa la media de la intensidad de los valores de ambos grupos.
    m1 = mean(G1(:));
    m2 = mean(G2(:));

    % 4. Se recalcula el valor del umbral, t:
    t = 0.5*(m1+m2);

    % 5. Se repiten los pasos anteriores hasta comprobar que la diferencia
    % entre los umbrales t0 y t es menor que un cierto error.
    error = 0;
    while (abs(t0-t) > error)

        t0 = t;

        G1 = I(I>t);
        G2 = I(I<=t);

        m1 = mean(G1(:));
        m2 = mean(G2(:));

        t = 0.5*(m1+m2);
    end

    t=round(t);

    segImg=I;
    segImg(I>t)=255;
    segImg(I<=t)=0;
end
