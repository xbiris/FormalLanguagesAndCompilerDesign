%{
#include <stdio.h>
#include <stdlib.h>
%}

%token VARS START STOP CHARACTER INTEGER LIST READ WRITE IF ELSE WHILE
%token LT LEQ EQ NEQ GEQ GT ASSIGN IDENTIFIER INTCONST CHARACTERCONST STRINGCONST

%%

program : VARS decllist cmpdstmt
        ;

decllist : declaration
         | declaration decllist
         ;

declaration : type IDENTIFIER ';'
            ;

type : CHARACTER
     | INTEGER
     | LIST '[' INTCONST ']' type
     ;

cmpdstmt : START stmtlist STOP
         ;

stmtlist : stmt
         | stmt stmtlist
         | '{' stmtlist '}'
         ;

stmt : assignstmt ';'
     | iostmt ';'
     | cmpdstmt
     | ifstmt
     | whilestmt
     ;

assignstmt : IDENTIFIER ASSIGN expression
           ;

expression : expression '+' term
           | expression '-' term
           | term
           ;

term : term '*' factor
     | term '/' factor
     | factor
     ;

factor : '(' expression ')'
       | IDENTIFIER
       | INTCONST
       ;

iostmt : READ '(' IDENTIFIER ')'
       | WRITE '(' IDENTIFIER ')'
       ;

ifstmt : IF '(' condition ')' '{' stmtlist '}'
       | IF '(' condition ')' '{' stmtlist '}' ELSE '{' stmtlist '}'
       ;

whilestmt : WHILE '(' condition ')' '{' stmtlist '}'
          ;

condition : expression relation expression
          ;

relation : LT
         | LEQ
         | EQ
         | NEQ
         | GEQ
         | GT
         ;

%%

extern FILE *yyin;
extern int yylineno;

int main(int argc, char **argv)
{
    FILE *myfile = fopen(argv[1], "r");

    if (!myfile) {
        printf("I can't open %s!\n", argv[1]);
        return -1;
    }

    yyin = myfile;
    yyparse();

    return 0;
}


void yyerror(char *s) {
   fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}
