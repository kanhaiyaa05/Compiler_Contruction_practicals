%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

"for"           { return FOR; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMICOLON; }
","             { return COMMA; }
"="             { return ASSIGN; }

"<="            { return LE; }
">="            { return GE; }
"=="            { return EQ; }
"!="            { return NE; }
"<"             { return LT; }
">"             { return GT; }

"++"            { return INC; }
"--"            { return DEC; }

"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MUL; }
"/"             { return DIV; }

\"[^\"]*\"      { yylval.str = strdup(yytext); return STRING; }   /* <-- fixed */

[a-zA-Z_][a-zA-Z0-9_]*   { return IDENTIFIER; }
[0-9]+                   { return NUMBER; }

[ \t\r\n]+               ;   /* Ignore whitespace */

. { 
    printf("Invalid Character: %s\n", yytext);
}

%%

int yywrap() { return 0; }
