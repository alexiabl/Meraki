/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.
 */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     RESTA = 258,
     MULTIPLICACION = 259,
     DIVISION = 260,
     N_VAR = 261,
     NUMERO = 262,
     SUMA = 263,
     IGUAL = 264,
     FIN = 265
   };
#endif
/* Tokens.  */
#define RESTA 258
#define MULTIPLICACION 259
#define DIVISION 260
#define N_VAR 261
#define NUMERO 262
#define SUMA 263
#define IGUAL 264
#define FIN 265




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 11 "analisisSintactico.y"
{
    char resta;
    char *nombre_var;
    char mult;
    char division;
    int entero;
    char suma;
	char igual;
	char *fin;
}
/* Line 1529 of yacc.c.  */
#line 80 "analisisSintactico.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

