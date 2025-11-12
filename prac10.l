%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%%
[0-9]+      { yylval.num = atoi(yytext); return NUMBER; }   /* ✅ fix here */
[-+*/()]    { return yytext[0]; }
[\t\n]      ;   /* skip whitespace */
.           { printf("Invalid character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

