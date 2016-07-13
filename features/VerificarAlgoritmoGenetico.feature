# language: es
# encoding: utf-8
# Archivo: VerificarCromosoma.feature
# Autor: Ángel García Baños
# Email:  angarciaba@gmail.com
# Fecha creación: 2015-03-18
# Fecha última modificación: 2015-03-24
# Versión: 0.2
# Licencia: GPL

Característica: Evaluar correctamente los ataques entre Reinas de un Cromosoma.

  Antecedentes: Crear un cromosoma y un algoritmo genetico 
    Dado que se necesita un cromosoma y un algoritmo genetico, se crea un cromosoma de 5 filas y el algoritmo genetico.
    
#  Evaluar choque en diagonal secundaria
  Escenario: Un conflicto en diagonal 5 y 3 y 8
    Cuando el tablero es
    | X |   |   |   |   |   |
    |   |   | X |   |   |   |
    |   | X |   |   |   |   |
    |   |   |   |   |   | X |
    |   |   |   |   | X |   |
    |   |   |   | X |   |   |
    Entonces al evaluarlo debe indicar 5 conflictos
    
  Escenario: Un conflicto en diagonal 6 y 5 
    Cuando el tablero es
    |   |   |   |   |   | X |
    |   |   | X |   |   |   |
    |   |   |   |   | X |   |
    |   |   |   | X |   |   |
    |   | X |   |   |   |   |
    | X |   |   |   |   |   |
    Entonces al evaluarlo debe indicar 4 conflictos
    
  Escenario: Sin conflictos
    Cuando el tablero es
    |   |   |   |   | X |   |
    |   |   | X |   |   |   |
    | X |   |   |   |   |   |
    |   |   |   |   |   | X |
    |   |   |   | X |   |   |
    |   | X |   |   |   |   |
    Entonces al evaluarlo debe indicar 0 conflictos