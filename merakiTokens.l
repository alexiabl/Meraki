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

%option yylineno
%option noyywrap
NUM 	[0-9]
%%

"si" { /*2*/
    //printf("%s es SI\n", yytext);
   	yylval.si = yytext[0];
	return SI;
}

"sino" {
    //printf("%s es SINO\n", yytext);	
    	yylval.sino = yytext[0];
	return SINO;
}

"mientras" {
    //printf("%s es MIENTRAS\n", yytext);
    	yylval.mientras = yytext[0];
	return MIENTRAS;
}


"haga" {
    //printf("%s es HAGA\n", yytext);
      	yylval.haga = yytext[0];
	return HAGA;  
}


"desde" { /*3 */
    //printf ("%s es ITERACIONI\n", yytext);
    	yylval.desde = yytext[0];
	return MIENTRAS;    
}

"hasta" { /*4 */
    //printf ("%s es ITERACIONF\n", yytext);
        yylval.hasta = yytext[0];
	return HASTA;
}

"devuelva" { /*1 */
    //printf ("%s es RETORNO\n", yytext);
    	yylval.devuelva = yytext[0];
	return DEVUELVA;
}

"imprima" { /*2 */
    //printf ("%s es IMPRESION\n", yytext);
    	yylval.imprima = yytext[0];
	return IMPRIMA;
}

"verdadero" { /*3 */
 	//printf ("%s es VERDADERO\n", yytext);
	yylval.verdadero = yytext[0];
	return VERDADERO;
 }

"falso"	{
	//printf ("%s es FALSO\n", yytext);
	yylval.falso = yytext[0];
	return FALSO;
}

= { 
 	// printf ("%s es IGUAL\n", yytext);
	yylval.sym_igual = yytext[0];
	return IGUAL;
 }

">" { 
 	//printf ("%s es MAYOR\n", yytext);
	yylval.sym_mayor = yytext[0];
	return MAYOR;
 }

"<" { 
 	//printf ("%s es MENOR\n", yytext);
	yylval.sym_menor = yytext[0];
	return MENOR;
 }

">=" { 
 	//printf ("%s es MAYOR_IGUAL\n", yytext);
	yylval.sym_mayor_igual = yytext[0];
	return MAYOR_IGUAL;
 }

"<=" { 
 	//printf ("%s es MENOR_IGUAL\n", yytext);
	yylval.sym_menor_igual = yytext[0];
	return MENOR_IGUAL;	
 }

 \+ { 
	 //printf ("%s es SUMA\n", yytext);
	 yylval.suma = atof(yytext);
		 return SUMA;
 }
 
 \- {
 	 //printf ("%s es RESTA\n", yytext);
	  yylval.resta = atof(yytext);
		 return RESTA;
 }
 
 \* {
 	 //printf ("%s es MULTIPLICACION\n", yytext);
	 yylval.mult = atof(yytext);
		 return MULTIPLICACION;
 }
 
 \/ {
 	 //printf ("%s es DIVISION\n", yytext);
	 yylval.division = atof(yytext);
	return DIVISION;
 }

"igual" {
 		//printf ("%s es IGUAL\n", yytext);
		yylval.igual = yytext[0];
		return IGUAL;
 	}

"diferente" {
 		//printf ("%s es DIFERENTE\n", yytext);
		yylval.diferente = yytext[0];
		return DIFERENTE;
	}

\. { 
 		//printf ("%s es PUNTO\n", yytext);
		
 	}

\; { 
 		//printf ("%s es PUNTO_COMA\n", yytext);
		yylval.punto_coma = yytext[0];
		return PUNTO_COMA;
 	}

\( { 
 		//printf ("%s es PARENTESISI\n", yytext);
 	}

\) { 
 		//printf ("%s es PARENTESISF\n", yytext);
 	}

\{ { 
 		//printf ("%s es LLAVEI\n", yytext);
 	}

\} { 
 		//printf ("%s es LLAVEF\n", yytext);
 	}

\/\*(.|[\n])*\*\/ {
 		//printf ("%s es COMENTARIO\n", yytext);
 	}

(\/\/(.*\n))* {
 		//printf ("%s es COMENTARIO\n", yytext);
 	}

"numero" { 
 		//printf ("%s es TIPO_NUM\n", yytext);
 	}

"bool" { 
 		//printf ("%s es TIPO_BOOL\n", yytext);
		yylval.tipo_bool = yytext[0];
		return TIPO_BOOL;
 	}

"texto" {
 		//printf ("%s es TIPO_TEXT\n", yytext);
		yylval.tipo_text = yytext[0];
		return TIPO_TEXT;
 	}

"car" {
 		//printf ("%s es TIPO_CAR\n", yytext);
		yylval.tipo_car = yytext[0];
		return TIPO_CAR;
 	}

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? {
 		// printf ("%s es N_VAR\n", yytext);
		 yylval.nombre_var = (strdup)(yytext);
		 return N_VAR;
 	}

\"(.*)\" { 
 		//printf ("%s es TEXTO\n", yytext);
		yylval.texto = yytext[0];
		return TEXTO;
		
 	}

-?[0-9]+ { 
 		// printf ("%s es NUMERO\n", yytext);
		  yylval.entero = atoi(yytext);
		 return NUMERO;
 	}

'[^']' { 
 		//printf ("%s es CARACTER\n", yytext);
		yylval.car = yytext[0];
		return CARACTER;
 	}

.|\n		ECHO;

%%
