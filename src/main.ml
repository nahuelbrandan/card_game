(*
	**********************La guerra funcional**********************
	Desarrollador: Nahuel Brandan.
*)
open Printf
open List
open Random
open Persona
open Mazo
open Auxiliares
open Cartas_especiales

(*carga de los jugadores.*)
let rec nombreJugador i lista mazo: persona list =
begin
	(* caso en que se completo el maximo de jugadores.*)
	if i >= 5 then begin
		printf "cantidad de jugadores lleno\n";
		lista;
	end
	else begin
		printf "Ingrese el nombre del jugador Nº %d o EXIT para comenzar el juego\n" i;
 	    let name = read_line () in (*SCANF*)

 	    (*caso en que el usuario no ingresa nada*)
	    if name = "" then begin
	   		printf "ingrese un nombre verdadero\n";
	   		nombreJugador i lista mazo;
	   	end
		else begin
			if name = "EXIT" then
		   		if i<2 then begin
	   				printf "no podemos jugar con <2 jugadores\n";
	   				[];
	   			end
	   			else begin
   					printf "que comience el juego!\n";
   					lista;
	   			end
	   		else begin
        		(*start y finish son los limites de las cartas que se le va a repartir a esta persona.*)
        		let start = i*7 in
        		let finish = i*7+6 in
        		let tempCarts = slice mazo start finish in
        		let lista = crearPersona name i tempCarts:: lista in
        		nombreJugador (i+1) lista mazo;
        	end
		end
	end
end;;

