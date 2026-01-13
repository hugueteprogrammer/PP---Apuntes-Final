let i_prod list =
  List.fold_left ( * ) 1 list

let f_prod list =
  List.fold_left ( *. ) 1.0 list

let lmin = function
    [] -> raise (Failure "lmin")
  | h::t -> List.fold_left min h t (*Usa el primer elemento 'h' como el mínimo inicial*)

let lmin_lmax = function
    [] -> raise (Failure "lmin_lmax")
    (*El acumulador es una tupla (min_actual, max_actual).
      En cada paso, actualiza ambos valores comparandolos con x*)
  | h::t -> List.fold_left (fun (current_min, current_max) x -> (min current_min x, max current_max x)) (h,h) t

let last = function
    [] -> raise (Failure "last")
    (*La función lambda ignora el acumulador anterior (_) y devuelve el elemento actual (x).
      Al final del pliegue, queda el último elemento*)
  | h::t -> List.fold_left (fun _ x -> x) h t

let rev list = 
  (*Toma cada elemento 'x' y lo pone al frente del acumulador 'acu' (cons).
     Esto invierte el orden natural. El acumulador inicia vacio []*)
  List.fold_left (fun acu x -> x::acu) [] list

let rev_append l1 l2 = 
  (*Inicia el acumulador con l2 y le va pegando los elementos de l1 invertidos*)
  List.fold_left (fun acu x -> x::acu) l2 l1

let rev_map f l =
  List.fold_left (fun acu x -> (f x)::acu) [] l

let concat sl =
  List.fold_left ( ^ ) "" sl