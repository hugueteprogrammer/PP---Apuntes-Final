
all:
	ocamlc -c simpleC.ml
	ocamlyacc myParser.mly
	ocamlc -c myParser.mli myParser.ml
	ocamllex myLexer.mll
	ocamlc -c myLexer.ml
	ocamlc -o run simpleC.cmo myParser.cmo myLexer.cmo main.ml

clean:
	rm -f myParser.ml myParser.mli myLexer.ml *.cm*

