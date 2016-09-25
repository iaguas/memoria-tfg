% TRABAJO FINAL DE GRADO - UMBRALIZACION UTILIZANDO EL METODO KMEANS
% Inigo Aguas
% UPNA, 25 de junio de 2015.

% Funcion para la umbralizacion por medio de clasificacion de los pixeles
% Definimos la funcion con parámetros de entrada I, la imagen, y k, el
% numero de clusters.
function [ISeg, J] = kmeans(I, k)

    % Calculo constantes del proceso e inicializo variables.
    [M, N] = size(I);
    I=im2double(I);
    coste = zeros(M, N);
    pertenencia = zeros(M, N);
        
    % Inicializo los costes para entrar en el bucle.
    J=1;
    Jant=0;
    
    % Inicializo los centros de forma aleatoria para llegar a su convergencia 
    % en el bucle.
    centros = rand(1, k);
    
    % Continuo el proceso hasta conseguir que el coste converja.
    while J~=Jant

        % Calculo la pertenencia de los pixeles a los centros.
        for i=1:M
            for j=1:N
                [coste(i,j), pertenencia(i,j)] = min((I(i,j)-centros).^2);
            end
        end
        
        % Recalculo el nuevo coste
        Jant=J;
        J=sum(sum(coste));
        
        % Recalculo los nuevos centros en funcion de la pertenencia a ellos.
        for j=1:k
            if sum(sum(pertenencia==j)) == 0
                centros(j) = 0;
            else
                centros(j) = sum(sum(I(pertenencia==j)))/sum(sum(pertenencia==j));
            end
        end
    end
    
    % Segmento la imagen para obtener el resultado final.
    ISeg = zeros(M, N);
    for j=1:k
        ISeg = ISeg+centros(j)*(pertenencia==j);
    end
end