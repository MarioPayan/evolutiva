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
    Dado que se necesita una poblacion de cromosomas de 8 filas, se crea uno.
    
#  -  Que al crear un Cromosoma tenga sus genes distintos.
  Escenario: Verificar que todos los genes sean distintos
    Cuando miro los valores de todos los genes
    Entonces debe decir que todos los genes han tomado distintos valores.

#  -  Que funcione la mutación. Hay varias formas para ello. No hace falta ser exhaustivo.
  Escenario: Mutacion
    Cuando muto un cromosoma
    Y miro los valores de todos los genes 
    Entonces debe decir que todos los genes han tomado distintos valores.
    Y el primer cromosoma debe ser distinto del segundo en sus genes.

