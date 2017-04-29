% TRABAJO FINAL DE GRADO - UMBRALIZACION UTILIZANDO LA ENTROPIA DE RENYI
% Inigo Aguas Ardaiz
% UPNA, 25 de junio de 2015.

% La siguiente función lleva a cabo la umbralizacion considerando la
% entropia de Renyi para cualquier imagen que se le introduzca como
% argumento. Esta funci�n es la principal para el programa presentado.
function [tc, I, ta] = renyi(im)

    % Llevamos a cabo la lectura si es necesario; si no, actuamos como si
    % la imagen ya estuviera leida.
    if ischar(im)
        x = im2double(imread(im)); % Leemos la imagen con formato double.
        nom = im;
    else
        x = im2double(im); % Pasamos a double por si acaso.
        nom = '';
    end

    L = 256; % Niveles de grises, constante.

    [conteo, intensidad] = imhist(x); % Calculamos el histograma de la imagen,
    % obtenemos el numero de pixeles para cada intensidad (conteo).
    N = sum(conteo);
    p = conteo/N; % Calculamos la probabilidad de cada intensidad de gris.

    % Como Sahoo afirma que tomando un alfa cualquiera dentro de unos rangos
    % delimitados (pag 74, primer parrafo) siempre se obtiene el mismo
    % umbral definimos una alfa dentro de cada rango.
    alfa = [0.3, 0.99999, 10];

    % Bucle para iterar sobre los valores de alfa.
    for i=1:3
        a = alfa(i); % a es el valor del parametro alfa en cada momento.
        % Bucle para iterar sobre cada uno de los umbrales posibles para
        % tomarlos en consideracion y poder decidir de forma acertada.
        for t=0:L-2
            % Calculo de las probabilidades de cada uno de los grupos
            % formados en el umbral.
            pA1 = sum(p(1:t+1));
            pA2 = sum(p(t+2:L));
            % Calculo de la entropia de Renyi para cada una de las
            % particiones formadas por el umbral.
            HA1(t+1) = (log(sum((p(1:t+1)/pA1).^a)))/(1-a);
            HA2(t+1) = (log(sum((p(t+2:L)/pA2).^a)))/(1-a);
        end
        H = HA1 + HA2; % Calculamos la entropia total para cada alfa.

        % Buscamos el primer umbral que maximice la entropia para cada uno
        % de los alfas propuestos.
       ta(i) = find(H==max(H), 1, 'first');
    end

    % Ordenamos segun el estadistico de orden (de menor a mayor).
    ta = sort(ta);
    t1 = ta(1);
    t2 = ta(2);
    t3 = ta(3);

    % Calculamos las probabilidades para cada uno de los umbrales siendo
    % estas un cumulo desde t=1 hasta t=tx. Calculamos tambien w.
    pt1 = sum(p(1:t1+1));
    pt3 = sum(p(1:t3+1));
    w = pt3 - pt1;

    % Segun la circunstancia de umbrales que se muestre asignamos los beta
    % para el calculo del umbral definitivo.
    if abs(t1 - t2)<=5 && abs(t2 - t3)<=5
        beta = [1, 2, 1];
    elseif abs(t1 - t2)>5 && abs(t2 - t3)>5
        beta = [1, 2, 1];
    elseif abs(t1 - t2)<=5 && abs(t2 - t3)>5
        beta = [0, 1, 3];
    elseif abs(t1 - t2)>5 && abs(t2 - t3)<=5
        beta = [3, 1, 0];
    end

    % Calculamos el umbral definitivo segun la ecuacion propuesta.
    tc = t1*(pt1+.25*w*beta(1))+.25*t2*w*beta(2)+t3*(1-pt3+.25*w*beta(3));
    tc=round(tc);

    % Preparamos la imagen de salida.
    I = im2uint8(x);
    I(I<=tc) = 0; % Asignamos los nuevos valores a los pixeles del fondo
    I(I>tc) = 255; % Asignamos los nuevos valores a los pixeles del objeto

end
