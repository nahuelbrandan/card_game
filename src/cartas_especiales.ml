open Printf
open List
open Random
open Persona
open Mazo
open Auxiliares

let sid (x:persona) (play:(string*string)) (mazo:'a list) =
begin
	(*tengo que dejar los mazos como estan*)
	printf "la carta SID deja los mazos como estan\n";
	(*me devuelve las cartas del jugador*)
	let temp = cartasPersona x in
	(*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
	let listTemp =  tirarCartaDePersona temp play in
	(*le asigna al jugador las mismas listas de cartas, pero sin la que tiro a la mesa.*)
	let _ = agregarTodasSusCarta x listTemp in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    (* retorno mazo *)
    mazo;
end;;

let sswap (x:persona) (play:(string*string)) (mazo:'a list) =
begin
    (*SWAP | Cambia el mazo del jugador por el mazo general |*)
    printf "la carta SWAP  intercambia los mazos del jugador con el de la mesa\n";
    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in
    (*le asigna al jugador las cartas de la mesa.*)
    let _ = agregarTodasSusCarta x mazo in
    (*ahora le asigno al mazo las cartas del jugador*)
    let mazo = listTemp in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let stop (x:persona) (play:(string*string)) (mazo:'a list) =
begin
    (*Toma una carta del tope del mazo general*)
    printf "la carta STOP toma una carta del tope del mazo\n";
    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in
    (*le asigna al jugador las mismas listas de cartas, pero sin la que tiro a la mesa.*)
    let _ = agregarTodasSusCarta x listTemp in

    (*ahora debo tomar una carta del mazo si se puede.*)
    (*hacerlo unicamente si el mazo no es vacio*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in
    (* lo hacemos 2 veces, una por la carta especial y otro por que siempre lo tiene que hacer*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let smax (x:persona) (play:(string*string)) (mazo:'a list) =
begin
    (*Toma la maxima carta del mazo general*)
    printf "la carta SMAX toma la carta maxima del mazo\n";

    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in
    (*le asigna al jugador las mismas listas de cartas, pero sin la que tiro a la mesa.*)
    let _ = agregarTodasSusCarta x listTemp in

    (*ahora debo tomar la max carta del mazo si se puede.*)
    let cartaTemp = max_carta_ronda mazo in
    (*agregar la carta maxima solo en el caso en que sea distinta de "C" "0"*)
    if ((get_1 cartaTemp) = "C" && (get_2 cartaTemp) = "0") then begin
    end
    else begin
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    (*debo retirar la carta maxima del mazo general *)
    let mazo = removerCarta mazo cartaTemp in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let smin (x:persona) (play:(string*string)) (mazo:'a list) =
begin
    (*Toma la minima carta del mazo de la persona y lo pone al final del mazo general*)
    printf "la carta SMIN Toma la minima carta del mazo de la persona y lo pone al final del mazo general\n";

    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in
    (*le asigna al jugador las mismas listas de cartas, pero sin la elegida.*)
    let _ = agregarTodasSusCarta x listTemp in

    (* debo tomar la minima carta del jugador *)
    let cartaMin = min_carta_ronda (cartasPersona x) in

    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp cartaMin in
    (*le asigna al jugador las mismas listas de cartas, pero sin la elegida.*)
    let _ = agregarTodasSusCarta x listTemp in

    (*agregar cartaMin al final del mazo de la mesa *)
    let mazo = agregarCartaAlFinal mazo cartaMin in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let spar (x:persona) (play:(string*string)) (mazo:'a list) = 
begin
    (*Toma todas las carta pares del mazo general*)
    printf "la carta SPAR toma todas las cartas pares del mazo\n";
    
    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in
    (*le asigna al jugador las mismas listas de cartas, pero sin la que tiro a la mesa.*)
    let _ = agregarTodasSusCarta x listTemp in

    (* debo tomar todas las cartas pares del mazo general *)
    let pares = cartasPares mazo [] in
    (*remover dichas cartas del mazo general *)
    let mazo = removerMultiplesCartas mazo pares in
    (*asignarselas a las cartas del jugador *)
    (** listTemp tiene las cartas del jugador, le tengo que concatenar la lista pares *)
    let listTemp = List.append listTemp pares in
    (*le asigna al jugador las mismas listas de cartas concatenada a la lista de pares .*)
    let _ = agregarTodasSusCarta x listTemp in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let ssume (x:persona) (play:(string*string)) (mazo:'a list) =
begin
    (*Crea una nueva carta de espadas, cuyo valor es la suma de los valores de la carta en mano*)
    printf "la carta SSUME crea una nueva carta de espadas cuyo valor es la suma de los valores de la carta en mano\n";
    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in

    (* ahora tenemos que hacer la suma de todos los valores de mis cartas.*)
    (* val split : ('a * 'b) list -> 'a list * 'b list*)
    let (_,right) = List.split listTemp in
    (* teniendo los numeros pasarlos a int *)
    let aa = List.map(fun x -> try int_of_string x with int_of_string->0) right in

    (*sumamos*)
    let result = List.fold_left (+) 0 aa in
    (*ya tenemos el numero ahora lo pasamos a string*)
    let resultString = string_of_int result in

    let listTemp = ("E",resultString)::listTemp in
        (*le asigna al jugador las mismas listas de cartas, pero sin la que tiro a la mesa.*)
    printf "se creo la carta E%d\n" result;
    let _ = agregarTodasSusCarta x listTemp in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let rec volverCartaEspecial (resultString:string list) (right:string list) (posicion:int) (retorno:string list)=
begin
    match resultString with
        | [] -> List.rev retorno
        | x::xs -> begin
                    if (x="1") then begin
                        let retorno = (List.nth right posicion)::retorno in
                        volverCartaEspecial xs right (posicion+1) retorno;
                    end else begin
                        let retorno = x::retorno in
                        volverCartaEspecial xs right (posicion+1) retorno;
                    end
                end
end

let smas1 (x:persona) (play:(string*string)) (mazo:'a list) =
begin
    (*Le suma uno a todas las cartas (no especiales) del jugador*)
    printf "La carta SMAS1 le suma uno a todas las cartas (no especiales) del jugador\n";
    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in

    (* val split : ('a * 'b) list -> 'a list * 'b list*)
    let (left,right) = List.split listTemp in

    (* teniendo los numeros pasarlos a int *)
    let aa = List.map(fun x -> try int_of_string x with int_of_string->0) right in

    (*le sumamos uno a cada valor *)
    let mas1 = List.map(fun x -> x+1) aa in

    (*ya tenemos el numero ahora lo pasamos a string*)
    let resultString = List.map(fun x -> string_of_int x) mas1 in

    
    (*el problema es que ahora modifique todas las cartas especiales por el string "1" 
      tengo que volver a ponerlos como estaban *)
    let withSpecial = volverCartaEspecial resultString right 0 [] in
    
    (*ahora hacemos la contrareciproca de split*)
    let combinado = List.combine left withSpecial in

    (*le asigna al jugador las cartas.*)
    let _ = agregarTodasSusCarta x combinado in

    (*ahora debo tomar una carta del mazo si se puede.*)
    if mazo != [] then begin
        printf "El jugador toma una carta\n";
        let cartaTemp = List.hd mazo in
        let cartasJugador = cartasPersona x in
        agregarTodasSusCarta x (cartaTemp::cartasJugador);
    end;
    let mazo = remove_at 0 mazo in

    mazo;
end

let stpar (x:persona) (play:(string*string)) =
begin
    (*Si todas las cartas son pares agrega la carta E12, sino no  hace nada*)
    printf "STPAR: Si todas las cartas son pares agrega la carta E12, sino no  hace nada \n";

    (*me devuelve las cartas del jugador*)
    let temp = cartasPersona x in
    (*me devuelve las cartas del jugador sin la carta que quiero tirar.*)
    let listTemp =  tirarCartaDePersona temp play in
    (* val split : ('a * 'b) list -> 'a list * 'b list*)
    let (left,right) = List.split listTemp in
    (* teniendo los numeros pasarlos a int *)
    let aa = List.map(fun x -> try int_of_string x with int_of_string->0) right in
    (* ahora tengo que ver si todos son pares. 
        A las cartas especiales les asigne 0 asi que no hay problemas con ellos. *)
    let allPar = List.for_all(fun x -> x mod 2 == 0) aa in

    if (allPar) then begin
        printf "el jugador TIENE todas sus cartas pares, por lo tanto se ganó un E12, bien ahí!!\n";
        let listTemp = ("E","12")::listTemp in
       (*le asigna al jugador las cartas.*)
        agregarTodasSusCarta x listTemp
    end
    else begin
        printf "el jugador NO TIENE todas sus cartas pares,\n";
       (*le asigna al jugador las cartas.*)
        agregarTodasSusCarta x listTemp
    end
end
