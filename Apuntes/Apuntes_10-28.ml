let rec fact = function
    0 -> 1
  | n -> n * fact(n-1);;

(*
fact 4 ->
  4 * fact(3)->
  4 * 3 * fact(2) ->
  4 * 3* 2 * fact(1) ->
  4 * 3* 2* 1 * fact(0) ->
  4 * 3* 2* 1 * 1 ->

  24
*)

let fact n =
  let rec aux f = function
      0 -> f
    | i -> aux (f*i) (i-1)
  in 
  aux 1 n