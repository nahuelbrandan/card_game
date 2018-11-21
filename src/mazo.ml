open Printf
open Persona
open List

let palos = ["E"; "B"; "O"; "C"]
let valores = ["1"; "2"; "3"; "4"; "5"; "6"; "7";"8"; "9"; "10"; "11"; "12"]
let cartas_especiales = ["ID"; "SWAP"; "MAX"; "MIN"; "TOP"; "PAR"; "SUME"; "MAS1"; "TPAR"]
let id_cartas_especiales = ["S"]

(* obtener elementos de una tupla *)
let get_1 (a,_) = a
let get_2 (_,a) = a

(* imprimir una lista de tuplas *)
let print_list listaCartas =
    List.map (fun x -> if (x = ("C","0")) then begin
                            printf " - ";
                        end else begin
                           printf "%s"(get_1 x);printf "%s"(get_2 x); print_string " "
                        end) listaCartas

let lengthMazo mazo = List.length mazo

(* maximo entre 2 cartas*)
let max_two_card (car1 : (string * string)) (car2 : (string * string)) =
begin
    let palo1 = get_1 car1 in
    let palo2 = get_1 car2 in

    let num1 = try int_of_string (get_2 car1) with Failure _ -> 0 in
    let num2 = try int_of_string (get_2 car2) with Failure _ -> 0 in
    
    if (num1 > num2) then begin
        car1;
    end
    else if (num2 > num1) then begin
        car2;
    end
    else begin
        if (palo1 = "E") then begin car1;end
        else if (palo1 = "B" && palo2 = "C") then begin  car1;end
        else if (palo1 = "B" && palo2 = "O") then begin  car1;end
        else if (palo1 = "O" && palo2 = "C") then begin  car1;end
        else car2;
    end
end

(*ganador de la ronda*)
let rec max_carta_ronda (mazo : (string * string) list) : (string * string)=
    match mazo with
    (*devuelvo C0, y en el return pongo una condiciÃ³n si es C0.*)
    | [] -> ("C","0") 
    | x::[] -> x
    | x::xs -> max_two_card x (max_carta_ronda xs)

(************************************************************)
let min_two_card (car1 : (string * string)) (car2 : (string * string)) =
begin
    let palo1 = get_1 car1 in
    let palo2 = get_1 car2 in

    let num1 = try int_of_string (get_2 car1) with Failure _ -> 0 in
    let num2 = try int_of_string (get_2 car2) with Failure _ -> 0 in

    if (num1 > num2) then begin
        car2;
    end
    else if (num2 > num1) then begin
        car1;
    end
    else begin
        if (palo1 = "E") then begin car2;end
        else if (palo1 = "B" && palo2 = "C") then begin  car2;end
        else if (palo1 = "B" && palo2 = "O") then begin  car2;end
        else if (palo1 = "O" && palo2 = "C") then begin  car2;end
        else car1;
    end
end

let rec min_carta_ronda (mazo : (string * string) list) : (string * string)=
    match mazo with
    (*devuelvo C0, y en el return pongo una condiciÃ³n si es C0.*)
    | [] -> ("C","0") 
    | x::[] -> x
    | x::xs -> min_two_card x (min_carta_ronda xs)

(************************************************************)

(*
Split a list into two parts; the length of the first part is given.
If the length of the first part is longer than the entire list, 
then the first part is the list and the second part is empty.
*)
let firstNCartas list n =
    let rec aux i acc = function
      | [] -> List.rev acc, []
      | h :: t as l -> if i = 0 then List.rev acc, l
                       else aux (i-1) (h :: acc) t  in
    aux n [] list;;


(*Extract a slice from a list.

Given two indices, i and k, the slice is the list containing the elements between 
the i'th and k'th element of the original list (both limits included).
Start counting the elements with 0 (this is the way the List module numbers elements).

# slice ["a";"b";"c";"d";"e";"f";"g";"h";"i";"j"] 2 6;;
- : string list = ["c"; "d"; "e"; "f"; "g"]
*)

let slice list i k =
    let rec take n = function
      | [] -> []
      | h :: t -> if n = 0 then [] else h :: take (n-1) t
    in
    let rec drop n = function
      | [] -> []
      | h :: t as l -> if n = 0 then l else drop (n-1) t
    in
    take (k - i + 1) (drop i list);;


let rec posicionMaxCart listCarts maxCart pos =
    match listCarts with
    | [] -> pos
    | x::xs -> if x == maxCart then pos else posicionMaxCart xs maxCart pos+1

let rec posicionMultipleMaxCart listCarts maxCart pos listReturn =
    match listCarts with
    | [] -> listReturn
    | x::xs -> if x == maxCart then begin
                    let listReturn = pos::listReturn in
                    posicionMultipleMaxCart xs maxCart (pos+1) listReturn;
              end
              else begin
                    posicionMultipleMaxCart xs maxCart (pos+1) listReturn;
              end

let cantidadCartasJugadas listCarts =
    let aux = List.filter (fun x -> x <> ("C","0")) listCarts in
    List.length aux

let rec removerCarta listCarts carta =
    List.filter (fun x -> x <> carta) listCarts

let agregarCartaAlFinal mazo carta =
    let reversal = List.rev mazo in
    let addCarta = carta::reversal in
    List.rev addCarta

let rec cartasPares mazo pares =
  match mazo with
    | []    -> pares
    | x::xs -> begin
      if (get_2 x = "2" || get_2 x = "4" || get_2 x = "6" || get_2 x = "8" || get_2 x = "10" || get_2 x = "12") then begin
        let pares = x::pares in
        cartasPares xs pares;
      end
      else begin
        cartasPares xs pares;
      end
    end

let rec removerMultiplesCartas mazo listaARemover =
    match listaARemover with
    | []    -> mazo
    | x::xs -> begin
        let mazo = removerCarta mazo x in
        removerMultiplesCartas mazo xs;
    end

let shuffle d = begin
    Random.self_init ();
    let nd = List.map (fun c -> (Random.bits (), c)) d in
    let sond = List.sort compare nd in
    List.map snd sond
end