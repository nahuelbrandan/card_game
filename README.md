#Proyecto 3 - Paradigmas de la programación.
## Juego: La guerra funcional, version 1.0, julio/2016.

por consultas o sugerencias
contacto: nahuelbrandan123@gmail.com
Desarrollador: Nahuel Brandán.

##Comentarios:
Lab interesante.

El compilador es excelente, aúnque pienso debería ser más informativo con los problemas.

##Decisión de diseño:
	* Nuestro mazo es de tipo "(string * string) list", resulta en una lista tuplas que contienen tanto el palo como el valor numerico de las cartas.
	
	* Cada jugador cuenta con una estructura compuesta por (nombre, puntos, posicion en la mesa, lista de cartas).
	*Contamos con una modularizacion compuesta de la siguiente forma:
					|-----------|      |-----------| |------------|
					|	mazo    |	   | persona   | | auxiliares |
					|-----------|	   |-----------| |------------|
							   \		/           /
								\	   /           /
							|--------------| <----/
							|			   |
							|	  main     |
							|--------------|
			DONDE:
				* Maso contiene: la inicializacion del mazo principal y funciones respectivas para trabajar con este.
				* Persona contine: La estructura de cada jugador y funciones para las acciones de los mismos.
				* Auxiliares: tiene algunas funciones de ayuda
				* Main contiene: Los menues para poder jugar (ingresar los jugadores, jugar, etc), y tambien otras funciones necesarias para poder llevar todo a cabo.

	* Decidimos hacer la carga de los jugadores de forma imperativa, ya que al necesitar interacción con el usuario es mejor.

	* Para ejecutar: usamos un makefile que se encarga tanto de compilar, mover el objeto ejecutable a la carpeta correspondiente (bin) y eliminar los archivos de compilacion y el elemento ejecutable. Luego de esto recurrimos al comando "./bin/main.native" para ejecutar efectivamente dicho programa.
	* Luego de terminar de usar este programa, recurrimos al comando "make clean" y con esto eliminamos todos los archivos extras necesarios para la ejecucion como el elemento ejecutable.

## Modificaciones a lo pedido:
    * La muestra de la ronda no es exactamente como lo piden, sino que se muestra una lista ordenada de las cartas que se tiran, en el caso que un jugador se queda sin cartas se muestra un guion (-) en su lugar.

##Problemas encontrados:
	* Demasiados problemas con errores de sintaxis, que nos terminaron demorando mucho en el desarrollo del juego.

### Forma de ejecutarlo:
	situados en la carpeta principal hacemos 'make' para compilar y ./bin/main.native para ejecutar.

### Negativo: 

		_resultado final no esta ordenado.

### Positivo:
	El juego es completamente funcional, con cartas cartas especiales que en la primera entrega no se llegó a hacer.

# Última corrección.

## Laboratorio 3

**Corregido por:** Beta

### Nota: 6

Los problemas principales están en la arquitectura, pero la funcionalidad esta en general muy bien.

### Estructura

 * Crean archivo `./bin` si el dir no existe.
 * Bien el README aclarando todo lo que no hicieron.

### Funcionalidad

 * La info de las rondas no se respeta del todo.
 * Cuando se juega una carta especial no toman una carta del mazo.
 * No ordenan las posiciones al final.
 * Bien los clears y las infos de lo que hace cada carta especial.

### Arquitectura

 * Los tipos en `mazo` para cartas no se utilizan, y al final una carta es un par de strings.
 * El tipo de carta (el par de strings) es poco abstracto.
 * Utilizan campos mutables, que no corresponde al estilo funcional que se pedia.
 * Algunas funciones son largas y poco modularizadas (en particular, `rondaDeJuego`).
 * Reinventan muchas funciones estándar, y en particular no cumplen satisfactoriamente el punto extra pedido.

### Estilo

 * La indentación esta rota en muchos lados, pero en general esta aceptable.
 * La función de comparación de cartas es muy fea: en vez de transformar a números, comparan strings.

# Mejoras desde ésta última corrección:

* Se modularizó `rondaDeJuego`, creando funciones para cada carta especial, y éstas se pusieron en un nuevo TAD `cartas_especiales`

* Se pasaron varias de las funciones que utilizaban recursión y pattern matching por uso de funciones 	de la libreria para listas, aun que quedan otras tantas que se podrian pasar. 

* Se mejoró la función `max_two_card`, ésta estaba muy fea comparaba strings, ahora se pasan a int los valores numericos de las cartas y ahora éstos se comparan de mejor forma.

* Se crearon y aplicaron las nuevas cartas especiales.

* Se crea el directorio /bin si éste no existiera.

* Ahora si cada vez que se juega una carta especial se toma una del mazo.
 

### Comentarios:
* Sé que no se debería utilizar campos mutables, y que los utilizo en 2 parámetros de la estructura persona, pero tratar de cambiarlo ahora implicaría una modificación importante a todo el programa que me demandaría mucho tiempo.

* Utilicé en todo lo que pude funciones de listas. 

* El pograma es completamente funcional, con cartas especiales nuevas. Espero que los elementos que le faltan sean suficientes como para dar por desaprobado el laboratorio. Aprendi mucho sobre el paradigma, y el proceso de desarrollo, consultando varias veces en foros como stackoverflow.

