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

#include "backup.tab.h"  // to get the token types that we return

%}

%{
 	/*Comentarios*/
 	int nums = 0;
 	int strs = 0;
%}

%option noyywrap
NUM 	[0-9]
%%

"fin" { /*1 */
	printf ("%s es FIN_DE_CICLO\n", yytext);
	return 0;
}

"si" { /*2*/
    printf("%s es SI\n", yytext);
}

"sino" {
    printf("%s es SINO\n", yytext);	
}

"mientras" {
    printf("%s es MIENTRAS\n", yytext);	
}


"haga" {
    printf("%s es HAGA\n", yytext);	
}


"desde" { /*3 */
    printf ("%s es ITERACIONI\n", yytext);
}

"hasta" { /*4 */
    printf ("%s es ITERACIONF\n", yytext);
}

"devuelva" { /*1 */
    printf ("%s es RETORNO\n", yytext);
}

"imprima" { /*2 */
    printf ("%s es IMPRESION\n", yytext);
}

"verdadero" { /*3 */
 		printf ("%s es VERDADERO\n", yytext);
 }

"falso"	{
		printf ("%s es FALSO\n", yytext);
}

= { /*4 */
 		printf ("%s es ASIGNACION\n", yytext);
 	}

">" { 
 		printf ("%s es MAYOR\n", yytext);
 	}

"<" { 
 		printf ("%s es MENOR\n", yytext);
 	}

">=" { 
 		printf ("%s es MAYOR_IGUAL\n", yytext);
 	}

"<=" { 
 		printf ("%s es MENOR_IGUAL\n", yytext);
 	}

 \+ { 
	 printf ("%s es SUMA\n", yytext);
 }
 
 \- {
 	 printf ("%s es RESTA\n", yytext);
	  yylval.resta = atof(yytext);
		 return RESTA;
 }
 
 \* {
 	 printf ("%s es MULTIPLICACION\n", yytext);
 }
 
 \/ {
 	 printf ("%s es DIVISION\n", yytext);
 }

"igual" { /*3 */
 		printf ("%s es IGUAL\n", yytext);
 	}

"diferente" { /*4 */
 		printf ("%s es DIFERENTE\n", yytext);
 	}

\. { 
 		printf ("%s es PUNTO\n", yytext);
 	}

\; { 
 		printf ("%s es PUNTO_COMA\n", yytext);
 	}

\( { 
 		printf ("%s es PARENTESISI\n", yytext);
 	}

\) { 
 		printf ("%s es PARENTESISF\n", yytext);
 	}

\{ { 
 		printf ("%s es LLAVEI\n", yytext);
 	}

\} { 
 		printf ("%s es LLAVEF\n", yytext);
 	}

\/\*(.|[\n])*\*\/ { /*2 */
 		printf ("%s es COMENTARIO\n", yytext);
 	}

(\/\/(.*\n))* { /* 3 */
 		printf ("%s es COMENTARIO\n", yytext);
 	}

"numero" { 
 		printf ("%s es TIPO_NUM\n", yytext);
		 yylval.entero = atof(yytext);
		 return NUMERO;
 	}

"bool" { 
 		printf ("%s es TIPO_BOOL\n", yytext);
 	}

"texto" {
 		printf ("%s es TIPO_TEXT\n", yytext);
 	}

"car" {
 		printf ("%s es TIPO_CAR\n", yytext);
 	}

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? { /* 4 */
 		printf ("%s es NOMBRE_VAR\n", yytext);
 	}

\"(.*)\" { /*1 */
 		printf ("%s es TEXT0\n", yytext);
 	}

-?[0-9]+ { /*2 */
 		printf ("%s es NUMERO\n", yytext);
 	}

'[^']' { /*3 */
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