let rec rondaDeJuego (listPlayers:persona list) (mazo:'a list) (cartasJugadas:'a list) =
begin
	match listPlayers with
	| [] -> (cartasJugadas,mazo)
	| x::xs ->
		(* imprimir el menu y ejecutar sus acciones.*)
		begin
			(* caso en que el jugador se quedo sin cartas. *)
			if (cartasPersona x = []) then begin
				printf "El jugador %s ya no tiene cartas.\n" (nombrePersona x);
				let cartasJugadas = ("C","0") :: cartasJugadas in
				(*llamada recursiva*)
				rondaDeJuego xs mazo cartasJugadas;
			end
		    else begin
		    	(*** menu **)
				let length = List.length mazo in
				printf "Mazo: %d cartas\n" length;
				printf "Ronda: ";(*imprimir la lista de cartas en la mesa.*)
				let _ = print_list cartasJugadas in
				printf "\n%s(%d) " (nombrePersona x) (puntosPersona x);
				let _ = print_list (cartasPersona x) in
				(************)

				printf "\nQue carta vas a jugar %s?\n" (nombrePersona x);
			   	let play = read_line () in (*SCANF*)
			   	ignore(Sys.command "clear");

			   	(*necesito dividir la entrada, y hacerla una tupla para poder compararla con las cartas.*)
				let fst = get_first_char play in
				let lst = strip_first_char play in
				let play = (fst,lst) in

				(*ahora tengo que ver si la carta existe*)
				let b = List.mem play (cartasPersona x) in
				(*caso en que si existe la carta tirarla, retirarla de la lista de cartas de la mano y agregarla a la lista de la mesa. *)
				if(b) then begin
					match play with
					| ("S","ID") -> begin
                        let mazo = sid x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","SWAP") -> begin
                        let mazo = sswap x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;		
					end
					| ("S","TOP") -> begin
                        let mazo = stop x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","MAX") -> begin
                        let mazo = smax x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","MIN") -> begin
                        let mazo = smin x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","PAR") -> begin
                        let mazo = spar x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","SUME") -> begin
                        let mazo = ssume x play mazo in
					    rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","MAS1") -> begin
                        let mazo = smas1 x play mazo in
						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| ("S","TPAR") -> begin
                        let _ = stpar x play in

                        (*ahora debo tomar una carta del mazo si se puede.*)
					    if mazo != [] then begin
					    	printf "El jugador toma una carta\n";
					        let cartaTemp = List.hd mazo in
					        let cartasJugador = cartasPersona x in
					        agregarTodasSusCarta x (cartaTemp::cartasJugador);
					    end;
					    let mazo = remove_at 0 mazo in

						rondaDeJuego listPlayers mazo cartasJugadas;
					end
					| _ -> begin
						(*agrego la carta a la lista de la mesa*)
						let cartasJugadas = play :: cartasJugadas in
						(*me devuelve las cartas del jugador*)
						let temp = cartasPersona x in
						(*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
						let listTemp =  tirarCartaDePersona temp play in
						(*le asigna al jugador las mismas listas de cartas, pero sin la que tiro a la mesa.*)						
						let _ = agregarTodasSusCarta x listTemp in

						(*ahora debo tomar una carta del mazo si se puede.*)
						if mazo != [] then begin
							let cartaTemp = List.hd mazo in
							let cartasJugador = cartasPersona x in
							agregarTodasSusCarta x (cartaTemp::cartasJugador);
						end;
						let mazo = remove_at 0 mazo in

						(*ahora la llamada recursiva para que jueguen los otros tambien.*)
						rondaDeJuego xs (mazo:'a list) (cartasJugadas:'a list);
					end;
				end
				(*sino estÃ¡ la carta volver a preguntar que jugar*)
				else begin
					printf "Solo podes tirar una de las cartas que posees\n";
					rondaDeJuego listPlayers mazo cartasJugadas;
				end;
			end;
		end;
end;;

let rec partidaPropiamentedicha mazo listPlayers =
	match (hayJugadoresActivos listPlayers) with
		| false -> listPlayers
		| true  -> 
			begin				
				(*tengo las cartas que se jugaron en mesa.*)
				let (cartasJugadas,mazo) = rondaDeJuego listPlayers mazo [] in

				(*acodo al reves, para tener la primera que se jugo en la primer posicion*)
				let cartasJugadas = List.rev cartasJugadas in

				(*mayor carta de la ronda *)
				let maxCarta = max_carta_ronda cartasJugadas in

				(*ok, tengo la mayor carta pero puede que este repetida*)
				if (List.mem maxCarta cartasJugadas) then begin
					(*ahora tengo que ver quien tiro ésa carta.*)
					let pos = posicionMaxCart cartasJugadas maxCarta 0 in
					(*ahora que conozco la posicion, agregar un punto al jugador en dicho lugar*)
					let _ = sumarPunto listPlayers pos in

					let auxname = nombrePersona (nth listPlayers pos) in
					printf "El jugador %s gano la ronda.\n" auxname;

					(*llamada recursiva*)
					partidaPropiamentedicha mazo listPlayers;

				end
				else begin
					(*si entra aca quiere decir que hay multiples max_carta*)
					(*ahora tengo que ver quienes tiraron ésa carta.*)
					let allPos = posicionMultipleMaxCart cartasJugadas maxCarta 0 [] in
					(*ahora que las posiciones, sumar un punto a todos los jugador en dichos lugares *)
					let _ = List.map(fun x -> sumarPunto listPlayers x) allPos in

					printf "los ganadores de la ronda son: ";
					let _ = List.map(fun x -> printf "%s " (nombrePersona (List.nth listPlayers x))) allPos in

					(*llamada recursiva*)
					partidaPropiamentedicha mazo listPlayers;
				end
			end

(******************************LLAMADA A LAS FUNCIONES.********************************)
(* creamos el mazo *)
let mazo = List.concat (List.map (fun palo -> List.map (fun valor -> (palo, valor)) valores) palos)
let mazo_esp = List.concat (List.map (fun iD_cartas_esp -> List.map (fun cartas_esp -> (iD_cartas_esp, cartas_esp)) cartas_especiales) id_cartas_especiales)
let mazo = mazo@mazo_esp;;
(*mezclo el mazo*)
let mazo = shuffle mazo;;
(* cargamos los jugadores *)
let listPlayers = [];;
let listPlayers = nombreJugador 0 listPlayers mazo;;
(* caso en que no subio los suficientes jugadores para empezar *)
if listPlayers = [] then begin exit 0; end
(* para acomodarlos en el orden de ingreso, los doy vuelta *)
let listPlayers = List.rev listPlayers;;
(*limpiamos la pantalla*)
Sys.command "clear";;

(*remover las cartas repartidas a los jugadores.*)
let lengthPlayers = List.length listPlayers;;
let aux = 7*lengthPlayers -1;;
let mazo = remove_at aux mazo;;

(* el juego en si *)
let listPlayers = partidaPropiamentedicha mazo listPlayers;;

(*resultado final*)
printf "\nGAME OVER: Resultados\n";;
let _ = printearResult listPlayers;;
