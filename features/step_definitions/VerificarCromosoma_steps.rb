# encoding: utf-8
# Archivo: VerificarCromosoma_steps.rb
# Autor: Brayan Rodríguez
# Email:  bryan951112@gmail.com
# Fecha creación: 2016-06-30
# Fecha última modificación: 2016-06-30
# Versión: 0.3
# Licencia: GPL

Dado /^que se necesita una se necesita una poblacion de cromosomas de (.+?) filas, se crea uno.$/  do |filas|
  @cromosoma = Cromosoma.new(filas.to_i)
end


Cuando /^miro los valores de todos los genes$/ do
  @plataQueHay = @cuentaBancaria.cuandoDineroHay
end


Entonces /^debe decir que hay (.+?) pesos$/ do |cuantosPesos|
  expect(@plataQueHay).to eq cuantosPesos.to_i
end


Cuando /^introduzco (.+?) pesos$/ do |cuantosPesos|
  @cuentaBancaria.ingresarDinero(cuantosPesos.to_i)
end


Cuando /^saco (.+?) pesos$/ do |cuantosPesos|
  cuantosPesos = cuantosPesos.to_i
#  @noSePuede = false
  if cuantosPesos <= @cuentaBancaria.cuandoDineroHay then
    expect { @cuentaBancaria.sacarDinero(cuantosPesos) }.not_to raise_error
  else
    expect { @cuentaBancaria.sacarDinero(cuantosPesos) }.to raise_error
    @noSePuede = true
  end
end


Entonces /^debe decir que no se puede$/ do
  expect(@noSePuede).to be true
end



