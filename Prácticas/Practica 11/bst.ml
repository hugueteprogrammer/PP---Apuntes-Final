let rec check_bounds ord min_val max_val t =
  if BinTree.is_empty t then true
  else
    let x = BinTree.root t in
    let l = BinTree.left_branch t in
    let r = BinTree.right_branch t in
    
    (* Validar rangos *)
    let lower_ok = match min_val with
      | None -> true
      | Some min -> ord min x
    in
    let upper_ok = match max_val with
      | None -> true
      | Some max -> ord x max
    in
    
    (* Recursión: actualizamos el techo al ir a la izq, y el suelo al ir a la der *)
    lower_ok && upper_ok &&
    check_bounds ord min_val (Some x) l &&
    check_bounds ord (Some x) max_val r

let is_bst ord t =
  check_bounds ord None None t

let rec mem ord x t =
  if BinTree.is_empty t then false
  else
    let v = BinTree.root t in
    if ord x v then mem ord x (BinTree.left_branch t)       (* x < v: Izquierda *)
    else if ord v x then mem ord x (BinTree.right_branch t) (* v < x: Derecha *)
    else true                                (* x = v: Encontrado *)

let rec add ord x t =
  if BinTree.is_empty t then 
    BinTree.comb x BinTree.empty BinTree.empty
  else
    let v = BinTree.root t in
    let l = BinTree.left_branch t in
    let r = BinTree.right_branch t in
    
    if ord x v then 
      BinTree.comb v (add ord x l) r       (* Reconstruimos rama izquierda *)
    else if ord v x then 
      BinTree.comb v l (add ord x r)       (* Reconstruimos rama derecha *)
    else 
      t                            (* Ya existe, devolvemos el original *)
      
let rec max_element t =
  if BinTree.is_empty t then failwith "max_element: empty tree"
  else
    let r = BinTree.right_branch t in
    if BinTree.is_empty r then BinTree.root t
    else max_element r

let rec remove ord x t =
  if BinTree.is_empty t then BinTree.empty
  else
    let v = BinTree.root t in
    let l = BinTree.left_branch t in
    let r = BinTree.right_branch t in
    
    if ord x v then 
      BinTree.comb v (remove ord x l) r    (* Buscar en izquierda y reconstruir *)
    else if ord v x then 
      BinTree.comb v l (remove ord x r)    (* Buscar en derecha y reconstruir *)
    else 
      (* Caso: encontramos el elemento (x == v) *)
      if BinTree.is_empty l then r         (* Si no hay izq, sube el derecho *)
      else if BinTree.is_empty r then l    (* Si no hay der, sube el izquierdo *)
      else
        (* Tiene dos hijos: reemplazamos raíz por el predecesor (max de izq) *)
        let pred = max_element l in
        (* Construimos: Nueva raíz (pred), Izq sin el pred antiguo, Der igual *)
        BinTree.comb pred (remove ord pred l) r