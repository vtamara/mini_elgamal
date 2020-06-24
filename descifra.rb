#!/usr/bin/env ruby
# Descifra mensaje cifrado con ElGamal con primo de 32 bits
# vtamara@pasosdeJesus.org. 20202. Dominio público

require_relative 'comunes'

puts "Alice, ¿Cúal es el y1 que te dió Bob?"
y1 = $stdin.readline.chop.to_i
puts "Alice, ¿Cúal es el y2 que te dió Bob?"
y2 = $stdin.readline.chop.to_i

puts "Alice, ¿Cúal es tu llave pública?"
puts "¿g? "
g = $stdin.readline.chop.to_i

puts "¿K? "
k = $stdin.readline.chop.to_i

puts "¿p? "
p = $stdin.readline.chop.to_i

puts "Alice, ¿Cúal es tu llave privada?"
ac = $stdin.readline.chop
a = codifica_cadena_como_numero(ac)
puts "Tu llave como numero es #{a}"

m = (exp_mod(y1, -a, p) * y2) % p
mb = m.to_s(2)

puts "El mensaje que Bob te envio como numero es m='#{m}' que es de #{mb.length} bits"

c = decodifica_cadena_de_numero(m)
puts "El mensaje decodifado es: '#{c}'"

