% Función auxiliar para calcular los pesos de la función OWA.
function Q = funcPesos(r)
        if r < 0.5
            Q = 0;
        else
            Q = (r-0.5)/0.5; % Introduzco la t normalizada.
        end
end
