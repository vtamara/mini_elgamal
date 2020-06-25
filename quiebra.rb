#!/usr/bin/env ruby
# Quiebra ElGamal simplificado pues opera con primos de 32 bits
# vtamara@pasosdeJesus.org. 2020. Dominio público

require 'benchmark'
require_relative 'comunes'


puts "Atacanta, ¿Cúal es la llave pública de Alice?"
puts "¿g? "
g = $stdin.readline.chop.to_i

puts "¿K? "
k = $stdin.readline.chop.to_i

puts "¿p? "
p = $stdin.readline.chop.to_i

# Encuentra b tal que g**b = l mod p por fuerza re-bruta
# Hay mejor algoritmo
def log_mod(g, l, p)
  b = 2
  while exp_mod(g, b, p) != l
    b += 1
  end
  return b
end


puts "Quebrando"
a = log_mod(g, k, p)
puts "  a es #{a}"

da = decodifica_cadena_de_numero(a)
puts "  La clave cifrada de Alice fue '#{da}'"


