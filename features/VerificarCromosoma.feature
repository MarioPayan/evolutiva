# language: es
# encoding: utf-8
# Archivo: VerificarCuentaBancaria.feature
# Autor: Ángel García Baños
# Email:  angarciaba@gmail.com
# Fecha creación: 2015-03-18
# Fecha última modificación: 2015-03-24
# Versión: 0.2
# Licencia: GPL

Característica: Evaluar cada cromosoma, para verificar que funciona.

  Antecedentes: Crear un cromosoma
    Dado que se necesita una poblacion de cromosomas de 8 espacios, se crea uno.
    
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

  Escenario: Sacar dinero
    Cuando saco 40 pesos
    Y miro cuanta plata hay
    Entonces debe decir que hay 160 pesos

  Escenario: Hacer varios ingresos y saques
    Cuando saco 10 pesos
    Y introduzco 50 pesos
    Y introduzco 1000 pesos
    Y saco 600 pesos
    Y miro cuanta plata hay
    Entonces debe decir que hay 640 pesos

  Escenario: Intentar sacar más dinero del que hay
    Cuando saco 1000 pesos
    Entonces debe decir que no se puede


