%{
#include <stdio.h>
#include "list"
#include "string"
#include "iostream"

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

%union {
	std::string* texto;
	char car;
	int numero;
	std::list<std::string> *lista;
}

%token <texto> RESTA
%token <texto> MULTIPLICACION
%token <texto> DIVISION 
%token <texto> N_VAR
%token <texto> NUMERO
%token <texto> SUMA
%token <texto> IGUAL
%token <texto> SI 
%token <texto> SINO
%token <texto> MIENTRAS 
%token <texto> HAGA
%token <texto> DESDE 
%token <texto> HASTA
%token <texto> DEVUELVA
%token <texto> IMPRIMA 
%token <texto> VERDADERO
%token <texto> FALSO
%token <texto> SIGUAL
%token <texto> SMAYOR
%token <texto> SMENOR
%token <texto> SMAYORIGUAL
%token <texto> SMENORIGUAL
%token <texto> DIFERENTE
%token <texto> PUNTO
%token <texto> PUNTOCOMA
%token <texto> PI
%token <texto> PF
%token <texto> LLAVEI
%token <texto> LLAVEF
%token <texto> COMENTARIO
%token <texto> TIPONUM
%token <texto> TIPOBOOL
%token <texto> TIPOTEXTO
%token <texto> TIPOCAR
%token <texto> TEXTO
%token <texto> CARACTER
%token <texto> Y
%token <texto> O
%token <texto> MAIN

%type<texto> Oplog
%type<lista> Comparacion
%type<texto> Simbolocomparacion
%type<lista> Condicion
%type<texto> Tiponumvar
%type<lista> Tipo
%type<texto> Sumait
%type<texto> Restait
%type<texto> Operadorit
%type<texto> Simboperacion
%type<lista> Declaracion
%type<lista> Operacionmate
%type<lista> Operador
%type<lista> Tipoasignacion
%type<lista> Imprimir
%type<lista> Devuelva
%type<lista> Iteracion
%type<lista> Mientras
%type<lista> Haga
%type<lista> Si
%type<lista> Param
%type<lista> Funcion
%type<lista> Indicacion
%type<lista> Bloquecodigo
%type<lista> Main
%type<lista> Llamado
%type<lista> Bloquemain
%type<texto> Tipovarios
%type<lista> Asignacion
%%
Meraki: Funciones Main
 ;

Funciones: Funcion Funciones 
 |Funcion
 ;

Main:
MAIN PI Param PF LLAVEI Bloquemain LLAVEF
 ;

Bloquemain: Bloquecodigo Llamado
 |Llamado
 ;
 
Llamado:
 N_VAR PI Param PF PUNTOCOMA 
 ;

Bloquecodigo:  Indicacion
 |Bloquecodigo Indicacion
 ;

Indicacion: Si
|Mientras
|Haga
|Imprimir 
|Devuelva
|Declaracion
|Asignacion
|Iteracion 
;

Funcion: 
Tipo N_VAR PI Param PF LLAVEI Bloquecodigo LLAVEF 
;

Param: /* empty */
|Tipo N_VAR Param 
;

Si:
SI Condicion LLAVEI Bloquecodigo LLAVEF 
;

Mientras: 
MIENTRAS Condicion LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<string> *110;l0.push_back($1);}
;

Haga:
HAGA LLAVEI Bloquecodigo LLAVEF MIENTRAS PI Condicion PF {$$ = new std::list<string> *l9;l9.push_back($1);19.splice(l9.end(), $3);l9.push_back($5);19.splice(l9.end(), $7);}
;

Iteracion:
DESDE Tiponumvar HASTA Tiponumvar Operadorit LLAVEI Bloquecodigo LLAVEF {std::list<string> *l10;l10.push_back($1);l10.push_back($2);l10.push_back($3);l10.push_back($4);l10.push_back($5);l10.splice(l10.end(), $7);}
;

