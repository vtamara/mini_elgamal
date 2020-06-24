#!/usr/bin/env ruby
# Quiebra ElGamal simplificado pues opera con primos de 32 bits
# vtamara@pasosdeJesus.org. 2020. Dominio público

require 'benchmark'
require 'byebug'
require_relative 'comunes'


puts "Atacanta, ¿Cúal es la llave pública de Alice?"
puts "¿g? "
g = $stdin.readline.chop.to_i

puts "¿K? "
k = $stdin.readline.chop.to_i

puts "¿p? "
p = $stdin.readline.chop.to_i

puts "Atacante, ¿Cuál es el mensaje cifrado?"
puts "¿y1?"
y1 = $stdin.readline().to_i

puts "¿y2?"
y2 = $stdin.readline().to_i

# Encuentra b tal que g**b = l mod p por fuerza re-bruta
# Hay mejor algoritmo
def log_mod(g, l, p)
  b = 2
  while exp_mod(g, b, p) != l
    b += 1
  end
  return b
end


puts "Quebrado"
b = log_mod(g, y1, p)
puts "  b es #{b}"

f = exp_mod(k, b, p)
puts "  f es #{f}"

fi = inversomult_mod(f, p)
puts "  inverso de f es #{fi}"

m = y2 * fi % p
puts "  m es #{m}"

dm = decodifica_cadena_de_numero(m)
puts "  El mensaje enviado por Bob a Alice fue '#{dm}'"


