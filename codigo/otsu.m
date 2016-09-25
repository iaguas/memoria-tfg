% TRABAJO FINAL DE GRADO - UMBRALIZACION UTILIZANDO EL METODO DE OTSU
% Inigo Aguas
% UPNA, 25 de junio de 2015.

% Para calcular este metodo utilizamos la prueba de toda la combinatoria
% diferente de todas las divisiones diferentes que se pueden dar. Es decir,
% hacemos los grupos de 0 y L-1... De eso calculamos la varianza y de aquel
% grupo que sea maxima es del que podemos decir que se aplica la t.


function [tseg, Iseg] = otsu(I)
    % Se asegura que la imagen esta en formato uint8 para tener la escala 
    % de grises adecuada. 
    I=im2uint8(I);
    
    % Se obtiene el histograma de la imagen y las probabilidades.
    [conteo, intensidad] = imhist(I);
    N = sum(conteo);
    probi = conteo / N;
    probixint = probi.*intensidad;
    
    % Hay dos bucles, desde 1 hasta t y desde t+1 hasta L
    L = 256;
    vars = zeros(1, L);
    for t=1:L
        w1 = sum(probi(1:t));
        w2 = sum(probi(t+1:L));
        m1 = sum(probixint(1:t))/w1;
        m2 = sum(probixint(t+1:L))/w2;
        mT = w1*m1+w2*m2;
        vari = w1*(m1-mT)^2 + w2*(m2-mT)^2;
        vars(t) = vari;
    end

    % Hayamos el umbral con la varianza maxima
    % (En caso de haber varios, cogeremos el umbral mas bajo)
    [~, tseg] = max(vars);
    tseg = tseg - 1;
   
    % Se obtiene la imagen que diferencia objeto y fondo.
    Iseg=I;
    Iseg(I>tseg)=255;
    Iseg(I<=tseg)=0;
end