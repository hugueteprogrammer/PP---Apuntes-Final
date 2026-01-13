open BinTree
open Queue

exception Done

let breadth tree = 
  let q = new Queue.queue in
  let result = ref [] in 

  if not (BinTree.is_empty tree) then q#push tree;

  try
    while true do
    match q#pop with
      | None -> raise Done
      | Some node ->
          let value = BinTree.root node in
          result := value :: !result;

          let left = BinTree.left_branch node in
          if not (BinTree.is_empty left) then q#push left;

          let right = BinTree.right_branch node in
          if not (BinTree.is_empty right) then q#push right;
    done;
    []
  with 
  | Done -> List.rev !result