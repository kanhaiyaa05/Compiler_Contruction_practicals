%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
[0-9]+(\.[0-9]+)?    { yylval.dval = atof(yytext); return NUMBER; }
[+\-*/^()]           { return yytext[0]; }
[ \t]                ;   /* Ignore whitespace */
\n                   { return '\n'; }
.                    { printf("Invalid character: %s\n", yytext); }
%%

int yywrap(void){
    return 1;
}

