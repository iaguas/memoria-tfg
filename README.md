# Memoria y presentación del Trabajo Final de Grado
### _Segmentación de imágenes a través de lógica difusa y funciones REF, de Dombi y penalti_
#### Iñigo Aguas Ardaiz
#### Tutores:
  * Humberto Bustince Sola
  * Francisco Javier Fernández Fernández

#### Pamplona, 25 de junio de 2016


## Abstract
Muchas técnicas para la resolución de problemas específicos de computación dependen fuertemente de las funciones utilizadas para procesar la información y de la determinación de los mejores parámetros para las mismas. Esto es así, en particular, en problemas de procesamiento de imagen (segmentación) con técnicas difusas en los que, en gran medida, las funciones y variables dependen del problema considerado. En concreto, en este proyecto se propone utilizar funciones de Dombi para sustituir las funciones REF en la segmentación de imágenes en blanco y negro de forma que se encuentre la mejor forma de segmentar a través de la umbralización un conjunto de imágenes y poder llevar este proceso a la práctica de forma general. Posteriormente, por medio de funciones penalti se intenta obtener una umbralización lo más parecida posible a todas las llevadas a cabo. Se estudia, también, utilizar funciones OWA en la construcción de los conjuntos difusos.

### Palabras clave
* Segmentación de imagen;
* Funciones de equivalencia restringida (REF);
* Funciones de Dombi;
* Funciones penalti;
* Funciones OWA.

## Compilación
Para la compilación se ha preparado un fichero de `latexmk`con la intención de que sea más fácil llevarlo a cabo. Además, se utiliza el paquete `subfiles` con intención de poder compilar cada uno de los paquetes a parte sin tener ningún tipo de problema para obtener un PDF de cada uno. Así, simplemente ejecutando desde la raíz del repo `latexmk -pdf <ruta/al/fichero.tex>` se obtiene el PDF requerido.

### Dependencias
[En preparación]

### Cita
Diseño gráfico preparado a partir del código de @gmaiztegi para su memoria del [proyecto final de carrera](https://github.com/gmaiztegi/faborez-memoria). Aprovecho desde aquí para agradecer la ayuda que me proporcionó.
