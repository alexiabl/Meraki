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
#include <list>
#include <string>
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
   	yylval.texto = yytext;
	return SI;
}

"sino" {
    //printf("%s es SINO\n", yytext);	
    	yylval.texto = yytext;
	return SINO;
}

"mientras" {
    //printf("%s es MIENTRAS\n", yytext);
    	yylval.texto = yytext;
	return MIENTRAS;
}


"haga" {
    //printf("%s es HAGA\n", yytext);
      	yylval.texto = yytext;
	return HAGA;  
}


"desde" { /*3 */
    //printf ("%s es ITERACIONI\n", yytext);
    	yylval.texto = yytext;
	return MIENTRAS;    
}

"hasta" { /*4 */
    //printf ("%s es ITERACIONF\n", yytext);
        yylval.texto = yytext;
	return HASTA;
}

"devuelva" { /*1 */
    //printf ("%s es RETORNO\n", yytext);
    	yylval.texto = yytext;
	return DEVUELVA;
}

"imprima" { /*2 */
    //printf ("%s es IMPRESION\n", yytext);
    	yylval.texto = yytext;
	return IMPRIMA;
}

"verdadero" { /*3 */
 	//printf ("%s es VERDADERO\n", yytext);
	yylval.texto = yytext;
	return VERDADERO;
 }

"falso"	{
	//printf ("%s es FALSO\n", yytext);
	yylval.texto = yytext;
	return FALSO;
}

= { 
 	// printf ("%s es IGUAL\n", yytext);
	yylval.car = yytext[0];
	return SIGUAL;
 }

">" { 
 	//printf ("%s es MAYOR\n", yytext);
	yylval.car = yytext[0];
	return SMAYOR;
 }

"<" { 
 	//printf ("%s es MENOR\n", yytext);
	yylval.car = yytext[0];
	return SMENOR;
 }

">=" { 
 	//printf ("%s es MAYOR_IGUAL\n", yytext);
	yylval.texto = yytext;
	return SMAYORIGUAL;
 }

"<=" { 
 	//printf ("%s es MENOR_IGUAL\n", yytext);
	yylval.texto = yytext;
	return SMENORIGUAL;	
 }

 \+ { 
	 //printf ("%s es SUMA\n", yytext);
	 yylval.car = yytext[0];
		 return SUMA;
 }
 
 \- {
 	 //printf ("%s es RESTA\n", yytext);
	  yylval.car = yytext[0];
		 return RESTA;
 }
 
 \* {
 	 //printf ("%s es MULTIPLICACION\n", yytext);
	 yylval.car = yytext[0];
		 return MULTIPLICACION;
 }
 
 \/ {
 	 //printf ("%s es DIVISION\n", yytext);
	 yylval.car = yytext[0];
	return DIVISION;
 }

"igual" {
 		//printf ("%s es IGUAL\n", yytext);
		yylval.texto = yytext;
		return IGUAL;
 	}

"diferente" {
 		//printf ("%s es DIFERENTE\n", yytext);
		yylval.texto = yytext;
		return DIFERENTE;
	}
"y" {
	yylval.car = yytext[0];
	return Y;
}
"o" {
	yylval.car= yytext[0];
	return O;
}


\. { 
 		//printf ("%s es PUNTO\n", yytext);
		yylval.car = yytext[0];
		return PUNTO;
		
 	}

\; { 
 		//printf ("%s es PUNTOCOMA\n", yytext);
		yylval.car = yytext[0];
		return PUNTOCOMA;
 	}

\( { 
 		//printf ("%s es PI\n", yytext);
		yylval.car = yytext[0];
		return PI;
 	}

\) { 
 		//printf ("%s es PARENTESISF\n", yytext);
		yylval.car = yytext[0];
		return PF;
 	}

\{ { 
 		//printf ("%s es LLAVEI\n", yytext);
		yylval.car = yytext[0];
		return LLAVEI;
 	}

\} { 
 		//printf ("%s es LLAVEF\n", yytext);
		yylval.car = yytext[0];
		return LLAVEF;
 	}

\/\*(.|[\n])*\*\/ {
 		//printf ("%s es COMENTARIO\n", yytext);
 	}

(\/\/(.*\n))* {
 		//printf ("%s es COMENTARIO\n", yytext);
 	}

"numero" { 
 		//printf ("%s es TIPO_NUM\n", yytext);
		yylval.texto = yytext;
		return TIPONUM;
 	}

"bool" { 
 		//printf ("%s es TIPO_BOOL\n", yytext);
		yylval.texto = yytext;
		return TIPOBOOL;
 	}

"texto" {
 		//printf ("%s es TIPO_TEXT\n", yytext);
		yylval.texto = yytext;
		return TIPOTEXTO;
 	}

"car" {
 		//printf ("%s es TIPO_CAR\n", yytext);
		yylval.texto = yytext;
		return TIPOCAR;
 	}

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? {
 		// printf ("%s es N_VAR\n", yytext);
		 yylval.texto = yytext;
		 return N_VAR;
 	}

\"(.*)\" { 
 		//printf ("%s es TEXTO\n", yytext);
		yylval.texto = yytext;
		return TEXTO;
		
 	}

-?[0-9]+ { 
 		// printf ("%s es NUMERO\n", yytext);
		  yylval.numero = atoi(yytext);
		 return NUMERO;
 	}

'[^']' { 
 		//printf ("%s es CARACTER\n", yytext);
		yylval.car = yytext[0];
		return CARACTER;
 	}

"main" {
	yylval.texto = yytext;
	return MAIN;
}

.|\n		ECHO;

%%


