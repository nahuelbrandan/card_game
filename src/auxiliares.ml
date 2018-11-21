open Printf
open Persona
open List
open Mazo

(* remover las primeras N cartas. *)
let rec remove_at n mazo =
begin
	match mazo with
	| [] -> []
    | h :: t -> if n = 0 then begin t; end else begin remove_at (n-1) t; end
end;;

(*funciones para tener la cabeza y la cola de una palabra.*)
let strip_first_char str =
  	if str = "" then "" else
  	String.sub str 1 ((String.length str) - 1)

let get_first_char str =
	if str = "" then "" else
	String.sub str 0 1

(*al final de la partidad printear los nombre y los puntajes de los jugadores*)
let rec printearResult listPlayers =
begin
	match listPlayers with
	| [] -> ();
	| x::xs ->  printf "%s  %d\n" (nombrePersona x) (puntosPersona x);
				printearResult xs;
end;;


(*devuelve un bool que dice si es o no una carta especial*)
let esCartaEspecial carta =
	let mazo_esp = List.concat (List.map (fun iD_cartas_esp -> List.map (fun cartas_esp -> (iD_cartas_esp, cartas_esp)) cartas_especiales) id_cartas_especiales) in
	if List.mem carta mazo_esp then true else false




