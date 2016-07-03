# encoding: utf-8
# Archivo: VerificarCromosoma_steps.rb
# Autor: Brayan Rodríguez
# Email:  bryan951112@gmail.com
# Fecha creación: 2016-06-30
# Fecha última modificación: 2016-06-30
# Versión: 0.3
# Licencia: GPL

Dado /^que se necesita una se necesita una poblacion de cromosomas de (.+?) filas, se crea uno.$/  do |filas|
  @numGenes = filas.to_i
  @cromosoma = Cromosoma.new(@numGenes, true)
end


Cuando /^miro los valores de todos los genes$/ do
  @diferentes = @cromosoma.sonDiferentesGenes
end

Cuando /^miro los valores de todos los genes del hijo$/ do
  @diferentes = @hijo.sonDiferentesGenes
end

Cuando /^miro los valores de todos los genes del hijo y de sus padres$/ do
  #@diferentes = @hijo.sonDiferentesGenes
  @combinacion = false 
  i = 0
  begin
    @combinacion = ((@hijo.getGen(i) == @cromosoma.getGen(i)) or (@hijo.getGen(i) == @esposa.getGen(i)))
    break if not @combinacion
    i +=1
  end while i < @cromosoma.getTamano
end

Entonces /^debe decir que todos los genes han tomado distintos valores.$/ do
  expect(@diferentes).to eq true 
end

Cuando /^muto un cromosoma$/ do
  @hijo = @cromosoma.mutar()
end

Cuando /^cruzo un cromosoma con otro$/ do
  @esposa = Cromosoma.new(@numGenes, false)
  @hijo = @cromosoma.cruzar(@esposa)
end

Entonces /^el cromosoma padre debe ser distinto del hijo en sus genes.$/ do
  expect(@cromosoma).not_to eql(@hijo)
end

Entonces /^el cromosoma hijo debe ser una combinacion de sus padres.$/ do
  expect(@combinacion).to eq true
end

