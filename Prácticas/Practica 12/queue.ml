class ['a] queue = object (self)
  val mutable front = []
  val mutable back = []

  method push (e : 'a) =
    back <- e::back

  method peek =
    match front, back with
      h::t, _ -> Some h
    | [], [] -> None
    | [], _ ->
        front <- List.rev back;
        back <- [];
        self#peek

  method pop =
    match front, back with
      h::t, _ -> front <- t; Some h
    | [], [] -> None
    | [], _ ->
        front <- List.rev back;
        back <- [];
        self#pop
end

class ['a] queue' = object (self)
  inherit ['a] queue (*Hereda la clase 'queue'*)
  
  method push' x =
    front <- x :: front

  method peek' =
    match back with
    | h :: _ -> h (*Si hay elementos en la salida, devolvemos la cabeza*)
    | [] -> 
      (*La salida está vacía*)
      match List.rev front with (*Invertimos la lista 'front' para corregir el orden*)
      | h :: t -> 
        front <- []; (*Vaciamos la entrada porque ya movimos todo*)
        back <- h :: t; (*guardamos la lista invertida en 'back'*)
        h (*Devolvemos la cabeza*)
      | [] -> raise (Failure "queue") 
    
  method pop' =
    match back with
    | h :: t -> 
      back <- t; (*Si hay elementos en 'back', quitamos la cabeza y actualizamos*)
      h (*Devolvemos lo quitado*)
    | [] ->
      match List.rev front with
      | h :: t -> 
        front <- []; (*Vaciamos la entrada*)
        back <- t; (*Guardamos solo 't' porque 'h' se va a devolver*)
        h (*Devolvemos 'h'*)
      | [] -> raise (Failure "queue")
  end