
%{
 	/*Comentarios*/
 	int nums = 0;
 	int strs = 0;
%}
%option noyywrap
%%

"fin" {
	printf ("%s es FIN DE CICLO\n", yytext);
 		return 0;
}

("si"|"sino"|"mientras"|"haga") {
    printf("%s es CONDICIONAL\n", yytext);
}

"desde" {
    printf ("%s es ITERACIONI\n", yytext);
}

"hasta" {
    printf ("%s es ITERACIONF\n", yytext);
}

"devuelva" {
    printf ("%s es RETORNO\n", yytext);
}

"imprima" {
    printf ("%s es IMPRESION\n", yytext);
}

("verdadero"|"falso")	{
 		printf ("%s es BOOL\n", yytext);
 	}
= {
 		printf ("%s es ASIGNACION\n", yytext);
 	}
(>|<|>=|<=) {
 		printf ("%s es OPERADOR\n", yytext);
 	}
"igual" {
 		printf ("%s es IGUAL\n", yytext);
 	}
"diferente" {
 		printf ("%s es DIFERENTE\n", yytext);
 	}
(\.|\;|\(|\)|\{|\}) {
 		printf ("%s es SIGNO\n", yytext);
 	}
"/*" {
 		printf ("%s es COMENTARIOI\n", yytext);
 	}
"*/" {
 		printf ("%s es COMENTARIOF\n", yytext);
 	}
\\ {
 		printf ("%s es COMENTARIO\n", yytext);
 	}
("numero"|"bool"|"texto"|"car") {
 		printf ("%s es IDENTIFICADOR\n", yytext);
 	}

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? {
 		printf ("%s es NOMBRE\n", yytext);
 	}
.|\n		ECHO;

%%

int main (int argc, char* argv[]) {
	FILE *file;
	file = fopen(argv[1], "r");
	if (!file) {
      fprintf (stderr, "could not open %s\n", argv[1]);
      exit (1);
  }
  yyin = file;

yylex();
}