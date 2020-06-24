#!/usr/bin/env ruby
# Descifra mensaje cifrado con ElGamal con primo de 32 bits
# vtamara@pasosdeJesus.org. 20202. Dominio público

require_relative 'comunes'

puts "Cual es el y1?"
y1 = $stdin.readline.chop.to_i
puts "Cual es el y2?"
y2 = $stdin.readline.chop.to_i

puts "Llave pública de Alice"
puts "g? "
g = $stdin.readline.chop.to_i

puts "K? "
k = $stdin.readline.chop.to_i

puts "p? "
p = $stdin.readline.chop.to_i

puts "Llave privada de Alice"
puts "a? "
ac = $stdin.readline.chop
a = codifica_cadena_como_numero(ac)
puts "a es #{a}"
m = (exp_mod(y1, -a, p) * y2) % p

puts "m=#{m}"

mb = m.to_s(2)

puts "mb=#{mb}"
puts "mb.length=#{mb.length}"

c = decodifica_cadena_de_numero(m)
puts "c=#{c}"
puts "c.length=#{c.length}"

