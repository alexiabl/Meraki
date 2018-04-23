%{
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

//Operacion_Mate -> N_VAR SUMAR| RESTAR | MULTIPLICAR| DIVIDIR  
//| NUM SUMAR| RESTAR | MULTIPLICAR| DIVIDIR

%union {
    char resta;
    char *nombre_var;
    char mult;
    char division;
    int entero;
    char suma;
}

%token <resta> RESTA
%token <mult> MULTIPLICACION
%token <division> DIVISION 
%token <nombre_var> N_VAR
%token <entero> NUMERO
%token <suma> SUMA

%%

Operacion_Mate: //por ahora lo dejo asi
 NUMERO SUMA | RESTA | MULTIPLICACION | DIVISION  
{ printf("Bison detecto una operacion matematica")}
 ;

%%

int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("in.analisisSintactico", "r");
	// make sure it's valid:
	if (!myfile) {
		cout << "No se pudo abrir el archivo" << endl;
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

//Comandos que estoy corriendo:
// bison -d analisisSintactico.y
// flex merakiTokens.l
// g++ analisisSintactico.tab.c lex.yy.c -o analisisS