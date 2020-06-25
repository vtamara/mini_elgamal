#!/usr/bin/env ruby
# Genera llave para ElGamal simplificado pues opera con primos de 32 bits
# vtamara@pasosdeJesus.org. 2020. Dominio público

require 'benchmark'
require_relative 'comunes'

# Genera un primo p de 32 bits de la forma 2*p1*p2+1 con 
# p1 primo de 17 bits y p2 primo de 14 bits
def genera_primo_32bits_con_log_dificil(primos17)
  p = 1
  p1 = 1
  p2 = 1
  loop do 
    ip1=Random.new.rand(0..(primos17.length-1))
    p1 = primos17[ip1]
    break if p1>2**16 
  end
  loop do
    ip2=Random.new.rand(0..(primos17.length-1))
    p2 = primos17[ip2]
    p = 2*p1*p2+1
    break if (p<2**32) && (p>2**31) && primo_relativo(p, primos17)
  end

  # p=2*p1*p2+1 es primo porque:
  # 1. p tiene exactamente 32 bits porque está entre 2^31 y 2^32
  # 2. p no tiene factores primos de 17 o menos bits porque todos los
  #    primos de hasta 17 bits son primos relativos con p
  # 3. supongamos que p no fuera primo, entonces existiría q primo y n entero
  #    tales que p=q*n
  #    q no podría ser un primo de 17 o menos bits porque en tal caso
  #    estaría en la tabla de primos y sería un primo relativo a p
  #    así que q tendría que tener 18 o más bits.
  #    Pero en tal caso n tendría que tener 14 o menos bits porque
  #    p=q*n y n tendría una descomposición en primos, que a su 
  #    vez serían factores primos de p y todos ellos
  #    de máximo 14 bits y por tanto todos los factores primos
  #    de n (y a la vez de p) estarían en la tabla primos contradiciendo
  #    que todos los primos de menos de 17 bits son primos relativos con p.

  return [p, p1, p2]
end

# Genera numg generadores del campo Z*_p donde p es primo de la forma
# 2*p1*p2+1
def genera_generadores_Zap(p, p1, p2, numg)
  # Como se esboza en https://crypto.stackexchange.com/questions/40654/find-the-generators-of-multiplicative-group-of-units-efficiently
  # Si g es generador de Z^*_p   g^k mod p != 1 con k=(p-1)/q para
  # cada q que sea factor primo diferente de p-1.
  gen = []
  while gen.length < numg
    i = rand(p)
    k1=p1*p2
    k2=2*p1
    k3=2*p2
    if (exp_mod(i, k1, p) != 1 && exp_mod(i, k2, p) != 1 && 
        exp_mod(i, k3, p) != 1)
      gen << i
    end
  end
  return gen
end


# Busca primer factor p primo de hasta 17 bits de n y lo retorna junto con
# el otro factor r  tal que p*r=n
# primos17 es lista de primos de hasta 17 bits.
def factoriza2_17(n, primos17)
  p1 = 0
  primos17.each do |p|
    if n % p == 0
      p1 = p
      break
    end
  end
  if p1 == 0
    puts "No se encontró primer factor primo de 17 bits"
    return nil
  end
  r = n/p1
  return [p1, r]
end


maxbits = 17
puts "Generando tabla de primos de hasta #{maxbits} bits"
primos17 = []
puts Benchmark.measure {
  primos17 = generaprimos_maxbits(maxbits)
}
puts "Generada tabla con primeros #{primos17.length} primos"


puts "Buscando aleatoriamente número primo p de 32 bits"
p, p1, p2 = genera_primo_32bits_con_log_dificil(primos17)
puts "  p1=#{p1} (es primo de 17 bits)"
puts "  p2=#{p2} (es primo de 14 bits)"
puts "  p=2*p1*p2+1=2*#{p1}*#{p2}+1=#{p} (es primo de 32 bits)"


puts "Buscando aleatoriamente generador de Z*_p"
gen = genera_generadores_Zap(p, p1, p2, 10)
puts "Alice ¿Cúal de los siguientes 10 generadores te gusta (teclea un número de 1 a 10)?"
i = 1
gen.each do |g|
  puts "#{i}. #{g}"
  i += 1
end
numg = $stdin.readline().chop.to_i
if numg>0 && numg<=gen.length
  g = gen[numg-1]
else
  g = gen[0]
end

puts "\nAlice, ¿Cúal es tu llave privada como cadena (4 letras)?"
priv_cad = $stdin.readline().chop[0..3]

priv = codifica_cadena_como_numero(priv_cad)
puts "Tu llave privada como número es #{priv}"

km = exp_mod(g, priv, p)
puts "\nAlice, tu llave pública es (g, K, p)=(#{g}, #{km}, #{p})"

