%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

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



// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <fin> FIN_DE_CICLO
%token <si> SI 
%token <sino> SINO
%token <mientras> MIENTRAS 
%token <haga> HAGA
%token <desde> DESDE 
%token <hasta> HASTA
%token <devuelva> DEVUELVA
%token <imprima> IMPRIMA 
%token <si> SI  

%token <entero> NUMERO
%token <texto> TEXTO
%%

