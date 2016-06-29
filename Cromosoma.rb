class Cromosoma
  def initialize(numeroGenes, debug) #Constructor, recibe el numero de genes
    @debug = debug #Es una variable temporal nueva para mostrar o no en consola los resultados
    @genes = [*0..numeroGenes].shuffle #Genera una lista con los numeros de 0 al numero de genes maximo y los desorganiza
    @aptitud = 10 #Coloca una funcion de aptitud imposible por defecto (usado para comprobar errores)
  end  

  def mutar
    random1 = random2 = 0 #Iguala las dos variables random a 0
    while random1==random2 do #Ciclo while que no permite que los random sean iguales
    	random1 = rand(@genes.length) #Genera un numero aleatorio para un random
    	random2 = rand(@genes.length) #Lo mismo, para el otro random
    end
    puts "Mutando:    #{@genes.at(random1)} en #{random1+1} -> #{@genes.at(random2)} en #{random2+1}" if @debug
    @genes[random1], @genes[random2] = @genes[random2], @genes[random1] #Intercambia de lugar dos genes en las posiciones escogidas por los random

  end

  def getGen(posicion) #Retorna un gen en determinada posicion del cromosoma
  	return @genes[posicion]
  end
  
  def getTamano #Obtiene el tamano de un cromosoma
  	return @genes.length
  end
  
  def getAptitud #Retorna la aptitud del cromosoma
  	return @aptitud
  end	

  def setAptitud(aptitud) #Modifica la aptitud del cromosoma
  	@aptitud = aptitud
  end

  def printGenes #Representa en consola el identificador de un cromosoma seguido de sus genes
  	puts "Cromosoma:  ID: #{self.object_id} -> #{@genes.join(',')}"
  end

  def printTablero #Esto es para pintar el tablero, asi que no lo explicare
  	puts "Tablero:"
  	@genes.each do |posicion|
  		fila = Array.new(@genes.length,"O")
  		fila[posicion] = "X"
  		puts fila.join(',')
  	end
  end
end