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
#include <iostream>
#include "analisisSintactico.tab.h"  // to get the token types that we return
using namespace std;
#define YY_DECL extern "C" int yylex()
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
	printf ("%s es FIN\n", yytext);
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

= { 
 		printf ("%s es IGUAL\n", yytext);
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

"igual" {
 		printf ("%s es IGUAL\n", yytext);
 	}

"diferente" {
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

\/\*(.|[\n])*\*\/ {
 		printf ("%s es COMENTARIO\n", yytext);
 	}

(\/\/(.*\n))* {
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

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? {
 		printf ("%s es NOMBRE_VAR\n", yytext);
 	}

\"(.*)\" { 
 		printf ("%s es TEXT0\n", yytext);
 	}

-?[0-9]+ { 
 		printf ("%s es NUMERO\n", yytext);
 	}

'[^']' { 
 		printf ("%s es CARACTER\n", yytext);
 	}

.|\n		ECHO;

%%
