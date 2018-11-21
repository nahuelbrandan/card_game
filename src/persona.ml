open Printf

type persona = {nombre:string; posicion:int; mutable puntos:int; mutable cartas: (string * string) list};;

let crearPersona name x listCarts = {nombre=name; puntos=0; posicion=x; cartas= listCarts}
let nombrePersona men = men.nombre
let puntosPersona men = men.puntos
let posicionPersona men = men.posicion
let cartasPersona men = men.cartas
let agregarTodasSusCarta men cartaList = men.cartas <- cartaList

let tirarCartaDePersona menCartas carta =
	List.filter (fun x -> x <> carta) menCartas

let rec sumarPunto listMen pos =
begin
	let auxPer = List.nth listMen pos in
	let temp = puntosPersona auxPer +1 in
	auxPer.puntos <- temp;
end

let rec hayJugadoresActivos listMen =
	let result = List.fold_left (fun acc x -> if (x.cartas <> []) then (acc+1) else acc ) 0 listMen in
	if (result>1) then begin
		true;
	end else begin
		false;
	end
