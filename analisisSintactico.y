%{
#include <stdio.h>
#include <list>
#include <stack>
#include "Estructura.h"
Estructura<string> e;

#include "PilaToken.h"
PilaToken<string> pilatoken;
stack<PilaToken> pila;
// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

%union {
	char* texto;
	char car;
	int numero;
	std::list<string> *lista;
}

%token <car> RESTA
%token <car> MULTIPLICACION
%token <car> DIVISION 
%token <texto> N_VAR
%token <numero> NUMERO
%token <car> SUMA
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
%token <car> SIGUAL
%token <car> SMAYOR
%token <car> SMENOR
%token <texto> SMAYORIGUAL
%token <texto> SMENORIGUAL
%token <texto> DIFERENTE
%token <car> PUNTO
%token <car> PUNTOCOMA
%token <car> PI
%token <car> PF
%token <car> LLAVEI
%token <car> LLAVEF
%token <texto> COMENTARIO
%token <texto> TIPONUM
%token <texto> TIPOBOOL
%token <texto> TIPOTEXTO
%token <texto> TIPOCAR
%token <texto> TEXTO
%token <car> CARACTER
%token <car> Y
%token <car> O
%token <texto> MAIN



%type<lista> Main
%type<lista> Llamado
%type<lista> Funcion
%type<lista> Si
%type<lista> Mientras
%type<lista> Haga
%type<lista> Imprimir
%type<lista> Devuelva
%type<lista> Asignacion
%type<lista> Declaracion
%type<lista> Iteracion
%type<lista> Bloquecodigo
%type<lista> Param
%type<lista> Tipo
%type<lista> Condicion
%type<lista> Tipovarios
%type<lista> Tipoasignacion
%type<lista> Tiponumvar
%type<texto> Operadorit
%type<lista> Indicacion
%type<lista> Operacionmate
%type<lista> Operador
%type<texto> Simboperacion
%type<texto> Sumait
%type<texto> Restait
%type<lista> Comparacion
%type<texto> Oplog
%type<texto> Simbolocomparacion
%type<lista> Funciones


%%
Meraki: Funciones Main { e.insert($2,13); } 
 ;

Funciones: Funcion Funciones { e.insert($1,2); }
 | Funcion { e.insert($1,2); }
 ;

Bloquecodigo:  Indicacion {e.insert($1,11);} 
 |Indicacion Bloquecodigo {e.insert($1,11); e.insert($2,12);} 
 ;

Main: MAIN LLAVEI Bloquecodigo LLAVEF  {$$ = new std::list<string> *l13 ($1,$2,$3,$4);}
;
 
Llamado:
 N_VAR PI Param PF PUNTOCOMA {$$ = new std::list<string> *l13 ($1,$2,$3,$4,$5);}
 ;
 
Indicacion: Si {$$ = $1;} 
|Mientras {$$ = $1;} 
|Haga {$$ = $1;} 
|Imprimir {$$ = $1;} 
|Devuelva {$$ = $1;} 
|Declaracion {$$ = $1;} 
|Asignacion {$$ = $1;} 
|Iteracion {$$ = $1;} 
|Llamado {$$ = $1;} 
;
 //arreglo[0]= Main
        //arreglo[1]= Llamado
        //arreglo[2]= Funcion
        //arreglo[3]= Si
        //arreglo[4]= Mientras
        //arreglo[5]= Haga
        //arreglo[6]= Imprimir
        //arreglo[7]= Devuelva
        //arreglo[8]= Asignacion
        //arreglo[9]= Declaracion
        //arreglo[10]= Iteracion
		//arreglo[11]=Indicacion
		//arreglo[12]=Bloquecodigo
		//arreglo[13] =Main

Funcion: 
Tipo N_VAR PI Param PF LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<string> *l6 ($1,$2,$3,$4,$5,$6,$7,$8);}
;

Param:
Tipo N_VAR Param {$$ = new std::list<string> *l12 ($1,$2,$3);}
| {}
;

Si:
SI Condicion LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<string> *l11 ($1,$2,$3,$4,$5);}
;

Mientras: 
MIENTRAS Condicion LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<string> *l10 ($1,$2,$3,$4,$5);}
;

Haga:
HAGA LLAVEI Bloquecodigo LLAVEF MIENTRAS PI Condicion PF {$$ = new std::list<string> *l9 ($1,$2,$3,$4,$5,$6,$7,$8);}
;

Imprimir:
IMPRIMA PI Tipovarios PF PUNTOCOMA {$$ = new std::list<string> *l8 ($1,$2,$3,$4,$5);}
;

Devuelva: 
DEVUELVA Tipovarios PUNTOCOMA {$$ = new std::list<string> *l7 ($1,$2,$3);}
;

Asignacion:
Tipo N_VAR SIGUAL Tipoasignacion PUNTOCOMA {$$ = new std::list<string> *l6 ($1,$2,$3,$4,$5);}
;

Tipoasignacion: Tipo {$$ = $1;}
|Operacionmate {$$ = $1;}
;

Operacionmate: 
Tiponumvar Operador {$$ = new std::list<string> *l5 ($1,$2);}
;

Operador: Simboperacion Tiponumvar Operador {$$ = new std::list<string> *l3 ($1,$2,$3);}
|Simboperacion Tiponumvar {$$ = new std::list<string> *l4 ($1,$2);}
;

Simboperacion: SUMA {$$ = $1;}
|RESTA {$$ = $1;}
|MULTIPLICACION {$$ = $1;}
|DIVISION {$$ = $1;}
;

Declaracion: Tipo N_VAR PUNTOCOMA {e.insert($1,9);e.insert($2,9);e.insert($3,9);}
;

Iteracion:
DESDE Tiponumvar HASTA Tiponumvar Operadorit LLAVEI Bloquecodigo LLAVEF { e.insert($1,10);e.insert($2,10);e.insert($3,10);e.insert($4,10);e.insert($5,10);e.insert($6,10);e.insert($7,10);e.insert($8,10);}
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
Tipovarios Comparacion {$$ = new std::list<string> *l2 ($1);l2.push_back($2);}
;

Comparacion: Simbolocomparacion Tipovarios Oplog Condicion {$$ = new std::list<string> *l1 ($1,$2,$3); l1.push_back($4);}
|Simbolocomparacion Tipovarios {$$ = new std::list<string> *l1 ($1,$2);}
;

Tipovarios: CARACTER {$$ = $1;}
|NUMERO {$$ = $1;}
|TEXTO {$$ = $1;}
|VERDADERO {$$ = $1;}
|FALSO {$$ = $1;}
|N_VAR {$$ = $1;}
;

Oplog: Y {$$ = $1;}
| O {$$ = $1;}
;

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
	// parse through the input until there is no more:
	do {
		yyparse();
	} while (!feof(yyin));


	
}
void yyerror(const char *s) {
	printf("Error de parsing");
	exit(-1);
}
// Comandos que estoy corriendo:
// bison -d analisisSintactico.y
// flex merakiTokens.l
// g++ analisisSintactico.tab.c lex.yy.c -ll -o analisisS

