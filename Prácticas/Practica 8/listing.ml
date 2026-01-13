let from0to n =
  if n<0 then raise (Failure "lmax")
  else 
    (*Funcion auxiliar tail-recursive*)
    let rec aux i acu =
      if i < 0 then acu
      else 
        (*Agrega i al frente y decrementa. La lista queda ordenada al ir de n a 0*)
        aux (i-1) (i::acu)
    in
    aux n []

let to0from n =
   if n<0 then raise (Failure "lmax")
  else 
    (*i empieza en 0 y sube. Al agregar al frente, el 0 queda al final y n al principio*)
    let rec aux i acu =
      if i > n then acu
      else 
        aux (i+1) (i::acu)
    in
    aux 0 []

let pair x list =
  List.map (fun y -> (x,y)) list

let remove x list =
  (*Recorre la lista guardando los elementos previos en 'acu' (invertidos)*)
  let rec aux acu = function
      [] -> acu
    | h::t ->
        if h = x then 
          (*Si encuentra x, necesitamos pegar lo que está en el acu
            con el resto de la lista*)
          let rec append invertir resto =
          match invertir with
          | [] -> resto
          | h :: t -> append t (h :: resto)
        in
        append acu t
        else 
          aux (h::acu) t
  in
  aux [] list

let remove_all x list =
  List.filter (fun y -> y<>x) list

let remove_duplicates list =
  let rec aux acu = function
      [] -> List.rev acu (*Al final, invertimos para restaurar el orden original*)
    | h::t ->
      (*List.mem chequea si h ya existe en el acumulador*)
        if List.mem h acu then 
          aux acu t (*Ya existe, lo ignoramos*)
        else
          aux (h :: acu) t (*no existe, lo añadimos*)
  in 
  aux [] list

let ldif l1 l2 = 
  List.filter (fun y -> not (List.mem y l2)) l1