% Función de similitud
function s = SM(h,Qt,HQt)
    sumHist = sum(h(:,2));
    mult1 = 1 / sumHist;
    mult2 = (1 - (Qt - HQt).^2)*h(:,2);
    s = mult1 * mult2;
end
