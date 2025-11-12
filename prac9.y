%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(char *s);
%}

%union {
    char *str;
}

%token FOR LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA ASSIGN
%token LE GE EQ NE LT GT INC DEC PLUS MINUS MUL DIV
%token IDENTIFIER NUMBER
%token <str> STRING

%expect 1

%%
program:
    FOR_LOOP
    ;

FOR_LOOP:
    FOR LPAREN INIT_EXPR SEMICOLON CONDITION SEMICOLON INCR_EXPR RPAREN LBRACE STATEMENTS RBRACE
    {
        printf("\n✅ Valid for loop structure detected.\n");
    }
    ;

INIT_EXPR:
    IDENTIFIER ASSIGN NUMBER
    | IDENTIFIER ASSIGN IDENTIFIER
    ;

CONDITION:
    IDENTIFIER RELOP NUMBER
    | IDENTIFIER RELOP IDENTIFIER
    ;

RELOP:
    LT | GT | LE | GE | EQ | NE
    ;

INCR_EXPR:
    IDENTIFIER INC
    | IDENTIFIER DEC
    | IDENTIFIER ASSIGN IDENTIFIER PLUS NUMBER
    | IDENTIFIER ASSIGN IDENTIFIER MINUS NUMBER
    ;

STATEMENTS:
    /* empty body allowed */
    | STATEMENT
    | STATEMENTS STATEMENT
    ;

STATEMENT:
    ASSIGNMENT SEMICOLON
    | FUNCTION_CALL SEMICOLON
    ;

ASSIGNMENT:
    IDENTIFIER ASSIGN IDENTIFIER PLUS NUMBER
    | IDENTIFIER ASSIGN IDENTIFIER MINUS NUMBER
    | IDENTIFIER ASSIGN NUMBER
    ;

FUNCTION_CALL:
    IDENTIFIER LPAREN ARGS RPAREN
    ;

ARGS:
    /* empty */
    | ARG_LIST
    ;

ARG_LIST:
    ARG
    | ARG_LIST COMMA ARG
    ;

ARG:
    IDENTIFIER
    | NUMBER
    | STRING
    ;

%%

int main() {
    printf("Enter a for loop:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("❌ Error: %s\n", s);
    return 0;
}
