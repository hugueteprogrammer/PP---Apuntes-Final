(* Tipos de piezas disponibles *)
type tipo_pieza = Rey | Dama | Torre | Alfil | Caballo | Peon
(* Coordenadas (columna, fila). Rango 0..7 *)
type pos = int * int
(* Representación de una pieza en el tablero *)
type pieza = {
  id : int;          (* Identificador único para evitar comparaciones complejas *)
  tipo : tipo_pieza; (* Tipo de la figura *)
  loc : pos;         (* Ubicación actual (col, fila) *)
}
(*El estado se representa simplemente como una lista de piezas*)
type estado = pieza list

(*--- HERRAMIENTAS AUXILIARES ---*)

(* Convierte caracteres a índices y viceversa *)
let char_to_col c = int_of_char c - int_of_char 'a'
let col_to_char i = char_of_int (i + int_of_char 'a')
let char_to_row c = int_of_char c - int_of_char '1'
let row_to_char i = char_of_int (i + int_of_char '1')

(*Formatea un movimiento para la salida*)
let string_of_move (x1,y1) (x2,y2) =
  String.make 1 (col_to_char x1) ^
  String.make 1 (row_to_char y1) ^
  String.make 1 (col_to_char x2) ^
  String.make 1 (row_to_char y2)

(*Verifica si una posición está dentro del tablero 8x8*)
let dentro (c, r) = c >= 0 && c <= 7 && r >= 0 && r <= 7

(*Busca si hay una pieza en una coordenada específica*)
let rec find_at (c, r) piezas =
  match piezas with
  | [] -> None
  | p :: rest -> if p.loc = (c, r) then Some p else find_at (c, r) rest

(*--- MOVIMIENTOS ---*)

(*Direcciones de movimiento (delta_col, delta_row)*)
let dirs_torre = [(1,0); (-1,0); (0,1); (0,-1)]
let dirs_alfil = [(1,1); (1,-1); (-1,1); (-1,-1)]
let dirs_reina = dirs_torre @ dirs_alfil
let dirs_caballo = [(1,2); (1,-2); (-1,2); (-1,-2); (2,1); (2,-1); (-2,1); (-2,-1)]
let dirs_rey = dirs_reina (*El rey se mueve igual que la reina pero solo 1 paso*)

let obtener_capturas (atacante : pieza) (piezas : estado) : (pos * pieza) list =
  let { tipo; loc = (cx, cy); _ } = atacante in
  
  (*Función auxiliar para piezas deslizantes (R, D, A)*)
  let explorar_direccion (dx, dy) =
    let rec loop x y =
      let next_pos = (x + dx, y + dy) in
      if not (dentro next_pos) then [] (*Salio del tablero*)
      else
        match find_at next_pos piezas with
        | None -> loop (x + dx) (y + dy) (*Casilla vacía, sigue buscando*)
        | Some victima -> [(next_pos, victima)] (*Captura y se detiene*)
    in
    loop cx cy
  in

  match tipo with
  | Rey ->
      List.fold_left (fun acc (dx, dy) ->
        let dest = (cx + dx, cy + dy) in
        if dentro dest then
          match find_at dest piezas with
          | Some v -> (dest, v) :: acc
          | None -> acc
        else acc
      ) [] dirs_rey

  | Caballo ->
      List.fold_left (fun acc (dx, dy) ->
        let dest = (cx + dx, cy + dy) in
        if dentro dest then
          match find_at dest piezas with
          | Some v -> (dest, v) :: acc
          | None -> acc
        else acc
      ) [] dirs_caballo

  | Peon ->
      (*El peón blanco siempre sube (row + 1)*)
      let targets = [(cx - 1, cy + 1); (cx + 1, cy + 1)] in
      List.fold_left (fun acc dest ->
        if dentro dest then
          match find_at dest piezas with
          | Some v -> (dest, v) :: acc
          | None -> acc
        else acc
      ) [] targets

  | Torre -> List.flatten (List.map explorar_direccion dirs_torre)
  | Alfil -> List.flatten (List.map explorar_direccion dirs_alfil)
  | Dama  -> List.flatten (List.map explorar_direccion dirs_reina)

(*--- SOLUCIÓN ---*)

(*Elimina una pieza de la lista por ID*)
let remove_piece id lista =
  List.filter (fun p -> p.id <> id) lista

(*Actualiza la posición de una pieza*)
let update_piece id nueva_pos lista =
  List.map (fun p -> if p.id = id then { p with loc = nueva_pos } else p) lista

(*Función recursiva principal.*)
let rec solve (piezas : estado) (historial : string list) : string list option =
  match piezas with
  | [] -> None (*Estado invalido, no deberia ocurrir*)
  | [_] -> Some (List.rev historial) (*CASO BASE: Queda solo 1 pieza*)
  | _ ->
      (*Intentar mover cada pieza disponible*)
      let rec iterar_atacantes lista_restante =
        match lista_restante with
        | [] -> None (*Ninguna pieza pudo generar una solución válida*)
        | atacante :: resto ->
            (*Generar todas las capturas posibles para esta pieza*)
            let capturas = obtener_capturas atacante piezas in
            (*Probar cada captura recursivamente*)
            let rec probar_capturas lista_capturas =
              match lista_capturas with
              | [] -> iterar_atacantes resto (*Siguiente atacante*)
              | (destino, victima) :: otras_capturas ->
                  (*1.Construir string del movimiento*)
                  let  mov_str = string_of_move atacante.loc destino in
                  
                  (*2. Crear nuevo estado*)
                  let estado_sin_victima = remove_piece victima.id piezas in
                  let nuevo_estado = update_piece atacante.id destino estado_sin_victima in
                  
                  (*3. Llamada recursiva*)
                  match solve nuevo_estado (mov_str :: historial) with
                  | Some sol -> Some sol (*Solución encontrada, propagar hacia arriba*)
                  | None -> probar_capturas otras_capturas (*Backtracking*)
            in
            probar_capturas capturas
      in
      iterar_atacantes piezas

(*--- ENTRADA Y MAIN ---*)

let entrada str =
  let len = String.length str in
  let rec aux i id_acc acc =
    if i >= len then acc
    else
      let tipo_char = str.[i] in
      let col_char = str.[i+1] in
      let row_char = str.[i+2] in
      
      let tipo = match tipo_char with
        | 'r' -> Rey | 'd' -> Dama | 't' -> Torre 
        | 'a' -> Alfil | 'c' -> Caballo | 'p' -> Peon
        | _ -> raise (Failure "Caracter de pieza invalido")
      in
      let loc = (char_to_col col_char, char_to_row row_char) in
      let p = { id = id_acc; tipo = tipo; loc = loc } in
      
      aux (i + 3) (id_acc + 1) (p :: acc)
  in
  (*Invertimos para mantener orden original*)
  List.rev (aux 0 0 [])

let () =
  try
    if Array.length Sys.argv < 2 then (
      print_endline "Uso: ./ajedrez <string_tablero>";
      exit 0
    );
    
    let input_str = Sys.argv.(1) in
    let estado_inicial = entrada input_str in
    
    (*Iniciar búsqueda*)
    match solve estado_inicial [] with
    | Some movimientos -> 
        (*Imprimir movimientos separados por espacio*)
        print_endline (String.concat " " movimientos)
    | None -> 
        print_endline "imposible"
        
  with e ->
    (*Captura de errores genéricos para seguridad*)
    Printf.eprintf "Error: %s\n" (Printexc.to_string e);
    exit 1