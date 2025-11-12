%{
#include "prac9.tab.h"
#include <string.h>
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

[0-9]+          { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return IDENTIFIER; }
\"[^\"]*\"      { yylval.str = strdup(yytext); return STRING; }

[ \t\n\r]+      { /* ignore whitespace */ }
.               { printf("❌ Invalid character: %s\n", yytext); }

%%
int yywrap() { return 1; }

