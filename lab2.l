%{
#include <stdio.h>
#include <string.h>

#define MAX_SYMBOLS 1000
#define MAX_PIF_SIZE 1000
struct SymbolEntry {
    char name[50];
    int type;
};
struct PIFEntry {
    char type[50];
    int index;
};
struct SymbolEntry symbolTable[MAX_SYMBOLS];
struct PIFEntry pif[MAX_PIF_SIZE];
int symbolTableSize = 0;
int pifSize = 0;

void printSymbolTableAndPIF() {
    printf("Symbol Table:\n");
    for (int i = 0; i < symbolTableSize; i++) {
        printf("(%s  %d)\n", symbolTable[i].name, symbolTable[i].type);
    }

    printf("PIF:\n");
    for (int i = 0; i < pifSize; i++) {
        printf("(%s  %d)\n", pif[i].type, pif[i].index);
    }
}
%}
%option noyywrap
DIGIT   [0-9]
NONZERO_DIGIT   [1-9]
LETTER  [a-zA-Z]
SYMBOL [;,?!:._ \{\}\[\]\(\)\'\"]
OPERATOR [+-=*></]
ID      [a-z][a-z0-9]*

%%
{NONZERO_DIGIT}{DIGIT}*    {
    strcpy(pif[pifSize].type, "const");
    pif[pifSize].index = 0;
    pifSize++;
    printf("Token: Integer, Value: %s\n", yytext);
    printSymbolTableAndPIF();
}
\'({LETTER}|{DIGIT}|{SYMBOL}|{OPERATOR})\' {
    strcpy(pif[pifSize].type, "const");
    pif[pifSize].index = 0;
    pifSize++;
    printf("Token: Character, Value: %s\n", yytext);
    printSymbolTableAndPIF();
}
\"({LETTER}|{DIGIT}|{SYMBOL}|{OPERATOR})*\" {
    strcpy(pif[pifSize].type, "const");
    pif[pifSize].index = 0;
    pifSize++;
    printf("Token: String, Value: %s\n", yytext);
    printSymbolTableAndPIF();
}
"if"|"else"|"integer"|"character"|"do"|"while"|"const"|"list"|"read"|"write" {
    strcpy(pif[pifSize].type, yytext);
    pif[pifSize].index = 0;
    pifSize++;
    printf("Token: Keyword, Value: %s\n", yytext);
    printSymbolTableAndPIF();
}
{OPERATOR}|{SYMBOL} {
    strcpy(pif[pifSize].type, yytext);
    pif[pifSize].index = 0;
    pifSize++;
    printf("Token: Operator or symbol, Value: %s\n", yytext);
    printSymbolTableAndPIF();
}
{ID} {
    strcpy(symbolTable[symbolTableSize].name, yytext);
    symbolTable[symbolTableSize].type = symbolTableSize;
    int has = -1;
    for(int i = 0; i<symbolTableSize; i++){
        if(strcmp(symbolTable[i].name, yytext) == 0){
            has = i;
        }
    }

    if(has == -1){
        has = symbolTableSize;
        symbolTableSize++;
    }

    strcpy(pif[pifSize].type, "id");
    pif[pifSize].index = has;
    pifSize++;
    printf("Token: Identifier, Value: %s\n", yytext);
    printSymbolTableAndPIF();
}

"{"[^}\n]*"}" {}
[ \t\n]+ {}
. {}

%%

int main(argc, argv)
int argc;
char **argv;
{
    yylex();
    return 0;
}
