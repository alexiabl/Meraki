%{
#include <stdio.h>
// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

%union {
    char *fin;
    char *si;
    char *sino;
    char *mientras;
    char *haga;
    char *desde;
    char *hasta;
    char *devuelva;
    char *imprima;
    char *verdadero;
    char *falso;
    char sym_igual;
    char sym_mayor;
    char sym_menor;
    char sym_mayor_igual;
    char sym_menor_igual;
    char suma;
    char resta;
    char mult;
    char division;
    char *igual;
    char *diferente;
    char punto;
    char punto_coma;
    char parentesisAbre;
    char parentesisCierra;
    char llaveAbre;
    char llaveCierra;
    char *comentario;
    char *tipo_num;
    char *tipo_bool;
    char *tipo_text;
    char *tipo_car;
    char *nombre_var;
    int entero;
    char *texto;
    char car;
}

%token <resta> RESTA
%token <mult> MULTIPLICACION
%token <division> DIVISION 
%token <nombre_var> N_VAR
%token <entero> NUMERO
%token <suma> SUMA
%token <igual> IGUAL
%token <fin> FIN

%%

Asignacion: // por ahora lo dejo asi
 N_VAR IGUAL NUMERO FIN{ printf("Bison detecto una asignacion : %s %c %d %s\n", $1, $2, $3, $4) } 
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
