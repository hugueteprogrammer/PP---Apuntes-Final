let front l =
  let rec aux acu = function
      [] -> raise (Failure "front") (*Error si la lista está vacía*)
    | [_] -> List.rev acu (*Si queda un solo elemento, lo ignoramos y devolvemos el acumulador invertido*)
    | h :: t -> aux (h :: acu) t (*Si hay mas de uno, guardamos en el acumulador*)
  in
  aux [] l

let compress l =
  let rec aux acu = function
      [] -> raise (Failure "compress") 
    | [x] -> List.rev (x :: acu) (*Ultimo elemento, lo agregamos y terminamos*)
    | h1 :: (h2 :: _ as t) -> 
        if h1 = h2 then 
          aux acu t (*Son iguales, ignoramos h1*)
        else 
          aux (h1 :: acu) t (*Agregamos h1 y seguimos*)
  in 
  aux [] l

let fold_right f l a =
  let rec aux acu = function
      [] -> acu
    | h :: t -> aux (f h acu) t
  in
  aux a (List.rev l) 