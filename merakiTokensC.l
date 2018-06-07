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
#include "list"
#include "string"
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
"main" { /*2*/
    //printf("%s es SI\n", yytext);
   	yylval.texto = new std::string(yytext);
	return MAIN;
}

"si" { /*2*/
    //printf("%s es SI\n", yytext);
   	yylval.texto = new std::string(yytext);
	return SI;
}

"sino" {
    //printf("%s es SINO\n", yytext);	
    	yylval.texto = new std::string(yytext);
	return SINO;
}

"mientras" {
    //printf("%s es MIENTRAS\n", yytext);
    	yylval.texto = new std::string(yytext);
	return MIENTRAS;
}


"haga" {
    //printf("%s es HAGA\n", yytext);
      	yylval.texto = new std::string(yytext);
	return HAGA;  
}


"desde" { /*3 */
    //printf ("%s es ITERACIONI\n", yytext);
    	yylval.texto = new std::string(yytext);
	return DESDE;    
}

"hasta" { /*4 */
    //printf ("%s es ITERACIONF\n", yytext);
        yylval.texto = new std::string(yytext);
	return HASTA;
}

"devuelva" { /*1 */
    //printf ("%s es RETORNO\n", yytext);
    	yylval.texto = new std::string(yytext);
	return DEVUELVA;
}

"imprima" { /*2 */
    //printf ("%s es IMPRESION\n", yytext);
    	yylval.texto = new std::string(yytext);
	return IMPRIMA;
}

"verdadero" { /*3 */
 	//printf ("%s es VERDADERO\n", yytext);
	yylval.texto = new std::string(yytext);
	return VERDADERO;
 }

"falso"	{
	//printf ("%s es FALSO\n", yytext);
	yylval.texto = new std::string(yytext);
	return FALSO;
}

= { 
 	// printf ("%s es IGUAL\n", yytext);
	yylval.texto = new std::string(yytext);
	return SIGUAL;
 }

">" { 
 	//printf ("%s es MAYOR\n", yytext);
	yylval.texto = new std::string(yytext);
	return SMAYOR;
 }

"<" { 
 	//printf ("%s es MENOR\n", yytext);
	yylval.texto = new std::string(yytext);
	return SMENOR;
 }

">=" { 
 	//printf ("%s es MAYOR_IGUAL\n", yytext);
	yylval.texto = new std::string(yytext);
	return SMAYORIGUAL;
 }

"<=" { 
 	//printf ("%s es MENOR_IGUAL\n", yytext);
	yylval.texto = new std::string(yytext);
	return SMENORIGUAL;	
 }

 \+ { 
	 //printf ("%s es SUMA\n", yytext);
	 yylval.texto = new std::string(yytext);
		 return SUMA;
 }
 
 \- {
 	 //printf ("%s es RESTA\n", yytext);
	  yylval.texto = new std::string(yytext);
		 return RESTA;
 }
 
 \* {
 	 //printf ("%s es MULTIPLICACION\n", yytext);
	 yylval.texto = new std::string(yytext);
		 return MULTIPLICACION;
 }
 
 \/ {
 	 //printf ("%s es DIVISION\n", yytext);
	 yylval.texto = new std::string(yytext);
	return DIVISION;
 }

"igual" {
 		//printf ("%s es IGUAL\n", yytext);
		yylval.texto = new std::string(yytext);
		return IGUAL;
 	}

"diferente" {
 		//printf ("%s es DIFERENTE\n", yytext);
		yylval.texto = new std::string(yytext);
		return DIFERENTE;
	}
"y" {
	yylval.texto = new std::string(yytext);
	return Y;
}
"o" {
	yylval.texto= new std::string(yytext);
	return O;
}


\. { 
 		//printf ("%s es PUNTO\n", yytext);
		yylval.texto = new std::string(yytext);
		return PUNTO;
		
 	}

\; { 
 		//printf ("%s es PUNTOCOMA\n", yytext);
		yylval.texto = new std::string(yytext);
		return PUNTOCOMA;
 	}

\( { 
 		//printf ("%s es PI\n", yytext);
		yylval.texto = new std::string(yytext);
		return PI;
 	}

\) { 
 		//printf ("%s es PARENTESISF\n", yytext);
		yylval.texto = new std::string(yytext);
		return PF;
 	}

\{ { 
 		//printf ("%s es LLAVEI\n", yytext);
		yylval.texto = new std::string(yytext);
		return LLAVEI;
 	}

\} { 
 		//printf ("%s es LLAVEF\n", yytext);
		yylval.texto = new std::string(yytext);
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
		yylval.texto = new std::string(yytext);
		return TIPONUM;
 	}

"bool" { 
 		//printf ("%s es TIPO_BOOL\n", yytext);
		yylval.texto = new std::string(yytext);
		return TIPOBOOL;
 	}

"texto" {
 		//printf ("%s es TIPO_TEXT\n", yytext);
		yylval.texto = new std::string(yytext);
		return TIPOTEXTO;
 	}

"car" {
 		//printf ("%s es TIPO_CAR\n", yytext);
		yylval.texto = new std::string(yytext);
		return TIPOCAR;
 	}

[a-z]+((\d)|([A-Z0-9][a-z0-9]+))*([A-Z])? {
 		// printf ("%s es N_VAR\n", yytext);
		 yylval.texto = new std::string(yytext);
		 return N_VAR;
 	}

\"(.*)\" { 
 		//printf ("%s es TEXTO\n", yytext);
		yylval.texto = new std::string(yytext);
		return TEXTO;
		
 	}

-?[0-9]+ { 
 		// printf ("%s es NUMERO\n", yytext);
		  yylval.texto = new std::string(yytext);
		 return NUMERO;
 	}

'[^']' { 
 		//printf ("%s es CARACTER\n", yytext);
		yylval.texto = new std::string(yytext);
		return CARACTER;
 	}
.|\n		ECHO;

%%
