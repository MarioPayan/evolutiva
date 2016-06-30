load 'Cromosoma.rb'

class AlgoritmoGenetico < Array #La clase extiende de un Array
	def initialize(numeroPoblacion, numeroGenes, debug) #Constructor, recibe dos numeros, el tamano de la poblacion y el numero de genes de cada cromosoma
		@debug = debug #Es una variable temporal nueva para mostrar o no en consola los resultados
		@numeroMaximoChoques = (numeroGenes*(numeroGenes-1))/2 #Define el numero maximo de choques posibles
		numeroPoblacion.times do |cromosoma| #Entra a un ciclo que se ejecuta tantas veces como miembros en la poblacion haya
			self << Cromosoma.new(numeroGenes-1, @debug) #Agrega a la lista un nuevo cromosoma con un determinado numero de genes
		end
	end

	def triangular(diagonal) #Metodo para calcular los choques entre reinas en un conjunto de diagonales dado en la misma direccion
		count = 0 #Un contador, dahh
		hash = Hash.new(0) #Tabla hash para almacenar la cantidad de choques en cada una de las subdiagonales de la misma direccion
		diagonal.each {|v| hash[v] +=1 } #Suma 1 cada que encuentra una reina en una subdiagonal
		hash.each do |h, v| #Ciclo que se ejecuta por cada subdiagonal
			if v>0 #Si en la subdiagonal encuentra almenos un choque
				count += ((v)*(v-1))/2 #Calcula la cantidad de choques de la subdiagonal y los agrega al contador
			end
		end
		return count #Retorna el contador
	end

	def validar(cromosoma) #Metodo para validar el tablero representado por un cromosoma (funcion de aptitud)
		diagonal1 = Array.new() #Conjuntos de subdiagonales en la misma direccion
		diagonal2 = Array.new() #Conjuntos de subdiagonales en la otra direccion
		for i in 0..cromosoma.getTamano-1 #Ciclo for de 0 hasta el tamano del tablero
			diagonal1.push(i+cromosoma.getGen(i)) #Identifica la subdiagonal y la agrega a su correspondiente diagonal
			diagonal2.push(3-i+cromosoma.getGen(i)) #Identifica la subdiagonal y la agrega a su correspondiente diagonal
		end
		choques = self.triangular(diagonal1) + self.triangular(diagonal2) #Triangula los choques
		aptitud = (choques + 0.0)/@numeroMaximoChoques #Normaliza en (0 - 1) la aptitud
		if @debug
			puts "Diagonales:"
			puts diagonal1.join(',')
			puts diagonal2.join(',')
			puts "Choques: "
			puts choques
			puts "Aptitud: "
			puts aptitud
		end
		return aptitud #Retorna la aptitud
	end

	def generacionar #Ejecuta el programa para una sola generacion
	cromosomasInicialesCount = self.length #Contador que permite recorrer solo los elementos de la generacion antes de ejecutar el ciclo
		self.each do |cromosoma| #Por cada cromosoma de la generacion
			cromosomasInicialesCount = cromosomasInicialesCount-1 #Contador
			puts "----------Soy una barrita separadora :D---------------" if @debug
			cromosoma.printGenes if @debug #Obtiene los genes de determinado cromosoma
			cromosomaMutado = Marshal.load(Marshal.dump(cromosoma)).mutar #Crea una copia del cromosoma actual y lo muta
			cromosomaMutado.setAptitud(self.validar(cromosomaMutado)) #Evalua la aptitud del cromosoma
			self.push(cromosomaMutado) #Agrega el cromosoma a la generacion
			cromosoma.printGenes if @debug #Obtiene los genes de determinado cromosoma
			cromosoma.printTablero if @debug #Obtiene el tablero representado por determinado cromosoma
			cromosoma.setAptitud(self.validar(cromosoma)) #Almacena la funcion de aptitud calculada para... ya saben
			puts if @debug #Salto de linea
			break if cromosomasInicialesCount==0 #Si ya se termino la generacion que habia inicialmente, finaliza
		end
	end
	
	def printGeneracion
		soluciones = Array.new()
		puts "Aptitud de toda la generacion:"
		self.each do |cromosoma|
			puts "----------------"
			cromosoma.printGenes
			puts "Aptitud = " + cromosoma.getAptitud.to_s
			if cromosoma.getAptitud == 0
				soluciones.push(cromosoma)
			end
		end
		puts "\nSoluciones -----------"
		if soluciones.any?
			soluciones.each do |cromosoma|
				cromosoma.printGenes
			end
		puts "#{soluciones.length} Soluciones encontradas"
		else 
			puts "No se encontraron soluciones"
		end
	end
end

a = AlgoritmoGenetico.new(2,4,false) #La tercera variable permite ver en detalle el procedimiento
a.generacionar
a.printGeneracion
a[0].cruzar(a[0],a[1]) #Ejemplo de cruce (activar el debug)