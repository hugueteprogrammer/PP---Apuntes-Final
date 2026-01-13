type move =
  North | South | West | East

exception Not_found

type pos = int * int
type robot_pos = pos * move

let opposite_dir = function
  | North -> South
  | South -> North
  | East -> West
  | West -> East

let moverse (f, c) = function
  | North -> (f-1, c)
  | South -> (f+1, c)
  | East -> (f, c+1)
  | West -> (f, c-1)

(*Lógica de movimiento de un solo robot*)
let robot_mov m n ((pos, dir):robot_pos):robot_pos =
  let next_pos = moverse pos dir in
  let (nf, nc) = next_pos in 
  (*Verifica si el movimiento es valido*)
  if nf >= 1 && nf <= m && nc >= 1 && nc <= n then 
    (next_pos, dir)
  else
    (*Si choca, rebota*)
     let bounce = moverse pos (opposite_dir dir) in
     (bounce, opposite_dir dir)

let robot_mov_all m n robots =
  List.map (robot_mov m n) robots

let colision (pf, pc) robots = 
  List.exists (fun ((rf, rc), _) -> pf = rf && pc = rc) robots

let tour m n initial_robots =
  (*Funcion recursiva principal*)
  let rec solucion (curr_f, curr_c) current_robots path_acu visited = 
    (*Se llega a la esquina inferior derecha*)
    if curr_f = m && curr_c = n then 
      List.rev path_acu

    else
      (*SIMULACION*)
      let next_robots = robot_mov_all m n current_robots in
      let moves = [North; South; East; West] in 

      let rec try_moves = function
        [] -> raise Not_found
      | dir :: rest ->
        let (nf, nc) = moverse (curr_f, curr_c) dir in
          (*VALIDACIONES*)
          let dentro = nf >= 1 && nf <= m && nc >= 1 && nc <= n in
          let not_visited = not (List.mem (nf, nc) visited) in
          let safe = not (colision  (nf, nc) next_robots)in

          if dentro && not_visited && safe then
            try 
              solucion (nf, nc) next_robots (dir::path_acu) ((nf, nc) :: visited)
            with Not_found ->
              try_moves rest
          else
            (*Si el movimiento no es válido, probamos el siguiente*)
            try_moves rest
      in
      try_moves moves
  in 
  (*Inicia en el (1,1)*)
  solucion (1,1) initial_robots [] [(1,1)]
