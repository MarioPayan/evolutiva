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
  
  def cruzar(cromosoma1, cromosoma2)
    tamano = getTamano #Obtiene el tamano de un cromosoma cualquiera
    mascaraCruce = [] #Crea la mascara de cruce (permite saber de que cromosoma sera tomado cada gen)
    tamano.times do #Ciclo tantas veces como genes en el cromosoma hallan
      mascaraCruce.push(rand(2)) #Asigna un numero aleatorio entre 0 y 1 en la masacara (porque son dos padres solamente)
    end
    if @debug
      puts "Mascara de cruce:  #{mascaraCruce.join(",")}" 
      puts "Cromosoma1:"
      cromosoma1.printGenes
      puts "Cromosoma2:"
      cromosoma2.printGenes
    end
    cromosomaTMP = Cromosoma.new(tamano-1, @debug) #Crea un cromosoma temporal con genes aleatorios
    tamano.times do |posicion| #Ciclo tantas veces como genes en el cromosoma hallan
      if mascaraCruce.at(posicion)==0 #Si la mascara esta en 0, toma un gen del cromosoma 1
        cromosomaTMP.setGen(posicion, cromosoma1.getGen(posicion)) #Lo asigna al cromosoma temporal
      else #Si la mascara esta en 1, toma un gen del cromosoma 2
        cromosomaTMP.setGen(posicion, cromosoma2.getGen(posicion)) #Lo asigna al cromosoma temproal
      end
    end
    puts "Cromosoma hijo:" if @debug
    cromosomaTMP.printGenes if @debug
    return cromosomaTMP
  end

  def getGen(posicion) #Retorna un gen en determinada posicion del cromosoma
  	return @genes[posicion]
  end
  
  def setGen(posicion, valor)
    @genes[posicion] = valor
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