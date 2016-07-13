load 'Cromosoma.rb'

class AlgoritmoGenetico < Array #La clase extiende de un Array
	def initialize(numeroPoblacion, numeroGenes, debug, temperatura=100) #Constructor, recibe dos numeros, el tamano de la poblacion y el numero de genes de cada cromosoma
		@numeroGenes = numeroGenes
		@temperaturaInicial = temperatura
		@temperatura = temperatura
		@beta = 0.02
		@superRandom = Random.new
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
			diagonal2.push(@numeroGenes-i+cromosoma.getGen(i)) #Identifica la subdiagonal y la agrega a su correspondiente diagonal
		end
		choques = self.triangular(diagonal1) + self.triangular(diagonal2) #Triangula los choques
		if @debug
			puts "Diagonales:"
			puts diagonal1.join(',')
			puts diagonal2.join(',')
			puts "Choques: "
			puts choques
		end
		return  choques #Retorna la cantidad de choques
	end
	
	def calcularAptitud(choques) #normaliza el numero de choques
		aptitud = (choques + 0.0)/@numeroMaximoChoques #Normaliza en (0 - 1) la aptitud
		aptitud = (1 - aptitud).abs
		return aptitud
	end

	def generacionar #Ejecuta el programa para una sola generacion
		cromosomasInicialesCount = self.length #Contador que permite recorrer solo los elementos de la generacion antes de ejecutar el ciclo
		self.each_with_index do |cromosoma, index| #Por cada cromosoma de la generacion
			cromosomasInicialesCount = cromosomasInicialesCount-1 #Contador
			puts "----------Soy una barrita separadora :D---------------" if @debug
			cromosoma.printGenes if @debug #Obtiene los genes de determinado cromosoma
			cromosomaMutado = cromosoma.mutar #Crea una copia del cromosoma actual y lo muta
			cromosomaMutado.setAptitud( calcularAptitud( self.validar(cromosomaMutado) ) ) #Evalua la aptitud del cromosoma
			if cromosomaMutado.getAptitud > cromosoma.getAptitud #Si la aptitud del cromosoma mutado es mayor que la del cromosoma
				self[index] = cromosomaMutado #Reemplaza el padre por el hijo 
			else
				
				if @superRandom.rand(1.0) < Math::E**((cromosoma.getAptitud - cromosomaMutado.getAptitud)/@temperatura) #euler
					self[index] = cromosomaMutado #Reemplaza el padre por el hijo
				end
			end
			cromosoma.printGenes if @debug #Obtiene los genes de determinado cromosoma
			cromosoma.printTablero if @debug #Obtiene el tablero representado por determinado cromosoma
			cromosoma.setAptitud( calcularAptitud( self.validar(cromosoma) ) ) #Almacena la funcion de aptitud calculada para... ya saben
			@temperatura = @temperatura/(1+@beta*(@temperatura/@temperaturaInicial))
			puts if @debug #Salto de linea
			puts "Temperatura = #{@temperatura}" if @debug
			break if cromosomasInicialesCount==0 #Si ya se termino la generacion que habia inicialmente, finaliza
		end
	end
	
	def printGeneracion(debug = false)
		@debug = debug
		soluciones = Array.new()
		puts "Aptitud de toda la generacion:" if @debug
		self.each do |cromosoma|
			puts "----------------" if @debug
			cromosoma.printGenes if @debug
			puts "Aptitud = " + cromosoma.getAptitud.to_s if @debug
			if cromosoma.getAptitud == 1
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

a = AlgoritmoGenetico.new(5000,9,false) #La tercera variable permite ver en detalle el procedimiento
a.generacionar
a.printGeneracion
puts puts puts
#a[0].cruzar(a[1]) #Ejemplo de cruce (Activar el debug)