Imprimir:
IMPRIMA PI Tipovarios PF PUNTOCOMA {std::list<string> *l9; l9.push_back($1);l9.push_back($3);$$ = *l9;}
;

Devuelva: 
DEVUELVA Tipovarios PUNTOCOMA {std::list<string> *l8;l8.push_back($1);l8.push_back($2); $$ = *l8;}
;

Asignacion:
Tipo N_VAR SIGUAL Tipoasignacion PUNTOCOMA {std::list<string> *l7; l7.push_back($1);l7.push_back($2);l7.push_back($3);l7.push_back($4);$$=*l7;}
;

Tipoasignacion: Tipo {$$ = $1;}
|Operacionmate {$$ = $1;}
;

Operacionmate: 
Tiponumvar Operador {std::list<string> *l6; l6.push_back($1);l6.push_back($2);$$=*l6;}
;

Operador: Simboperacion Tiponumvar Operador {std::list<string> *l5;l5.push_back($1);l5.push_back($2);l5.push_back($3);$$=*l5;}
|Simboperacion Tiponumvar {std::list<string> *l4;l4.push_back($1);l4.push_back($2);$$=*l4;}
;

Simboperacion: SUMA {$$ = $1;}
|RESTA {$$ = $1;}
|MULTIPLICACION {$$ = $1;}
|DIVISION {$$ = $1;}
;

Declaracion: Tipo N_VAR PUNTOCOMA {std::list<string> *l3;l3.push_back($1);l3.push_back($2);$$=*l3;}
;

Operadorit: Sumait {$$ = $1;}
|Restait {$$ = $1;}
;

Sumait: 
SUMA SUMA {strcat($1,$2); $$ = $1;}
;

Restait: 
RESTA RESTA {strcat($1,$2); $$ = $1;}
;

Tipo: TIPONUM {$$ = $1;}
|TIPOBOOL {$$ = $1;}
|TIPOCAR {$$ = $1;}
|TIPOTEXTO {$$ = $1;}
;

Condicion:
Tipovarios Comparacion {std::list<string> *l2;l2.push_back($1);l2.splice(l2.end(),$2); $$ = *l2;}
;

Comparacion: Simbolocomparacion Tipovarios Oplog Condicion {std::list<std::string> *l1; l1.push_back($1);l1.push_back($2);l1.push_back($3);l1.splice(l1.end(),$4);$$ = *l1;}
|Simbolocomparacion Tipovarios {std::list<std::string*> l0;l0.push_back($1);l0.push_back($2);$$ = *l0;}
;

Tipovarios: CARACTER {$$ = $1;}
|NUMERO {$$ = $1;}
|TEXTO {$$ = $1;}
|VERDADERO {$$ = $1;}
|FALSO {$$ = $1;}
|N_VAR {$$ = $1;}
;

Oplog: O {$$ = $1;}
|Y {$$ = $1;};

Tiponumvar: NUMERO {$$ = $1;}
|N_VAR {$$ = $1;}
;

Simbolocomparacion: SMAYOR {$$ = $1;}
|SMENOR {$$ = $1;}
|SMAYORIGUAL {$$ = $1;}
|SMENORIGUAL {$$ = $1;}
|DIFERENTE {$$ = $1;}
|SIGUAL {$$ = $1;}
;

%%
int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("in.analisisSintactico", "r");
	// make sure it's valid:
	if (!myfile) {
		printf("No se pudo abrir el archivo");
		return -1;
	}
	// set flex to read from it instead of defaulting to STDIN:
	yyin = myfile;
	//printf(myfile);
	// parse through the input until there is no more:
	do {
		yyparse();
		} while (!feof(yyin));
	
	
}
void yyerror(const char *s) {
	printf("Error de parsing: %s", s);
	exit(-1);
}
// Comandos que estoy corriendo:
// bison -d analisisSintactico.y
// flex merakiTokens.l
// g++ analisisSintactico.tab.c lex.yy.c -ll -o analisisS
