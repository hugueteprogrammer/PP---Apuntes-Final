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
# 34 "myParser.ml"
)
  | ID of (
# 17 "myParser.mly"
        string
# 39 "myParser.ml"
)

open Parsing
let _ = parse_error;;
# 3 "myParser.mly"
  open SimpleC
# 46 "myParser.ml"
let yytransl_const = [|
  257 (* TRUE *);
  258 (* FALSE *);
  259 (* IF *);
  260 (* ELSE *);
  261 (* WHILE *);
  262 (* FOR *);
  263 (* PRINT *);
  264 (* LPAREN *);
  265 (* RPAREN *);
  266 (* LCURLY *);
  267 (* RCURLY *);
  268 (* PLUS *);
  269 (* MINUS *);
  270 (* TIMES *);
  271 (* DIVIDE *);
  272 (* REMAINDER *);
  273 (* NOT *);
  274 (* OR *);
  275 (* AND *);
  276 (* EQ *);
  277 (* EQEQ *);
  278 (* NOTEQ *);
  279 (* LT *);
  280 (* LEQT *);
  281 (* GT *);
  282 (* GEQT *);
  283 (* SEMICOLON *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  284 (* FLOAT *);
  285 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\003\000\003\000\
\003\000\006\000\006\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\005\000\005\000\005\000\005\000\
\005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
\000\000"

let yylen = "\002\000\
\002\000\000\000\003\000\003\000\005\000\007\000\005\000\009\000\
\002\000\001\000\003\000\001\000\001\000\003\000\003\000\003\000\
\003\000\003\000\002\000\003\000\001\000\001\000\002\000\003\000\
\003\000\003\000\003\000\003\000\003\000\003\000\003\000\003\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\033\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\012\000\
\013\000\000\000\000\000\001\000\000\000\021\000\022\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\019\000\000\000\
\000\000\000\000\000\000\000\000\000\000\003\000\000\000\000\000\
\023\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000\000\000\000\000\016\000\
\017\000\018\000\032\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\010\000\000\000\000\000\025\000\007\000\000\000\
\000\000\000\000\000\000\011\000\006\000\000\000\000\000\008\000"

let yydgoto = "\002\000\
\008\000\009\000\067\000\026\000\027\000\068\000"

let yysindex = "\002\000\
\061\255\000\000\000\255\006\255\011\255\075\255\242\254\000\000\
\009\000\244\254\016\255\016\255\061\255\075\255\075\255\000\000\
\000\000\184\255\075\255\000\000\061\255\000\000\000\000\016\255\
\016\255\157\255\093\255\166\255\003\255\179\255\000\000\075\255\
\075\255\075\255\075\255\075\255\184\255\000\000\142\255\168\255\
\000\000\075\255\075\255\075\255\075\255\075\255\075\255\052\255\
\016\255\016\255\052\255\016\255\000\000\145\255\145\255\000\000\
\000\000\000\000\000\000\184\255\184\255\184\255\184\255\184\255\
\184\255\061\255\000\000\044\255\037\255\000\000\000\000\019\255\
\059\255\052\255\061\255\000\000\000\000\063\255\052\255\000\000"

let yyrindex = "\000\000\
\073\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\001\255\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\007\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\073\255\097\255\000\000\
\000\000\000\000\000\000\060\255\108\255\119\255\121\255\123\255\
\125\255\064\255\000\000\254\254\062\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\237\255\255\255\007\000\011\000\209\255"

let yytablesize = 268
let yytable = "\010\000\
\002\000\038\000\001\000\071\000\009\000\019\000\005\000\011\000\
\020\000\009\000\004\000\029\000\018\000\012\000\021\000\004\000\
\022\000\023\000\013\000\010\000\030\000\031\000\028\000\024\000\
\005\000\037\000\077\000\009\000\015\000\052\000\039\000\080\000\
\025\000\004\000\040\000\041\000\049\000\050\000\054\000\055\000\
\056\000\057\000\058\000\016\000\017\000\075\000\073\000\074\000\
\060\000\061\000\062\000\063\000\064\000\065\000\003\000\050\000\
\004\000\005\000\006\000\069\000\070\000\066\000\072\000\003\000\
\010\000\004\000\005\000\006\000\026\000\076\000\024\000\079\000\
\002\000\078\000\002\000\000\000\014\000\026\000\026\000\024\000\
\007\000\014\000\014\000\000\000\014\000\014\000\026\000\015\000\
\024\000\007\000\014\000\014\000\000\000\014\000\014\000\014\000\
\014\000\014\000\014\000\014\000\015\000\048\000\016\000\017\000\
\000\000\015\000\000\000\000\000\015\000\015\000\049\000\050\000\
\000\000\000\000\015\000\015\000\027\000\015\000\015\000\015\000\
\015\000\015\000\015\000\015\000\000\000\027\000\027\000\028\000\
\000\000\029\000\000\000\030\000\000\000\031\000\027\000\000\000\
\028\000\028\000\029\000\029\000\030\000\030\000\031\000\031\000\
\000\000\028\000\000\000\029\000\000\000\030\000\053\000\031\000\
\000\000\032\000\033\000\034\000\035\000\036\000\034\000\035\000\
\036\000\000\000\042\000\043\000\044\000\045\000\046\000\047\000\
\032\000\033\000\034\000\035\000\036\000\000\000\051\000\000\000\
\059\000\042\000\043\000\044\000\045\000\046\000\047\000\049\000\
\050\000\049\000\050\000\053\000\000\000\000\000\032\000\033\000\
\034\000\035\000\036\000\032\000\033\000\034\000\035\000\036\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\002\000"

let yycheck = "\001\000\
\000\000\021\000\001\000\051\000\004\001\020\001\009\001\008\001\
\000\000\009\001\004\001\013\000\006\000\008\001\027\001\009\001\
\001\001\002\001\008\001\021\000\014\000\015\000\012\000\008\001\
\027\001\019\000\074\000\027\001\013\001\027\001\024\000\079\000\
\017\001\027\001\024\000\025\000\018\001\019\001\032\000\033\000\
\034\000\035\000\036\000\028\001\029\001\027\001\066\000\004\001\
\042\000\043\000\044\000\045\000\046\000\047\000\003\001\019\001\
\005\001\006\001\007\001\049\000\050\000\010\001\052\000\003\001\
\066\000\005\001\006\001\007\001\009\001\011\001\009\001\009\001\
\000\000\075\000\011\001\255\255\004\001\018\001\019\001\018\001\
\029\001\009\001\008\001\255\255\012\001\013\001\027\001\013\001\
\027\001\029\001\018\001\019\001\255\255\021\001\022\001\023\001\
\024\001\025\001\026\001\027\001\004\001\009\001\028\001\029\001\
\255\255\009\001\255\255\255\255\012\001\013\001\018\001\019\001\
\255\255\255\255\018\001\019\001\009\001\021\001\022\001\023\001\
\024\001\025\001\026\001\027\001\255\255\018\001\019\001\009\001\
\255\255\009\001\255\255\009\001\255\255\009\001\027\001\255\255\
\018\001\019\001\018\001\019\001\018\001\019\001\018\001\019\001\
\255\255\027\001\255\255\027\001\255\255\027\001\009\001\027\001\
\255\255\012\001\013\001\014\001\015\001\016\001\014\001\015\001\
\016\001\255\255\021\001\022\001\023\001\024\001\025\001\026\001\
\012\001\013\001\014\001\015\001\016\001\255\255\009\001\255\255\
\009\001\021\001\022\001\023\001\024\001\025\001\026\001\018\001\
\019\001\018\001\019\001\009\001\255\255\255\255\012\001\013\001\
\014\001\015\001\016\001\012\001\013\001\014\001\015\001\016\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\011\001"

let yynames_const = "\
  TRUE\000\
  FALSE\000\
  IF\000\
  ELSE\000\
  WHILE\000\
  FOR\000\
  PRINT\000\
  LPAREN\000\
  RPAREN\000\
  LCURLY\000\
  RCURLY\000\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIVIDE\000\
  REMAINDER\000\
  NOT\000\
  OR\000\
  AND\000\
  EQ\000\
  EQEQ\000\
  NOTEQ\000\
  LT\000\
  LEQT\000\
  GT\000\
  GEQT\000\
  SEMICOLON\000\
  EOF\000\
  "

let yynames_block = "\
  FLOAT\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'statement_list) in
    Obj.repr(
# 67 "myParser.mly"
      ( _1 )
# 255 "myParser.ml"
               : SimpleC.statement list))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "myParser.mly"
      ( [] )
# 261 "myParser.ml"
               : 'statement_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'statement) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'statement_list) in
    Obj.repr(
# 74 "myParser.mly"
      ( _1 :: _3 )
# 269 "myParser.ml"
               : 'statement_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 79 "myParser.mly"
      ( Bind (_1, _3) )
# 277 "myParser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'boolean) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 82 "myParser.mly"
      ( If (_3, _5, []) )
# 285 "myParser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'boolean) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'body) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 85 "myParser.mly"
      ( If (_3, _5, _7) )
# 294 "myParser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'boolean) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 87 "myParser.mly"
      ( While (_3, _5) )
# 302 "myParser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'statement) in
    let _5 = (Parsing.peek_val __caml_parser_env 4 : 'boolean) in
    let _7 = (Parsing.peek_val __caml_parser_env 2 : 'statement) in
    let _9 = (Parsing.peek_val __caml_parser_env 0 : 'body) in
    Obj.repr(
# 89 "myParser.mly"
      ( For (_3, _5, _7, _9) )
# 312 "myParser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 91 "myParser.mly"
      ( Print _2 )
# 319 "myParser.ml"
               : 'statement))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'statement) in
    Obj.repr(
# 95 "myParser.mly"
      ( [_1] )
# 326 "myParser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'statement_list) in
    Obj.repr(
# 97 "myParser.mly"
      ( _2 )
# 333 "myParser.ml"
               : 'body))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 101 "myParser.mly"
      ( C _1 )
# 340 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 103 "myParser.mly"
      ( Var _1 )
# 347 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 105 "myParser.mly"
      ( Arith_bi_op (Sum, _1, _3) )
# 355 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 107 "myParser.mly"
      ( Arith_bi_op (Sub, _1, _3) )
# 363 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 109 "myParser.mly"
      ( Arith_bi_op (Prod, _1, _3) )
# 371 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 111 "myParser.mly"
      ( Arith_bi_op (Div, _1, _3) )
# 379 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 113 "myParser.mly"
      ( Arith_bi_op (Mod, _1, _3) )
# 387 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 116 "myParser.mly"
      ( Arith_op (Opp, _2) )
# 394 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'arith) in
    Obj.repr(
# 118 "myParser.mly"
      ( _2 )
# 401 "myParser.ml"
               : 'arith))
; (fun __caml_parser_env ->
    Obj.repr(
# 123 "myParser.mly"
      ( B true )
# 407 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    Obj.repr(
# 125 "myParser.mly"
      ( B false )
# 413 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'boolean) in
    Obj.repr(
# 128 "myParser.mly"
      ( Boolean_op (Not, _2) )
# 420 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolean) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'boolean) in
    Obj.repr(
# 130 "myParser.mly"
      ( Boolean_bi_op (Or, _1, _3) )
# 428 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolean) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'boolean) in
    Obj.repr(
# 132 "myParser.mly"
      ( Boolean_bi_op (And, _1, _3) )
# 436 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 134 "myParser.mly"
      ( Comp (Equal, _1, _3))
# 444 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 136 "myParser.mly"
      ( Comp (Not_equal, _1, _3))
# 452 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 138 "myParser.mly"
      ( Comp (Less, _1, _3))
# 460 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 140 "myParser.mly"
      ( Comp (Less_equal, _1, _3))
# 468 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 142 "myParser.mly"
      ( Comp (Greater, _1, _3))
# 476 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith) in
    Obj.repr(
# 144 "myParser.mly"
      ( Comp (Greater_equal, _1, _3))
# 484 "myParser.ml"
               : 'boolean))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'boolean) in
    Obj.repr(
# 146 "myParser.mly"
      ( _2 )
# 491 "myParser.ml"
               : 'boolean))
(* Entry s *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let s (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : SimpleC.statement list)
