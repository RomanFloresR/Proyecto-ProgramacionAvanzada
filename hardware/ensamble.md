Conexiones 
# sensores HW-006 V1.3 - tang nano 9k 
Los sensores infrarrojos HW-006 son los encargados de detectar la línea. Cada uno de los sensores tienen 3 terminales, Vcc que van
conectados hacia los 5v de la tang nano 9k y GND que se conceta a GND de la tang nano. Las salidas del sensor (output) van 
conectados a pines especificos de la placa de desarrollo, en nuestro caso utilizamos los pines 49, 48, 32, 31. 

# tang nano 9k - shield l298N 
La tang nano recibe la señales de los sensores y procesa los datos para controlar el movimiento. Nosotros utilizamos los puertos 
25, 26, 27 ,28 de la tang nano, para despues en el shield utilizar las entradas IN1, IN2, IN3 e IN4 del módulo y estos 
manden las señales necesarias para activar los motores.

# shield l298N - Motores
El módulo o shield es el encargado de alimentar y controlar los motores del carrito. Las terminales de los motores se conectaron
a las salidas OUT1, OUT2, OUT3 y OUT4 del shield l298N. 

# shield l298N - batería
Es la encargada de la alimentación del shield l298N, esto se realiza mediante una batería de 12 V conectada
a la terminal de voltaje y GND del shield l298N.


