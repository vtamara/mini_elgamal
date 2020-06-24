#!/usr/bin/env ruby
# Quiebra ElGamal simplificado pues opera con primos de 32 bits
# vtamara@pasosdeJesus.org. 2020. Dominio público

require 'benchmark'
require 'byebug'
require_relative 'comunes'


puts "Llave pública de Alice"
puts "g? "
g = $stdin.readline.chop.to_i

puts "K? "
k = $stdin.readline.chop.to_i

puts "p? "
p = $stdin.readline.chop.to_i

puts "Cual es el y1?"
y1 = $stdin.readline().to_i

puts "Cual es el y2?"
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


b = log_mod(g, y1, p)
puts "b es #{b}"

f = exp_mod(k, b, p)
puts "f es #{f}"

fi = inversomult_mod(f, p)
puts "inverso de f es #{fi}"

mc = y2 * fi % p
puts "mc es #{mc}"

dm = decodifica_cadena_de_numero(mc)
puts "dm=#{dm}"


# ElGamal se fortalece haciendo dificil para el atacante conocer la llave pública de Alice y el mensaje secreto (y1,y2)

