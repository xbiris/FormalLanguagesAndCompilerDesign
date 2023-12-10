%{
#include "ss.tab.h"
#include <stdlib.h>
%}

%option yylineno
%%

"VARS"               { return VARS; }
"START"              { return START; }
"STOP"               { return STOP; }
"character"          { return CHARACTER; }
"integer"            { return INTEGER; }
"list"               { return LIST; }
"read"               { return READ; }
"write"              { return WRITE; }
"if"                 { return IF; }
"else"               { return ELSE; }
"while"              { return WHILE; }
[a-zA-Z][a-zA-Z0-9]*  { yylval = strdup(yytext); return IDENTIFIER; }
"0"                  { yylval = atoi(yytext); return INTCONST; }
[1-9][0-9]*          { yylval = atoi(yytext); return INTCONST; }
"<"                  { return LT; }
"<="                 { return LEQ; }
"=="                 { return EQ; }
"!="                 { return NEQ; }
">="                 { return GEQ; }
">"                  { return GT; }
"="                  { return ASSIGN; }
"+"                  { return '+'; }
"-"                  { return '-'; }
"*"                  { return '*'; }
"/"                  { return '/'; }
"("                  { return '('; }
")"                  { return ')'; }
";"                  { return ';'; }
","                  { return ','; }
"["                  { return '['; }
"]"                  { return ']'; }
"{"                  { return '{'; }
"}"                  { return '}'; }
[ \t\n]              { }
.                    { printf("Unexpected character: %s\n", yytext); exit(1); }

%%
