%{
/* Definition section */
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "BMM_Parser.tab.h"

%}

%option yylineno

/* Rule Section */
%%
"NOT"       { return NOT; }
"AND"       { return AND; }
"OR"        { return OR; }
"XOR"       { return XOR; }
"REM"            { return REM; }
"INPUT"          { return INPUT; }
"LET"           { return LET; }
"PRINT"          { return PRINT; }
"IF"             { return IF; }
"THEN"           { return THEN; }
"FN"          {return FN ;}
"ELSE"           { return ELSE; }
"END"            { return END; }
"GOTO"           { return GOTO; }
"GOSUB"          { return GOSUB; }
"NEXT"           {return NEXT ;}
"RETURN"         { return RETURN; }
"DATA"           { return DATA; }
"DEF"            { return DEF; }
"DIM"           { return DIM; }
"TO"           { return TO; }
"STEP"           { return STEP; }
"FOR"         { return FOR ;}
"STOP"          { return STOP ;}
[1-9][0-9]{0,3}  {
                   yylval.num = atoi(yytext); 
                   return LINENUMBER;
                 }


[0-9]+    { yylval.num = atoi(yytext); return NUM; }

\"[^\"]*\" { yylval.str = strdup(yytext); return STR; }
[A-Z][0-9]?[%!#$]{1}    {yylval.str = strdup(yytext); return VAR_NAME; }

[ \t]+    { /* ignore whitespace */ ;}

"("         { return LPAREN; }
")"         { return RPAREN; }
"^"         { return EXPONENT; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }
"+"         { return PLUS; }
"="         { return EQ; }
"<>"        { return NEQ; }
"<"         { return LT; }
">"         { return GT; }
"<="        { return LTEQ; }
">="        { return GTEQ; }

\n             { return EOL; }

","        { return COMMA; }
";"        { return SEMICOLON; }

.              { printf("Invalid character: %s\n", yytext); }






%%

int yywrap()
{
return 1;
}
