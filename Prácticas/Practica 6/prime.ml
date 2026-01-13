(*Ejercicio 3*)
let is_prime n =
  let rec check_from i =
    i >= n || (n mod i <> 0 && check_from (i+1))
  in n > 1 && check_from 2

let is_prime2 n =
  let rec check_from i =
    i * i > n || (n mod i <> 0 && check_from (i+2))
  in 
  n = 2 || (n > 2 && n mod 2 <> 0 && check_from 3)

(*Medición de tiempos*)
  let crono f x =
  let t = Sys.time () in
  let _ = f x in
  Sys.time () -. t

let () =
  let n = 1_000_000_007 in
  let t1 = crono is_prime n in
  let t2 = crono is_prime2 n in
  Printf.printf "is_prime:  %f s\nisprime2: %f s\n" t1 t2

  (*is_prime: 9.316789 s
    isprime2: 0.000184 s *)

(*Ejercicio 4*)
  let goldbach n =
  if n <= 2 || n mod 2 <> 0 then
    invalid_arg "goldbach: n debe ser par y mayor que 2"
  else
    let rec buscar p =
      if is_prime2 p && is_prime2 (n - p) then
        (p, n - p)
      else
        buscar (p + 1)
    in
    buscar 2