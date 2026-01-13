let rec output_string_list c = function
    [] -> ()
  | h::t ->
  output_string c (h^"\n"); output_string_list c t;;
(*val output_string_list : out_channel -> string list -> unit = <fun>*)
let s = open_out "prueba";;
(*val s : out_channel = <abstr>*)
output_string_list s ["a";"ABC";"ABCDE"];;
(*- : unit = ()*)
close_out s;; (*Se escribe*)
(*- : unit = ()*)

let rec iter p = function (*Ya existe con List.iter*)
    [] -> ()
  | h::t -> p h; iter p t

let rec output_string_list c l = 
  List.iter (function s -> output_string c (s^"\n")) l;;

let c = open_in "kkk";;
(*Exception: Sys_error "kkk: No such file or directory".*)
let c = open_in "prueba";;
(*val c : in_channel = <abstr>*)
input_char c;;
(*- : char = 'a'*)
input_char c;;
(*- : char = '\n'*)
input_char c;;
(*- : char = 'A'*)
input_char c;;
(*- : char = 'B'*)
input_char c;;
(*- : char = 'C'*)
input_char c;;
(*- : char = '\n'*)
input_char c;;
(*- : char = 'A'*)
input_char c;;
(*- : char = 'B'*)
input_char c;;
(*- : char = 'C'*)
input_char c;;
(*- : char = 'D'*)
input_char c;;
(*- : char = 'E'*)
input_char c;;
(*- : char = '\n'*)
input_char c;;
(*Exception: End_of_file.*)
(*input_char saca solo un caracter e input_line toda la linea hasta encontrar un \n*)

stdin;;
(*- : in_channel = <abstr>*)
stdout;;
(*- : out_channel = <abstr>*)
stderr;;
(*- : out_channel = <abstr>*)
seek_in;;
(*- : in_channel -> int -> unit = <fun>*)
pos_in;;
(*- : in_channel -> int = <fun>*)

ref;;
(*- : 'a -> 'a ref = <fun>*)
ref 8;;
(*- : int ref = {contents = 8}*)
let i = ref 8;;
i + 3;; (*i es de tipo ref*)
(*Error: The value i has type int ref but an expression was expected of type int*)

(!);;
(*- : 'a ref -> 'a = <fun>*)
!i;;
(*- : int = 8*)
!i + 3;;
(*- : int = 11*)

(:=);;
(*- : 'a ref -> 'a -> unit = <fun>*)
i := 9;;
(*- : unit = ()*)
i;;
(*- : int ref = {contents = 9}*)
!i;;
(*- : int = 9*)

for i = 0+1 to 4+1 do print_endline (string_of_int i) done;;
(*
1
2
3
4
5
- : unit = ()*)

let fact n =
  let f = ref 1 in
  for i = 1 to n do
    f := !f * i
  done;
  !f;;
fact 5;;
(*- : int = 120*)
for i = 1 to 20 do print_endline (string_of_int (fact i)) done;;
(*
1
2
6
24
120
720
5040
40320
362880
3628800
39916800
479001600
6227020800
87178291200
1307674368000
20922789888000
355687428096000
6402373705728000
121645100408832000
2432902008176640000
- : unit = ()*)