# Funciones comunes para ElGamal.
# vtamara@pasosdeJesus.org. 2020. Dominio público

# Traducido de https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm#Computing_multiplicative_inverses_in_modular_structures
def inversomult_mod(a, m)
  t = 0
  nt = 1
  r = m
  nr = a
  while nr != 0 do
    q = r / nr
    tp = nt
    nt = t - q*nt
    t = tp
    rp = nr
    nr = r - q*nr
    r = rp
  end
  if r > 1 then
    return "a is not invertible"
  end
  if t < 0 then
    t = t + m
  end
  return t
end


# Calcula b**e mod m
# https://en.wikipedia.org/wiki/Modular_exponentiation
def exp_mod(b,e,m)
  if m == 1 then
    return 0
  end

  if e < 0 then
    # Buscamos d tal que b*d (=m) 1
    d = inversomult_mod(b, m)
    e = e*-1
    b = d 
  end

  r = 1
  b = b % m
  while e > 0 do
    if e % 2 == 1 then
      r = (r*b) % m
    end
    e = e >> 1
    b = (b*b) % m
  end
  return r
end


# Convierte un mensaje de texto a número 
# De cada caracter toma el ordinal (ascii) y concatena las representaciones binarias de todos los caracteres alieandos a 8 bits.
def codifica_cadena_como_numero(c)
  i = 0
  nb = ""
  while i < c.length
    cib = c[i].ord.to_s(2).rjust(8, '0')
    nb = nb + cib
    i += 1
  end
  n = nb.to_i(2)
  return n
end

# Convierte un entero producido con codifica_cadena_en_numero al mensaje de texto original
def decodifica_cadena_de_numero(n)
  nb =n.to_s(2)
  while nb.length % 8 != 0
    nb = '0' + nb
  end
  c = ''
  nl = 0
  while (nl*8<nb.length)
    sl = nb[nl*8..nl*8 + 7]
    ol = sl.to_i(2)
    l = ol.chr
    c += l
    nl += 1
  end
  return c
end

# Genera lista de primos de hasta maxbits bits
def generaprimos_maxbits(maxbits)
  primos=[]
  i = 2
  m = 2**maxbits
  while i < m
    ip = 0
    while ip < primos.length && i % primos[ip] != 0
      ip += 1
    end
    if ip == primos.length
      primos.push(i)
    end
    i += 1
  end
  return primos
end

# Genera listado de primos de hasta maxbits bits
# usando criba de Eratostenes.
# Es un poco más lento que generaprimos_maxbits y requiere mucho espacio
def generaprimos_maxbits_criba(maxbits)
  criba = [2]
  m = 2**maxbits
  i = 1
  while i < m/2
    criba << i*2+1
    i += 1
  end
  pc = 1
  while pc < criba.length
    i = pc + 1
    while (i < criba.length)
      if criba[i] % criba[pc] == 0
        criba.delete_at(i)
      else
        i += 1
      end
    end
    pc += 1
  end
  return criba
end


# Decide si n es primo relativo a los número de la lista numeros
def primo_relativo(n, lnum)
  lnum.each do |p|
    return false if n % p == 0
  end
  return true
end

