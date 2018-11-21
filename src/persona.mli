type persona

val crearPersona : string -> int -> (string * string) list -> persona (*toma el nombre y la posicion, empieza con puntos=0 y cartas=[]*)

val nombrePersona : persona -> string

val puntosPersona : persona -> int

val posicionPersona : persona -> int

val cartasPersona : persona -> (string * string) list

val agregarTodasSusCarta : persona -> (string * string) list -> unit

val tirarCartaDePersona : 'a list -> 'a -> 'a list

(*sumar punto al jugador en la posicion n *)
val sumarPunto : persona list -> int -> unit

(*necesito una funcion que devuelta true si hay mas de 1 jugador con cartas.*)
val hayJugadoresActivos : persona list -> bool