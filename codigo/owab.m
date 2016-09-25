% Función para obtener los owa relativos al objeto.
function m = owab(Q, t, tipo)
    
    if tipo == 1 % Media de la imagen habitual
        
         m = sum(Q(1:t+1,2).*Q(1:t+1,1))/sum(Q(1:t+1,2));
         m = m/255;
         
    elseif tipo == 2 % OWA sin frecuencia.
                    
        % t tiene que estar normalizado.    
        intervalo = Q(1:t+1,2);
        tplus1norm = (t+1)/255;
        norm1 = 1/255;

        [~, orden] = sort(intervalo);
        ordenNorm = (orden-1)./255;

        i=1;
        w = zeros(1,t+1);
        for j= norm1 : norm1 : tplus1norm
            w(i) = funcPesos(j/tplus1norm)-funcPesos((j-norm1)/tplus1norm);
            i=i+1;
        end

        m = w*ordenNorm;
        
    else % OWA con frecuencia.
        
        % t tiene que estar normalizado.    
        intervalo = Q(1:t+1,2);
        tplus1norm = (t+1)/255;
        norm1 = 1/255;

        [frec, orden] = sort(intervalo);
        ordenNorm = (orden-1)./255;
        totalFrec = sum(frec);
        normFrec = frec/totalFrec;

        i=1;
        w = zeros(1,t+1);
        for j= norm1 : norm1 : tplus1norm
            w(i) = funcPesos(j/tplus1norm)-funcPesos((j-norm1)/tplus1norm);
            i=i+1;
        end

        m = w*(ordenNorm.*normFrec);
    end
    
    if isnan(m) %Retiramos todos los problemas.
        m=0;
    end
end