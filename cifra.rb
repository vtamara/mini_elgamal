#!/usr/bin/env ruby
# Cifra mensaje de 4 bytes con ElGamal
# vtamara@pasosdeJesus.org. 20202. Dominio público

require_relative 'comunes'

puts "Bob, ¿Cúal es la llave pública de Alice?"
puts "¿g? "
g = $stdin.readline.chop.to_i

puts "¿K? "
k = $stdin.readline.chop.to_i

puts "¿p? "
p = $stdin.readline.chop.to_i

puts "\nBob ¿Cúal será tu b aleatorio y secreto entre 0 y #{p-1}?"
b = $stdin.readline.chop.to_i


puts "\nBob, ¿Cúal será el mensaje a cifrar para Alice (cadena de 4 bytes)?"
mc = $stdin.readline.chop
m = codifica_cadena_como_numero(mc)
mb = m.to_s(2)
puts "m como número es #{m} que es de #{mb.length} bits"

puts "\nEl mensaje cifrado (y1, y2):"
y1 = exp_mod(g, b, p)
puts "  y1=#{y1}"

y2 = (exp_mod(k, b, p) * m) % p
puts "  y2=#{y2}"
