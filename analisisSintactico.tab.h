/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

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
     SI = 265,
     SINO = 266,
     MIENTRAS = 267,
     HAGA = 268,
     DESDE = 269,
     HASTA = 270,
     DEVUELVA = 271,
     IMPRIMA = 272,
     VERDADERO = 273,
     FALSO = 274,
     SIGUAL = 275,
     SMAYOR = 276,
     SMENOR = 277,
     SMAYORIGUAL = 278,
     SMENORIGUAL = 279,
     DIFERENTE = 280,
     PUNTO = 281,
     PUNTOCOMA = 282,
     PI = 283,
     PF = 284,
     LLAVEI = 285,
     LLAVEF = 286,
     COMENTARIO = 287,
     TIPONUM = 288,
     TIPOBOOL = 289,
     TIPOTEXTO = 290,
     TIPOCAR = 291,
     TEXTO = 292,
     CARACTER = 293,
     Y = 294,
     O = 295,
     MAIN = 296
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
#define SI 265
#define SINO 266
#define MIENTRAS 267
#define HAGA 268
#define DESDE 269
#define HASTA 270
#define DEVUELVA 271
#define IMPRIMA 272
#define VERDADERO 273
#define FALSO 274
#define SIGUAL 275
#define SMAYOR 276
#define SMENOR 277
#define SMAYORIGUAL 278
#define SMENORIGUAL 279
#define DIFERENTE 280
#define PUNTO 281
#define PUNTOCOMA 282
#define PI 283
#define PF 284
#define LLAVEI 285
#define LLAVEF 286
#define COMENTARIO 287
#define TIPONUM 288
#define TIPOBOOL 289
#define TIPOTEXTO 290
#define TIPOCAR 291
#define TEXTO 292
#define CARACTER 293
#define Y 294
#define O 295
#define MAIN 296




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 11 "analisisSintactico.y"
{
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
/* Line 1529 of yacc.c.  */
#line 179 "analisisSintactico.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

