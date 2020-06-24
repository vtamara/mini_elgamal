#!/usr/bin/env ruby
# Cifra mensaje de 4 bytes con ElGamal
# vtamara@pasosdeJesus.org. 20202. Dominio público

require 'byebug'
require_relative 'comunes'

puts "Llave pública de Alice"
puts "g? "
g = $stdin.readline.chop.to_i

puts "K? "
k = $stdin.readline.chop.to_i

puts "p? "
p = $stdin.readline.chop.to_i

puts "b aleatoria y secreto entre 0 y #{p}?"
b = $stdin.readline.chop.to_i


puts "mensaje secreto (cadena de 4 bytes)?"
mc = $stdin.readline.chop
m = codifica_cadena_como_numero(mc)
puts "m es #{m}"
mb = m.to_s(2)
puts "de #{mb.length} bits"

y1 = exp_mod(g, b, p)
puts "y1=#{y1}"

y2 = (exp_mod(k, b, p) * m) % p
puts "y2=#{y2}"
