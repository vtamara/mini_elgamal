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
# Calcula exponenciación módulo m
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


# Convierte un mensaje de texto de 4 bytes a número de 32 bits
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

# Convierte un número de 32 bits a mensaje de texto de 4 bytes
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

