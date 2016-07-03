
require 'rubygems'
require 'bundler/setup'

class Cromosoma
	def initialize(numeroGenes, debug) #Constructor, recibe el numero de genes
		@debug = debug #Es una variable temporal nueva para mostrar o no en consola los resultados
		@genes = [*0..numeroGenes].shuffle #Genera una lista con los numeros de 0 al numero de genes maximo y los desorganiza
		@aptitud = 10 #Coloca una funcion de aptitud imposible por defecto (usado para comprobar errores)
	end  

	def mutar #Pues muta :3
		random1 = random2 = 0 #Iguala las dos variables random a 0
		while random1==random2 do #Ciclo while que no permite que los random sean iguales
			random1 = rand(@genes.length) #Genera un numero aleatorio para un random
			random2 = rand(@genes.length) #Lo mismo, para el otro random
		end
		cromosomaMutado = Marshal.load(Marshal.dump(self))
		puts "Mutando:    #{@genes.at(random1)} en #{random1+1} -> #{@genes.at(random2)} en #{random2+1}" if @debug
		@genes[random1], @genes[random2] = @genes[random2], @genes[random1] #Intercambia de lugar dos genes en las posiciones escogidas por los random
		cromosomaMutado.setGen(random1, @genes[random2])
		cromosomaMutado.setGen(random2, @genes[random1])
		return cromosomaMutado
	end
	
	def cruzar(cromosomaEntrante)
    	tamano = cromosomaEntrante.getTamano #Obtiene el tamano del cromosoma
    	mascaraCruce = [] #Crea la mascara de cruce (permite saber de que cromosoma sera tomado cada gen)
    	tamano.times do #Ciclo tantas veces como genes en el cromosoma hallan
    		mascaraCruce.push(rand(2)) #Asigna un numero aleatorio entre 0 y 1 en la masacara (porque son dos padres solamente)
    	end
	    if @debug
	    	puts "Mascara de cruce:  #{mascaraCruce.join(",")}" 
	    	puts "Cromosoma original:"
	    	self.printGenes
	    	puts "Cromosoma esposa:"
	    	cromosomaEntrante.printGenes
	    end
	    cromosomaCruzado = Cromosoma.new(tamano-1, @debug) #Crea un cromosoma temporal con genes aleatorios
	    tamano.times do |posicion| #Ciclo tantas veces como genes en el cromosoma hallan
	    	if mascaraCruce.at(posicion)==0 #Si la mascara esta en 0, toma un gen del cromosoma original
	        	cromosomaCruzado.setGen(posicion, self.getGen(posicion)) #Lo asigna al cromosoma cruzado
	    	else #Si la mascara esta en 1, toma un gen del cromosoma entrante
	        	cromosomaCruzado.setGen(posicion, cromosomaEntrante.getGen(posicion)) #Lo asigna al cromosoma cruzado
	    	end
	    end
	    puts "Cromosoma hijo:" if @debug
	    cromosomaCruzado.printGenes if @debug
	    return cromosomaCruzado
	end

	def getGen(posicion) #Retorna un gen en determinada posicion del cromosoma
		return @genes[posicion]
	end
	
	def setGen(posicion, valor) #Guarda un valor dado en la lista de genes en una posicion dada
		@genes[posicion] = valor
	end
	
	def setGenes(genes_param) #Recibe todos los valores de los genes, por si es necesario setearlos todos
		@genes = genes_param
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
	
	def sonDiferentesGenes #True si toman distintos valores los genes, False si no
		test = Array.new(self.getTamano)
		@genes.each do |val|
			print val
			if test[val]==nil
				test[val] = 1
			else
				return false
			end
		end
		return true
	end
end

cromosoma= Cromosoma.new(8, false)
cromosoma.printGenes
genes = [1,2,3,4,5,6,7,8]
cromosoma.setGenes(genes)
cromosoma.printGenes
#expected = actual.mutar

#puts actual.printGenes
#puts expected.printGenes
#if actual.eql?(expected)
#	print "paso"
#else
#	print "no paso"
#end

#numGenes=8
#esposa = Cromosoma.new(numGenes, false)
#hijo = cromosoma.cruzar(esposa)

#cromosoma.printGenes
#esposa.printGenes
#hijo.printGenes

#combinacion= false
#i = 0
#begin
#	puts i, hijo.getGen(i) == cromosoma.getGen(i)
#	puts hijo.getGen(i) == esposa.getGen(i)
#	combinacion = ((hijo.getGen(i) == cromosoma.getGen(i)) or (hijo.getGen(i) == esposa.getGen(i)))
#	break if not combinacion
#	i +=1
#end while i < numGenes

#print combinacion