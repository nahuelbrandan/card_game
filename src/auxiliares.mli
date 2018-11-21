open Persona
(*remueve las primeras n cartas.*)
val remove_at : int ->  (string * string) list -> (string * string) list

(*funciones para tener la cabeza y la cola de una palabra *)
val strip_first_char : string -> string
val get_first_char   : string -> string

(*al final de la partidad printear los nombre y los puntajes de los jugadores*)
val printearResult : persona list -> unit

(*devuelve un bool que dice si es o no una carta especial*)
val esCartaEspecial : (string * string) -> bool
