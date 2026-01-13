type token =
  | TRUE
  | FALSE
  | IF
  | ELSE
  | WHILE
  | FOR
  | PRINT
  | LPAREN
  | RPAREN
  | LCURLY
  | RCURLY
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | REMAINDER
  | NOT
  | OR
  | AND
  | EQ
  | EQEQ
  | NOTEQ
  | LT
  | LEQT
  | GT
  | GEQT
  | SEMICOLON
  | EOF
  | FLOAT of (
# 16 "myParser.mly"
        float
# 34 "myParser.mli"
)
  | ID of (
# 17 "myParser.mly"
        string
# 39 "myParser.mli"
)

val s :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> SimpleC.statement list
