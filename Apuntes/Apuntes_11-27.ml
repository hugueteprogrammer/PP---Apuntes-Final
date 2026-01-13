(*Primer día de la parte imperativa*)

output_char;;
(*- : out_channel -> char -> unit = <fun>*)
stdout;;
(*- : out_channel = <abstr>*)
output_char stdout 'X';;
(*X- : unit = ()*) (*Sale una X*)

let print_char c = output_char stdout c;; (*print_char ya esta implementada*)
(*val print_char : char -> unit = <fun>*)
print_char 'X';;
(*X- : unit = ()*)

let _ = print_char 'A' in let _ = print_char 'B' in print_char 'C';;
(*ABC- : unit = ()*) (*Se escribe en el orden dado*)
print_char 'A'; print_char 'B'; print_char 'C';;    (*El ; equivale a let in*)                  
(*ABC- : unit = ()*)
print_char 'A'; print_char 'B'; print_char 'C'; 2+3;;
(*ABC- : int = 5*)

"ab" ^ "cd"; 2+3;; (*La concatenacion no es de tipo unit, con lo cual dará un warning*)
(*Warning 10 [non-unit-statement]: this expression should have type unit.
- : int = 5*)

ignore("ab" ^ "cd"); 2+3;; (*Esta funcion sirve para ignorar ciertos warnings y ya esta definida*)
(*- : int = 5*)

"Hola".[0];;
(*- : char = 'H'*)
"Hola".[3];;
(*- : char = 'a'*)
"Hola".[5];;
(*Exception: Invalid_argument "index out of bounds".*)

let output_string canal s =
  let n = String.length s in 
  let rec loop i =
    if i >= n then ()
    else (output_char canal s.[i]; loop(i+1)) (*El ; separaría el if then else del loop*)
  in loop 0;;
(*val output_string : out_channel -> string -> unit = <fun>*)

output_string stdout "Hola";;
(*Hola- : unit = ()*)
let print_string s = output_string stdout s;; (*print_string ya esta definida*)
(*val print_string : string -> unit = <fun>*) 
print_string "Hola";;
(*Hola- : unit = ()*)
let print_endline s = (*ya esta definida*)
  print_string (s^"\n");;
(*val print_endline : string -> unit = <fun>
# print_endline "Hola";;
Hola
- : unit = ()
*)
let print_newline () = (*ya esta definida*)
  print_endline "";;
(*val print_newline : unit -> unit = <fun>*)

input_char;;
(*- : in_channel -> char = <fun>*)

input_char stdin;; (*Esperará hasta que se pulse intro*)
Z
(*- : char = 'Z'*)
(*
Un ejemplo cuando se quiere combinar tipos
# let x = 4;;
val x : int = 4
# input_char stdin;;
Zx
- : char = 'Z'
#   ;;
- : int = 4
*)

input_line;;
(*- : in_channel -> string = <fun>*)
let read_line () = input_line stdin;; (*ya esta definida*)
(*val read_line : unit -> string = <fun>*)

(*EJEMPLO
# read_line();;
Hola
- : string = "Hola"
*)

open_out;;
(*- : string -> out_channel = <fun>*)
let s = open_out "prueba";;
(*val s : out_channel = <abstr>*)

output_char;;
(*- : out_channel -> char -> unit = <fun>*)

output_char s 'X';;(*No escribe en el disco, sino en un buffer y eso provoca que solo se escribirá si se lo pedimos expresamente*)
(*- : unit = ()*)
output_string s "ABC";; (*No escribe en el disco, sino en un buffer y eso provoca que solo se escribirá si se lo pedimos expresamente*)
(*- : unit = ()*)

close_out;; (*Una manera de solucionar el problema anterior es cerrar el fichero*)
(*- : out_channel -> unit = <fun>*)
close_out s;;
(*- : unit = ()*)

flush;; (*Otra posibilidad es utilizar el comando flush*)
(*- : out_channel -> unit = <fun>*)

output_char s 'X';;  (*No se escribe*)      
(*- : unit = ()*)
output_string s "ABC";; (*No se escribe*)   
(*- : unit = ()*)
flush s;; (*Escribe lo anterior*)
(*- : unit = ()*)
output_string s "DEF";; (*No se escribe*)   
(*- : unit = ()*)
close_out s;; (*Escribe lo anterior*)
(*- : unit = ()*)

(*NUNCA hacer close_out stdout*)

