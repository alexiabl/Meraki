%{
#include <stdio.h>
//#include <list>
#include <stack>
#include <string>
#include "Estructura.h"
Estructura< std::list<std::string*>* > e;

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
%type<lista> Comparacion
%type<texto> Simbolocomparacion
%type<texto> Tiponumvar
%type<texto> Tipovarios
%type<texto> Sumait
%type<texto> Restait
%type<texto> Operadorit
%type<texto> Tipo
%type<lista> Declaracion
%type<texto> Simboperacion
%type<lista> Operador
%type<lista> Operacionmate
%type<lista> Tipoasignacion
%type<lista> Asignacion
%type<lista> Devuelva
%type<lista> Imprimir
%type<lista> Iteracion
%type<lista> Haga
%type<lista> Mientras
%type<lista> Si 
%type<lista> Bloquecodigo
%type<lista> Indicacion
%%
Meraki: Funciones Main {$$ = new std::list<std::string*>;
		   $$->insert($$->end(),$1->begin(),$1->end());
		   $$->insert($$->end(),$2->begin(),$2->end());
		  }
 ;

Funciones: Funcion Funciones {$$ = new std::list<std::string*>;
							  $$->insert($$->end(),$1->begin(),$1->end());
							  $$->insert($$->end(),$2->begin(),$2->end());
							  e.insert(&$$,9); e.actualizarPila(9);
							  }
 |Funcion {$$ = new std::list<std::string*>;
		   $$->insert($$->end(),$1->begin(),$1->end());
		   e.insert(&$$,9); e.actualizarPila(9);
		  }
 ;

Main:
MAIN PI Param PF LLAVEI Bloquemain LLAVEF {$$ = new std::list<std::string*>;
										   $$->push_back($1);
										   $$->insert($$->end(),$3->begin(),$3->end());
										   $$->insert($$->end(),$6->begin(),$6->end());
										   e.insert(&$$,12); e.actualizarPila(12);
										  }
 ;

Bloquemain: Bloquecodigo Llamado {$$ = new std::list<std::string*>;
							      $$->insert($$->end(),$1->begin(),$1->end());
						          $$->insert($$->end(),$2->begin(),$2->end());
								  e.insert(&$$,11); e.actualizarPila(11);
						         }
|Llamado {$$ = new std::list<std::string*>;
		  $$->insert($$->end(),$1->begin(),$1->end());
		  }
 ;
 
Llamado:
 N_VAR PI Param PF PUNTOCOMA {$$ = new std::list<std::string*>;
						      $$->push_back($1);
						      $$->insert($$->end(),$3->begin(),$3->end());
						     }
 ;
 
Bloquecodigo:  Indicacion {$$ = $1;
						   e.insert(&$$,9); 
						   e.actualizarPila(9);}
						   
 |Bloquecodigo Indicacion {$$ = new std::list<std::string*>;
						   $$->push_back($1);
						   $$->push_back($2);
						   e.insert(&$$,10); 
						   e.actualizarPila(10);
						   }
 ;
 
Indicacion: Si {$$ = $1;e.insert(&$1,8); e.actualizarPila(8);}
|Mientras {$$ = $1; e.insert(&$1,7); e.actualizarPila(7);}
|Haga {$$ = $1; e.insert(&$1,6); e.actualizarPila(6);}
|Imprimir {$$ = $1; e.insert(&$1,5); e.actualizarPila(5);}
|Devuelva {$$ = $1; e.insert(&$1,1); e.actualizarPila(1);}
|Declaracion {$$ = $1; e.insert(&$1,2); e.actualizarPila(2);}
|Asignacion {$$ = $1; e.insert(&$1,0); e.actualizarPila(0);}
|Iteracion {$$ = $1; e.insert(&$1,3); e.actualizarPila(3);}
;

Funcion: 
Tipo N_VAR PI Param PF LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<std::string*>;
												   $$->push_back($1);
												   $$->push_back($2);
												   $$->insert($$->end(),$4->begin(),$4->end());
												   $$->insert($$->end(),$6->begin(),$6->end());
												   }
;

Param: /* empty */ 
|Tipo N_VAR Param {$$ = new std::list<std::string*>;
				   $$->push_back($1);
				   $$->push_back($2);
				   $$->insert($$->end(),$3->begin(),$3->end());
				   }
;

Si:
SI PI Condicion PF LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<std::string*>;
									     $$->push_back($1);
										 $$->insert($$->end(),$3->begin(),$3->end());
										 $$->insert($$->end(),$6->begin(),$6->end());
									    }
;

Mientras: 
MIENTRAS PI Condicion PF LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<std::string*>;
											   $$->push_back($1);
											   $$->insert($$->end(),$3->begin(),$3->end());
											   $$->insert($$->end(),$6->begin(),$6->end());
											  }
