
{
  open MyParser
  exception Lexical_error
}

rule token = parse
    [' ' '\t' '\n'] { token lexbuf }  (* ignore blanks *)
  | '#'[^'\n']*     { token lexbuf }  (* ignore comments *)
  | "true"     { TRUE }
  | "false"    { FALSE }
  | "if"       { IF }
  | "else"     { ELSE }
  | "while"    { WHILE }
  | "for"      { FOR }
  | "print"    { PRINT }
  | '('        { LPAREN }
  | ')'        { RPAREN }
  | '{'        { LCURLY }
  | '}'        { RCURLY }
  | '+'        { PLUS }
  | '-'        { MINUS }
  | '*'        { TIMES }
  | '/'        { DIVIDE }
  | '%'        { REMAINDER }
  | '!'        { NOT }
  | "||"       { OR }
  | "&&"       { AND }
  | '='        { EQ }
  | "=="       { EQEQ }
  | "!="       { NOTEQ }
  | '<'        { LT }
  | "<="       { LEQT }
  | '>'        { GT }
  | ">="       { GEQT }
  | ';'        { SEMICOLON }
  | ['0'-'9']+('.'['0'-'9']*)?(['e' 'E'](['+' '-'])?['0'-'9']+)?
               { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | ['a'-'z']['a'-'z' '_' '0'-'9']*
               { ID (Lexing.lexeme lexbuf) }
  | eof        { EOF }
  | _          { raise Lexical_error }

