%Funciones REF utilizadas en el segundo lugar.
function eql = REF2(x, y)
    eql = 1 - abs(x-y).^2;
end