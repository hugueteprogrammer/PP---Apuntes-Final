(*Ejercicio 3*)
let rec str3_of_int n =
  if n < 3 then string_of_int n
  else str3_of_int (n / 3) ^ string_of_int (n mod 3)

(*Ejercicio 4*)

(*Ejercicio 5*)
let rec strg_of_int b n =
  if n < b then string_of_int n
  else strg_of_int b (n / b) ^ string_of_int (n mod b)