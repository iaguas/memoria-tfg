% Función para obtener los OWA relativos al objeto.
function m = owao(Q, t, L, tipo)

    if tipo == 1 % Media de la imagen habitual

         m = sum(Q(t+2:L,2).*Q(t+2:L,1))/sum(Q(t+2:L,2));
         m = m/255;

    elseif tipo == 2 % OWA sin frecuencia

        % t tiene que estar normalizado.
        intervalo = Q(t+2:L,2);
        tplus1norm = (t+1)/255;
        norm1 = 1/255;

        [~, orden] = sort(intervalo);
        ordenNorm = (orden-1)./255;

        i=1;
        w = zeros(1,L-(t+1));
        for j= tplus1norm : norm1 : 1
            w(i) = funcPesos(j/1)-funcPesos((j-norm1)/1);
            i=i+1;
        end

        m = w*ordenNorm;

    else % OWA con frecuencia

        % t tiene que estar normalizado.
        intervalo = Q(t+2:L,2);
        tplus1norm = (t+1)/255;
        norm1 = 1/255;

        [frec, orden] = sort(intervalo);
        ordenNorm = (orden-1)./255;
        totalFrec = sum(frec);
        normFrec = frec/totalFrec;

        i=1;
        w = zeros(1,L-(t+1));
        for j= tplus1norm+norm1 : norm1 : 1+norm1
            w(i) = funcPesos(j/(1+norm1))-funcPesos((j-norm1)/(1+norm1));
            i=i+1;
        end

        m = w*(ordenNorm.*normFrec);
    end

    if isnan(m) %Retiramos todos los problemas.
        m=0;
    end
end
