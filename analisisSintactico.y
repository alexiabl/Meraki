%{
#include <stdio.h>
#include <list>
#include <stack>
#include <string>
//#include "Estructura.h"
//Estructura< std::list<std::string> > e;

using namespace std;
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
	std::list<std::string*> *lista;
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
%type<lista> Condicion


%%
Condicion:
Oplog Oplog {$$ = new std::list<std::string*>;
			 $$->push_back($1);
			 $$->push_back($2);
			 printf("C: %s ",$$->front());
			}
;

Oplog: O {$$ = $1;}
|Y {$$ = $1;}


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
