# language: es
# encoding: utf-8
# Archivo: VerificarCromosoma.feature
# Autor: Ángel García Baños
# Email:  angarciaba@gmail.com
# Fecha creación: 2015-03-18
# Fecha última modificación: 2015-03-24
# Versión: 0.2
# Licencia: GPL

Característica: Evaluar cada cromosoma, para verificar que funciona.

  Antecedentes: Crear un cromosoma
    Dado que se necesita una se necesita una poblacion de cromosomas de 8 filas, se crea uno.
    
#  -  Que al crear un Cromosoma tenga sus genes distintos.
  Escenario: Verificar que todos los genes sean distintos
    Cuando miro los valores de todos los genes
    Entonces debe decir que todos los genes han tomado distintos valores.

#  -  Que funcione la mutación. Hay varias formas para ello. No hace falta ser exhaustivo.
  Escenario: Mutacion
    Cuando muto un cromosoma
    Y miro los valores de todos los genes del hijo
    Entonces debe decir que todos los genes han tomado distintos valores.
    Y el cromosoma padre debe ser distinto del hijo en sus genes.

#-  Que funcione el cruce uniforme. Hay varias formas para ello. No hace falta ser exhaustivo.
  Escenario: Cruce
    Cuando cruzo un cromosoma con otro
    Y miro los valores de todos los genes del hijo y de sus padres
    Y el cromosoma hijo debe ser una combinacion de sus padres.

