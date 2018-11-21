open Persona

val palos : string list
val valores : string list

val cartas_especiales : string list
val id_cartas_especiales : string list

val get_1 : 'a * 'b -> 'a
val get_2 : 'a * 'b -> 'b

(*si la carta es ("C","0") se printea un gion (-) *)
val print_list : (string * string) list -> unit list
val lengthMazo : (string * string) list -> int
val firstNCartas : 'a list -> int -> 'a list * 'a list
val slice : 'a list -> int -> int -> 'a list
val max_carta_ronda : (string * string) list -> (string * string)
val min_carta_ronda : (string * string) list -> (string * string)
val posicionMaxCart : (string * string) list -> (string * string) -> int -> int
val posicionMultipleMaxCart : (string * string) list -> (string * string) -> int -> int list -> int list
val cantidadCartasJugadas : (string * string) list -> int
val removerCarta : (string * string) list -> (string * string) -> (string * string) list
val removerMultiplesCartas : (string * string) list -> (string * string) list -> (string * string) list
val agregarCartaAlFinal : (string * string) list -> (string * string) -> (string * string) list
val cartasPares : (string * string) list -> (string * string) list -> (string * string) list
val shuffle :  (string * string) list -> (string * string) list 
