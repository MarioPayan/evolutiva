# encoding: utf-8
# Archivo: VerificarAlgoritmoGenetico_steps.rb
# Autor: Brayan Rodríguez
# Email:  bryan951112@gmail.com
# Fecha creación: 2016-06-30
# Fecha última modificación: 2016-06-30
# Versión: 0.3
# Licencia: GPL

Dado /^que se necesita un cromosoma y un algoritmo genetico, se crea un cromosoma de (.+?) filas y el algoritmo genetico.$/  do |filas|
  @numGenes = filas.to_i
  @cromosoma = Cromosoma.new(@numGenes, true)
  @algen =  AlgoritmoGenetico.new(0,@numGenes,true, 100)
end


Cuando(/^el tablero es$/) do |tabla|
  tablero = tabla.raw
  genes=[]
  tablero.each_index do |index|
    tablero[index].each_with_index do |element, j|
      if element.include?'X'
        genes.push(j)
      end
    end
  end 
  @cromosoma.printGenes
  @cromosoma.setGenes(genes)
end

Entonces /^al evaluarlo debe indicar (.+?) conflictos$/ do |confs|
  @cromosoma.printGenes
  choques = @algen.validar(@cromosoma)
  expect(confs.to_i).to eq choques.to_i
end
