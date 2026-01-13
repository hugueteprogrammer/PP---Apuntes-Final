type 'a g_tree =
    Gt of 'a * 'a g_tree list

type 'a t = 'a g_tree

let leaf_tree x = Gt (x, [])

let root (Gt (x, _)) = x

let branches (Gt (_, ts)) = ts

let rec size = function
    Gt (_, []) -> 1
  | Gt (x, h::t) -> 
      size h + size (Gt (x, t))

let rec height (Gt (_, ts)) = 
  match ts with
    [] -> 1
  | _ -> 1 + List.fold_left (fun max_h t -> max max_h (height t)) 0 ts

let rec preorder (Gt (x, ts)) = 
  x :: List.flatten (List.map preorder ts)

let rec postorder (Gt (x, ts)) = 
  List.flatten (List.map postorder ts) @ [x]

let breadth t =
  let rec aux = function
    [] -> []
  | Gt (x, ts) :: rest -> x :: aux (rest @ ts)
  in 
  aux [t]

let rec leaves (Gt (x, ts)) = 
  match ts with
    [] -> [x]
  | children -> List.flatten (List.map leaves children)

let rec find_in_depth p (Gt (x, ts)) =
  if p x then x
  else 
    let rec search = function
        [] -> raise Not_found
      | t :: rest ->
        try 
          find_in_depth p t
        with Not_found ->
          search rest
    in
    search ts 

let breadth_find p t =
  let rec aux = function
      [] -> raise Not_found
    | Gt (x, ts) :: rest -> 
        if p x then x 
        else aux (rest @ ts)
  in
  aux [t]

let rec exists p (Gt (x, ts)) =
  p x || List.exists (exists p) ts

let rec for_all p (Gt (x, ts)) =
  p x && List.for_all (for_all p) ts

let rec map f (Gt (x, ts)) =
  Gt (f x, List.map (map f) ts)

let rec mirror (Gt (x, ts)) =
  Gt (x, List.rev (List.map mirror ts))

let rec from_bin t =
  if BinTree.is_empty t then raise (Failure "from_bin: empty tree")
  else
    let x = BinTree.root t in
    let l = BinTree.left_branch t in
    let r = BinTree.right_branch t in
    let children = 
      if BinTree.is_empty l && BinTree.is_empty r then []
      else if BinTree.is_empty l then [from_bin r]
      else if BinTree.is_empty r then [from_bin l]
      else [from_bin l; from_bin r]
    in
    Gt(x, children)

let rec from_st_bin t =
  if StBinTree.is_leaf t then
    Gt(StBinTree.root t, [])
  else
    Gt(StBinTree.root t, [
      from_st_bin (StBinTree.left_branch t); 
      from_st_bin (StBinTree.right_branch t)
    ])