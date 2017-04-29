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
