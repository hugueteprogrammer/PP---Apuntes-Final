
open Parsing
open Lexing

open MyParser
open MyLexer
open SimpleC

let open_in_opt name =
  try Some (open_in name) with
    _ -> None

let main () =
  if Array.length Sys.argv <> 2
  then print_endline ("syntax: " ^ Sys.argv.(0) ^ " <file>")
  else
    let file = Sys.argv.(1) in
    match open_in_opt file with
      None ->
        print_endline ("cannot open file " ^ file)
    | Some chn ->
        try
          let p = s token (Lexing.from_channel chn) in
          let _ = exec empty_context p in ()
        with
          Lexical_error ->
            print_endline "lexical error"
        | Parse_error ->
            print_endline "syntax error"
        | No_binding s ->
            print_endline ("no binding for " ^ s)
        | Runtime_error s ->
            print_endline s

let _ =
  main ()

