/* Nombre del Equipo: MERAKI

Como ejecutar el programa: 
	1. Primero se debe ejecutar el comando flex con el nombre de este archivo.
		Ej: flex merakiTokens.flex
	2. Luego, se debe compilar el lex.yy.c generado.
		Ej: gcc lex.yy.c -o merakiTokens.exe
	3. Finalmente, correr el ejecutable generado en el paso anterior y mandar el archivo con el codigo
	   fuente de parametro.
		Ej: ./merakiTokens.exe ejemploMeraki.txt

Basado en el ejemplo del laboratorio.		
*/


%{
 	/*Comentarios*/
 	int nums = 0;
 	int strs = 0;
%}
%option noyywrap
NUM 	[0-9]
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

 (\+|\-|\*|\/) {
	 printf ("%s es OPERADOR MATEMATICO\n", yytext);
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

\/\*(.|[\n])*\*\/ {
 		printf ("%s es COMENTARIO\n", yytext);
 	}

(\/\/(.*\n))* {
 		printf ("%s es COMENTARIO\n", yytext);
 	}

("numero"|"bool"|"texto"|"car") {
 		printf ("%s es IDENTIFICADOR\n", yytext);
 	}

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? {
 		printf ("%s es NOMBRE VARIABLE\n", yytext);
 	}

\"(.*)\" {
 		printf ("%s es TEXTO\n", yytext);
 	}

-?[0-9]+ {
 		printf ("%s es NUMERO\n", yytext);
 	}

'[^']' {
 		printf ("%s es CARACTER\n", yytext);
 	}

.|\n		ECHO;

%%

int main (int argc, char* argv[]) {
	FILE *file;
	file = fopen(argv[1], "r");
	if (!file) {
      fprintf (stderr, "No se pudo abrir el archivo %s\n", argv[1]);
      exit (1);
  }
  yyin = file;

yylex();
}
