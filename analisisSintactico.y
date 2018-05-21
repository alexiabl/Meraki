%{
#include <stdio.h>
// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
 
void yyerror(const char *s);
%}

%union {
    char si;
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

    char y;
    char o;
    char *main;
}

%token <resta> RESTA
%token <mult> MULTIPLICACION
%token <division> DIVISION 
%token <nombre_var> N_VAR
%token <entero> NUMERO
%token <suma> SUMA
%token <igual> IGUAL

%token <si> SI 
%token <sino> SINO
%token <mientras> MIENTRAS 
%token <haga> HAGA
%token <desde> DESDE 
%token <hasta> HASTA
%token <devuelva> DEVUELVA
%token <imprima> IMPRIMA 

%token <verdadero> VERDADERO
%token <falso> FALSO
%token <sym_igual> SIGUAL
%token <sym_mayor> SMAYOR
%token <sym_menor> SMENOR
%token <sym_mayor_igual> SMAYORIGUAL
%token <sym_menor_igual> SMENORIGUAL
%token <diferente> DIFERENTE
%token <punto> PUNTO
%token <punto_coma> PUNTOCOMA
%token <parentesisAbre> PI
%token <parentesisCierra> PF
%token <llaveAbre> LLAVEI
%token <llaveCierra> LLAVEF
%token <comentario> COMENTARIO
%token <tipo_num> TIPONUM
%token <tipo_bool> TIPOBOOL
%token <tipo_text> TIPOTEXTO
%token <tipo_car> TIPOCAR
%token <texto> TEXTO
%token <car> CARACTER
%token <y> Y
%token <o> O
%token <main> MAIN

%%

Meraki:
 Bloque MAIN {}
 ;

Bloque: Bloquecodigo 
 |Funcion {}
 ;

Bloquecodigo: 
 |Indicacion Bloquecodigo {}
 ;

Indicacion: 
 |Si
 |Mientras
 |Haga
 |Imprimir 
 |Devuelva
 |Declaracion
 |Asignacion
 |Iteracion {}
 ;

Funcion: 
 Tipo N_VAR PI Param PF LLAVEI Bloquecodigo LLAVEF {}
  ;

Param:
 |Tipo N_VAR Param {}
  ;

Si:
 SI Condicion LLAVEI Bloquecodigo LLAVEF {}
 ;

Mientras: 
 MIENTRAS Condicion LLAVEI Bloquecodigo LLAVEF {}
 ;

Haga:
 HAGA LLAVEI Bloquecodigo LLAVEF MIENTRAS PI Condicion PF {}
 ;

Imprimir:
 IMPRIMA PI Tipovarios PF PUNTOCOMA {}
 ;

Devuelva: 
 DEVUELVA Tipovarios PUNTOCOMA {}
 ;

Asignacion:
 Tipo N_VAR SIGUAL Tipoasignacion PUNTOCOMA {}
 ;

Tipoasignacion: Tipo
 |Operacionmate {}
 ;

Operacionmate: 
 Tiponumvar Operador {}
 ;

Operador: Simboperacion Tiponumvar Operador 
 |Simboperacion Tiponumvar {}
 ;

Simboperacion: SUMA
 |RESTA
 |MULTIPLICACION
 |DIVISION {}
 ;

Declaracion: Tipo N_VAR PUNTOCOMA {}
 ;

Iteracion:
 DESDE Tiponumvar HASTA Tiponumvar Operadorit LLAVEI Bloquecodigo LLAVEF {}
 ;

Operadorit: Sumait
 |Restait {}
 ;

Sumait: 
SUMA SUMA {}
 ;

Restait: 
RESTA RESTA {}
 ;

Tipo: TIPONUM
 | TIPOBOOL
 | TIPOCAR
 | TIPOTEXTO {}
 ;

Condicion:
Tipovarios Comparacion {}
;

Comparacion: 
 Simbolocomparacion Tipovarios Oplog Condicion 
 |Simbolocomparacion Tipovarios {}

Tipovarios: CARACTER
 | NUMERO
 | TEXTO
 | VERDADERO
 | FALSO
 | N_VAR {}
;

Oplog: Y
 | O {}
 ;

Tiponumvar: NUMERO
 | N_VAR {}
 ;

Simbolocomparacion: SMAYOR
 |SMENOR
 |SMAYORIGUAL
 |SMENORIGUAL
 |DIFERENTE
 |SIGUAL {}
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
