# Implementación mínima del cifrado ElGamal con llaves inseguras de 32 bits.


*No usar para nada serio, porque la llave recomendada en la actualidad
debe ser de mínimo 1024 bits.*

Se basa en la descripción de <https://es.wikipedia.org/wiki/Cifrado_ElGamal>

Este repositorio incluye:
* Un documento con definiciones previas a la lectura de <https://es.wikipedia.org/wiki/Cifrado_ElGamal> y un ejemplo muy sencillo de cifrado/descifrado.  Disponible en formatos ODT y PDF en <https://github.com/vtamara/mini_elgamal/tree/master/ref>.  La fuente del documento es: <https://docs.google.com/document/d/1NDtZxxypZ29fSbg8Ta2t9dGH4UjfZfv3P0FH07WEyJ4/edit?usp=sharing>
* 4 pequeños programas:
   * `generallave.rb`: Genera una llave de 32 bits basada en un primo al que es "dificil" calcularle el logaritmo
   * `cifra.rb`: Cifra un mensaje de 4 caracteres
   * `descifra.rb`: Descifra un mensaje de 4 caracteres
   * `quiebra.rb`: Con suficiente tiempo puede quebrar ElGamal encontrando la llave privada a partir de una llave pública.
* El archivo de funciones comunes `comunes.rb`
* Pruebas de regresión a las funciones comúnes, que se ejecutan con 
```
  ./prueba_comunes.rb
```


Las siguientes secciones ejemplifican el uso de los 4 programas.

# 1. Generación de llaves

```sh
$ ./genllave.rb
Generando tabla de primos de hasta 17 bits
  5.770000   0.000000   5.770000 (  5.769579)
Generada tabla con primeros 12251 primos 
Buscando aleatoriamente número primo p de 32 bits
  p1=110849 (es primo de 17 bits)
  p2=11497 (es primo de 14 bits)
  p=2*110849*11497+1=2548861907 (es primo de 32 bits)
Buscando aleatoriamente generador de Z*_p
¿Cúal de los siguientes 10 generadores te gusta (teclea un número de 1 a 10)?
1. 1953695746
2. 1223416769
3. 1240374761
4. 1444142959
5. 1574970086
6. 447795980
7. 2359272014
8. 2081204531
9. 1219814882
10. 912756325
5

¿Alice cual es tu llave privada como cadena (4 letras)?
amor
Tu llave privada como número es 1634561906

Alice, tu llave pública es (g, K, p)=(1574970086, 1849619751, 2548861907)
```

# 2. Cifrado

```
$ ./cifra.rb
Bob, ¿Cúal es la llave pública de Alice?
¿g? 
1574970086
¿K? 
1849619751
¿p? 
2548861907

Bob ¿Cúal será tu b aleatorio y secreto entre 0 y 2548861906?
14123412

Bob, ¿Cúal será el mensaje a cifrar para Alice (cadena de 4 bytes)?
bien
m como número es 1651074414 que es de 31 bits

El mensaje cifrado (y1, y2):
  y1=1852640933
  y2=1030773935
```

# 3. Descifrado

```
$ ./descifra.rb
Alice, ¿Cúal es el y1 que te dió Bob?
1852640933
Alice, ¿Cúal es el y2 que te dió Bob?
1030773935
Alice, ¿Cúal es tu llave pública?
¿g? 
1574970086
¿K? 
1849619751
¿p? 
2548861907
Alice, ¿Cúal es tu llave privada?
amor
Tu llave como numero es 1634561906
El mensaje que Bob te envio como numero es m='1651074414' que es de 31 bits
El mensaje decodifado es: 'bien'
```

# 4. Quiebra 

```
$ ./quiebra.rb 
Atacanta, ¿Cúal es la llave pública de Alice?
¿g? 
1574970086
¿K? 
1849619751
¿p? 
2548861907
Quebrando
  a es 1634561906
  La clave cifrada de Alice fue 'amor'
```

