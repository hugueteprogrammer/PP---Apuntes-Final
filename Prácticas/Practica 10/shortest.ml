(*tipo de datos para las 4 direcciones*)
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
  let (nf, nc) = moverse pos dir in
  (*Verifica si el movimiento es valido*)
  if nf >= 1 && nf <= m && nc >= 1 && nc <= n then ((nf, nc), dir)
  else
    (*Chocó: se da la vuelta*)
    (moverse pos (opposite_dir dir) , opposite_dir dir)

let robot_mov_all m n robots =
  List.map (robot_mov m n) robots

let colision (pf, pc) robots = 
  List.exists (fun ((rf, rc), _) -> pf = rf && pc = rc) robots

(*Estado del juego*)
type state = {
  pos : pos;
  robots : robot_pos list;
  path : move list;
  visited : pos list;
}

let shortest m n initial_robots = 
  (*Estado inicial = (1,1)*)
  let initial_state = {
    pos = (1, 1);
    robots = initial_robots;
    path = [];
    visited = [(1, 1)]
  } 
  in
  (*Funcion recursiva para implementar la busqueda*)
  let rec solucion cola = 
    match cola with
      [] -> raise Not_found (*Llegamos al destino*)
    | current :: rest -> (*Sacamos el primer estado*)
      let (f, c) = current.pos in 
        if f = m && c = n then 
          List.rev current.path (*Devolvemos el camino*)
        else
          (*SIMULACIÓN*)
          let next_robots = robot_mov_all m n current.robots in
          let moves = [North; South; East; West] in 

          let next = 
            List.fold_left (fun acu dir -> 
              let (nf, nc) = moverse (f, c) dir in
              
            (*VALIDACIONES*)
            let dentro = nf >= 1 && nf <= m && nc >= 1 && nc <= n in
            let not_visited = not (List.mem (nf, nc) current.visited) in
            let safe = not (colision  (nf, nc) next_robots) in

            if dentro && not_visited && safe then
              {
                (*Si es valido creamos un nuevo estado y lo añadimos al acu*)
                pos = (nf, nc);
                robots = next_robots;
                path = dir :: current.path;
                visited = (nf, nc) :: current.visited
              } :: acu
            else
              acu
            )[] moves 
          in
          solucion (rest @ List.rev next)
  in   
  solucion [initial_state]