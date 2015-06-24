% TRABAJO FINAL DE GRADO - FUNCION AUXILIAR PARA TRASLADAR LA UMBRALIZACION DE KMEANS
% Iñigo Aguas
% UPNA, 25 de junio de 2015.

% Esta funcion permite que cuando se utilice la función k-means sea posible
% convertir su resultado al mismo juego de colores que usarian los demas algoritmos.


function imgClean = normalicekmeans(img)
    [h, gray] = imhist(img);
    grays = unique(gray(h(:)~=0));
    numGrays = length(grays);
    newGrays = floor(0:255/(numGrays-1):255);
    imgClean = img;
    for i=1:numGrays
        imgClean(imgClean==grays(i)) = newGrays(i);
    end
end