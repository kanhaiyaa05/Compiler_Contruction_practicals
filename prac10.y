%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;
char* newTemp();
int yyerror(char *s);
int yylex(void);
%}

%union {
    int num;
    char str[10];
}

%token <num> NUMBER
%type  <str> E T F

%%

S : E        { printf("\nFinal Result stored in: %s\n", $1); }
  ;

E : E '+' T  { 
                char *temp = newTemp(); 
                printf("%s = %s + %s\n", temp, $1, $3); 
                strcpy($$, temp);
             }
  | E '-' T  { 
                char *temp = newTemp(); 
                printf("%s = %s - %s\n", temp, $1, $3); 
                strcpy($$, temp);
             }
  | T        { strcpy($$, $1); }
  ;

T : T '*' F  { 
                char *temp = newTemp(); 
                printf("%s = %s * %s\n", temp, $1, $3); 
                strcpy($$, temp);
             }
  | T '/' F  { 
                char *temp = newTemp(); 
                printf("%s = %s / %s\n", temp, $1, $3); 
                strcpy($$, temp);
             }
  | F        { strcpy($$, $1); }
  ;

F : '(' E ')' { strcpy($$, $2); }
  | NUMBER    { sprintf($$, "%d", $1); }
  ;

%%

char* newTemp() {
    static char temp[10];
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter an arithmetic expression(Ctrl+D to exit and display the output):\n");
    yyparse();
    return 0;
}

