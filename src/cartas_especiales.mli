open Persona

val sid   : persona -> (string*string) -> (string * string) list -> (string * string) list
val sswap : persona -> (string*string) -> (string * string) list -> (string * string) list
val stop  : persona -> (string*string) -> (string * string) list -> (string * string) list
val smax  : persona -> (string*string) -> (string * string) list -> (string * string) list
val smin  : persona -> (string*string) -> (string * string) list -> (string * string) list
val spar  : persona -> (string*string) -> (string * string) list -> (string * string) list
val ssume : persona -> (string*string) -> (string * string) list -> (string * string) list
val smas1 : persona -> (string*string) -> (string * string) list -> (string * string) list
val stpar : persona -> (string*string) -> unit