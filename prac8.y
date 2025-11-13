%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);
%}

/* Define the semantic value type */
%union {
    double dval;
}

/* Declare tokens and their types */
%token <dval> NUMBER
%type  <dval> expr

/* Operator precedence and associativity */
%left '+' '-'
%left '*' '/'
%right '^'
%right UMINUS

%%
program:
        /* allow multiple expressions */
        program expr '\n'    { printf("Result: %f\n", $2); }
        | /* empty */
        ;

expr:
      NUMBER                 { $$ = $1; }
    | expr '+' expr          { $$ = $1 + $3; }
    | expr '-' expr          { $$ = $1 - $3; }
    | expr '*' expr          { $$ = $1 * $3; }
    | expr '/' expr          {
                                if ($3 == 0) {
                                    yyerror("Division by zero");
                                    $$ = 0;
                                } else {
                                    $$ = $1 / $3;
                                }
                             }
    | expr '^' expr          { $$ = pow($1, $3); }
    | '-' expr %prec UMINUS  { $$ = -$2; }
    | '(' expr ')'           { $$ = $2; }
    ;
%%

int main(void){
    printf("Enter infix expressions (one per line):\n");
    yyparse();
    return 0;
}

void yyerror(const char *s){
    fprintf(stderr, "Error: %s\n", s);
}
