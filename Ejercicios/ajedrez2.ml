type tipo =
  | Rey | Dama | Torre | Alfil | Caballo | Peon

type pos = int * int  (* (col, fila), 0..7 *)

type pieza = { id : int; tipo : tipo; pos : pos }

type estado = pieza list

(* Conversión entre caracteres y coordenadas *)

let col_of_char c = Char.code c - Char.code 'a'
let char_of_col x = Char.chr (x + Char.code 'a')
let row_of_char c = (Char.code c - Char.code '1')
let char_of_row y = Char.chr (y + Char.code '1')

let string_of_move (x1,y1) (x2,y2) =
  String.make 1 (char_of_col x1) ^
  String.make 1 (char_of_row y1) ^
  String.make 1 (char_of_col x2) ^
  String.make 1 (char_of_row y2)

(*--------------------- MOVIMIENTOS LEGALES ----------------------*)

let dentro (x,y) = x>=0 && x<8 && y>=0 && y<8

(* Genera desplazamientos según la pieza *)
let delta_pieza = function
  | Rey ->
      [ (-1,-1);(-1,0);(-1,1);(0,-1);(0,1);(1,-1);(1,0);(1,1) ]
  | Caballo ->
      [ (-2,-1);(-2,1);(-1,-2);(-1,2);
        (1,-2);(1,2);(2,-1);(2,1) ]
  | Peon -> (* peón blanco avanzando hacia arriba *)
      [ (-1,1); (1,1) ] 
  | Torre | Alfil | Dama -> [] 
let direcciones = function
  | Torre -> [(-1,0);(1,0);(0,-1);(0,1)]
  | Alfil -> [(-1,-1);(-1,1);(1,-1);(1,1)]
  | Dama  -> [(-1,0);(1,0);(0,-1);(0,1);
              (-1,-1);(-1,1);(1,-1);(1,1)]
  | _ -> []
(* Buscar pieza en una casilla *)
let pieza_en (x,y) est =
  List.find_opt (fun p -> p.pos = (x,y)) est

(* Generar todas las capturas posibles con una pieza *)
let obtener_capturas (atacante : pieza) (piezas : estado) =
  let tipo = atacante.tipo in
  let (cx, cy) = atacante.pos in
    let explorar_direccion (dx, dy) =
    let rec loop x y =
      let next_pos = (x + dx, y + dy) in
      if not (dentro next_pos) then [] (*Salio del tablero*)
      else
        match pieza_en next_pos piezas with
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
          match pieza_en dest piezas with
          | Some v -> (dest, v) :: acc
          | None -> acc
        else acc
      ) [] (delta_pieza tipo)

  | Caballo ->
      List.fold_left (fun acc (dx, dy) ->
        let dest = (cx + dx, cy + dy) in
        if dentro dest then
          match pieza_en dest piezas with
          | Some v -> (dest, v) :: acc
          | None -> acc
        else acc
      ) [] (delta_pieza tipo)

  | Peon ->
      (*El peón blanco siempre sube (row + 1)*)
      let targets = [(cx - 1, cy + 1); (cx + 1, cy + 1)] in
      List.fold_left (fun acc dest ->
        if dentro dest then
          match pieza_en dest piezas with
          | Some v -> (dest, v) :: acc
          | None -> acc
        else acc
      ) [] targets

  | Torre -> List.flatten (List.map explorar_direccion (direcciones tipo))
  | Alfil -> List.flatten (List.map explorar_direccion (direcciones tipo))
  | Dama  -> List.flatten (List.map explorar_direccion (direcciones tipo))


(*-------------------- OPERACIONES DE ESTADO ---------------------*)

let quitar id est = List.filter (fun p -> p.id <> id) est

let mover id nueva_pos est =
  List.map (fun p -> if p.id=id then {p with pos=nueva_pos} else p) est

(* Estado en forma canónica para hashing *)
let canon est =
  est
  |> List.map (fun p -> (p.tipo, p.pos))
  |> List.sort compare

module CanonSet = Set.Make(struct type t = (tipo * pos) list let compare = compare end)

(*----------------------- BÚSQUEDA DFS ---------------------------*)

let resolver inicial =
  let visitados = ref CanonSet.empty in

  let rec dfs est =
    let canonico = canon est in
    if CanonSet.mem canonico !visitados then None
    else begin
      visitados := CanonSet.add canonico !visitados;

      match est with
      | [_] -> Some []    (* éxito, queda 1 pieza *)
      | _ ->
          (* ordenar por número de capturas posibles => poda simple *)
          let piezas_ordenadas =
            List.map (fun p -> p, obtener_capturas p est) est
            |> List.sort (fun (_,c1) (_,c2) -> compare (List.length c1) (List.length c2))
          in

          let rec revisar = function
            | [] -> None
            | (p,caps)::resto ->
                let rec probar caps =
                  match caps with
                  | [] -> revisar resto
                  | ((dest, vict)) :: t ->
                      let mov = string_of_move p.pos dest in
                      let est1 = quitar vict.id est |> mover p.id dest in
                      begin match dfs est1 with
                      | None -> probar t
                      | Some camino -> Some (mov :: camino)
                      end
                in probar caps
          in revisar piezas_ordenadas
    end
  in
  dfs inicial

(*---------------- LECTURA DE ENTRADA Y MAIN ----------------------*)

let tipo_of_char = function
  | 'r' -> Rey | 'd' -> Dama | 't' -> Torre
  | 'a' -> Alfil | 'c' -> Caballo | 'p' -> Peon
  | _ -> failwith "tipo desconocido"

let parse tablero =
  let n = String.length tablero in
  let rec loop i id acc =
    if i>=n then List.rev acc
    else
      let t = tipo_of_char tablero.[i] in
      let x = col_of_char tablero.[i+1]
      and y = row_of_char tablero.[i+2] in
      let p = { id; tipo=t; pos=(x,y) } in
      loop (i+3) (id+1) (p::acc)
  in loop 0 0 []

let () =
  if Array.length Sys.argv <> 2 then
    print_endline "Uso: ./ajedrez <config>"
  else
    let est = parse Sys.argv.(1) in
    match resolver est with
    | None -> print_endline "imposible"
    | Some movs ->
        print_endline (String.concat " " movs)