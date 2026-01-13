let rec fact n =
  match n with
    n when n<0 -> raise(Invalid_argument "fact")
  | 0 -> 1
  | _ -> n * fact(n-1)