;

Haga:
HAGA LLAVEI Bloquecodigo LLAVEF MIENTRAS PI Condicion PF {$$ = new std::list<std::string*>;
														  $$->push_back($1);
													      $$->insert($$->end(),$3->begin(),$3->end());
														  $$->push_back($5);
														  $$->insert($$->end(),$7->begin(),$7->end());
														 }

Iteracion:
DESDE Tiponumvar HASTA Tiponumvar Operadorit LLAVEI Bloquecodigo LLAVEF {$$ = new std::list<std::string*>;
																	     $$->push_back($1);
																		 $$->push_back($2);
																		 $$->push_back($3);
																		 $$->push_back($4);
																		 $$->push_back($5);
																		 $$->insert($$->end(),$7->begin(),$7->end());
																		 }
;								   

Imprimir:
IMPRIMA PI Tipovarios PF PUNTOCOMA {$$ = new std::list<std::string*>;
							        $$->push_back($1);
							        $$->push_back($3);
							       }
;

Devuelva: 
DEVUELVA Tipovarios PUNTOCOMA {$$ = new std::list<std::string*>;
							   $$->push_back($1);
							   $$->push_back($2);
							   e.insert($1,1);
							   e.insert($2,1)
							   }
;											

Asignacion:
Tipo N_VAR SIGUAL Tipoasignacion PUNTOCOMA {$$ = new std::list<std::string*>;
											$$->push_back($1);
											$$->push_back($2);
											$$->push_back($3);
											$$->insert($$->end(),$4->begin(),$4->end());
										   }
;

Tipoasignacion: Tipo {$$ = new std::list<std::string*>; 
					  $$->push_back($1);
					  }
|Operacionmate {$$ = $1;}
;

Operacionmate: 
Tiponumvar Operador {$$ = new std::list<std::string*>; 
					 $$->push_back($1);
					 $$->insert($$->end(),$2->begin(),$2->end());
					}
;

Operador: Simboperacion Tiponumvar Operador {$$ = new std::list<std::string*>; 
											 $$->push_back($1);
											 $$->push_back($2);
											 $$->insert($$->end(),$3->begin(),$3->end());
											}
|Simboperacion Tiponumvar {$$ = new std::list<std::string*>; 
					    $$->push_back($1);
						$$->push_back($2);
						}
;

Simboperacion: SUMA {$$ = $1;}
|RESTA {$$ = $1;}
|MULTIPLICACION {$$ = $1;}
|DIVISION {$$ = $1;}
;

Declaracion: Tipo N_VAR PUNTOCOMA {$$ = new std::list<std::string*>; 
					    $$->push_back($1);
						$$->push_back($2);
						}
;

Operadorit: Sumait {$$ = $1;}
|Restait {$$ = $1;}
;

Sumait: 
SUMA SUMA {$$ = new string;
		   $$->insert(0,"++");}
;

Restait: 
RESTA RESTA {$$ = new string;
		   $$->insert(0,"--");}
;

Tipo: TIPONUM {$$ = $1;}
|TIPOBOOL {$$ = $1;}
|TIPOCAR {$$ = $1;}
|TIPOTEXTO {$$ = $1;}
;

Condicion:
Tipovarios Comparacion {$$ = new std::list<std::string*>; 
					    $$->push_back($1);
						$$->insert($$->end(),$2->begin(),$2->end());
						}
;

Comparacion: Simbolocomparacion Tipovarios Oplog Condicion {$$ = new std::list<std::string*>;
															$$->push_back($1);
															$$->push_back($2);
															$$->push_back($3);
															$$->insert($$->end(),$4->begin(),$4->end());
															}															
|Simbolocomparacion Tipovarios {$$ = new std::list<std::string*>;
								$$->push_back($1);
								$$->push_back($2);
								}

Tipovarios: CARACTER {$$ = $1;}
|NUMERO {$$ = $1;}
|TEXTO {$$ = $1;}
|VERDADERO {$$ = $1;}
|FALSO {$$ = $1;}
|N_VAR {$$ = $1;}
;

Oplog: O {$$ = $1;}
|Y {$$ = $1;}

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
	std::list<std::string*>*p;
	//string st = "Prueba";
	//string* stptr = new string();
	//getline(st,*stptr);
	//p->push_back(stptr);
	//e.insert(p,8); e.actualizarPila(8);
	e.imprimir();
	
}
void yyerror(const char *s) {
	printf("Error de parsing: %s", s);
	exit(-1);
}
// Comandos que estoy corriendo:
// bison -d analisisSintactico.y
// flex merakiTokens.l
// g++ analisisSintactico.tab.c lex.yy.c -ll -o analisisS
