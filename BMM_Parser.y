%{
/* Definition section */
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
#include"lex.yy.c"

int flag =0 ;
FILE *yyin;

void yyerror(const char *s);
int yylex();
int yywrap();



%}
%union {
    int num;
    char* str;
}
 

%token VAR_NAME
%token NUM STR 
%token LPAREN RPAREN EXPONENT MINUS MULTIPLY DIVIDE PLUS
%token LT LTEQ EQ GTEQ GT NEQ
%token NOT AND OR XOR 
%token END
%token EOL
%token REM LET          
%token PRINT          
%token IF            
%token THEN           
%token ELSE                   
%token GOTO          
%token GOSUB          
%token RETURN         
%token DATA         
%token DEF           
%token DIM           
%token TO     LINENUMBER        
%token STEP  INPUT FN NEXT FOR STOP SEMICOLON COMMA


/* Operator Precedence */
%left XOR
%left OR
%left AND
%left LT LTEQ EQ NEQ GT GTEQ
%left PLUS MINUS
%left MULTIPLY DIVIDE
%right NEGATE
%left EXPONENT

%start program


/* Rule Section */
%%
program         : statement_list END 
                ;

statement_list  : 
                |  statement_list statement
                ;

statement       : line_number statement_body EOL
                
                ;

line_number     : LINENUMBER 
                ;




statement_body  : REM VAR_NAME  {printf("These are comments line\n");}
                | LET variable EQ expr
                |  stop_statement { printf("Program execution halted.\n"); }
                | PRINT print_list   { printf("Print statement\n");}
                | INPUT var_list    {printf("Input statements\n");}
                | IF condition THEN line_number ELSE line_number   { printf("If condition statement\n");}
                | IF condition THEN line_number  { printf("If condition statements\n");}
                | GOTO line_number     { printf("GOTO Line\n");}
                |  GOSUB NUM       { printf("GOSUB line\n");}
                | for_loop
                | DATA datalist
                | DEF FN VAR_NAME EQ expr
                | DEF FN VAR_NAME LPAREN VAR_NAME RPAREN EQ expr
                | DIM dimlist
                |  RETURN
                ;

variable: VAR_NAME
        | VAR_NAME array_subscript
        ;

stop_statement: statement_body STOP | STOP ;

var_list        : VAR_NAME
                | VAR_NAME COMMA VAR_NAME
                ;

array_subscript: LPAREN NUM RPAREN
               | LPAREN NUM COMMA NUM RPAREN
               ;

print_list      : /* empty */        
                | print_item
                | print_list delimiter print_item
                ;

print_item      : expr      
                | STR        
                | SEMICOLON        
                ;

delimiter       : COMMA             
                | SEMICOLON        
                ;   


condition : expr LTEQ expr
          | expr LT expr
          | expr EQ expr
          | expr GT expr
          | expr GTEQ expr
          | expr NEQ expr

for_loop:
    | FOR VAR_NAME EQ expr TO expr
    | FOR VAR_NAME EQ expr TO expr STEP expr
    | NEXT VAR_NAME


datalist:
    expr
    | datalist COMMA expr
    ;

dimlist:
    VAR_NAME LPAREN NUM RPAREN
    | dimlist COMMA VAR_NAME LPAREN NUM RPAREN
    ;

expr : term
     | expr PLUS term
     | expr MINUS term
     ;

term : factor
     | term MULTIPLY factor
     | term DIVIDE factor
     ;

factor :
         primary
       | primary EXPONENT factor
       ;

primary : VAR_NAME
        | NUM
        | LPAREN expr RPAREN
        | MINUS primary
        | primary PLUS primary
        | primary MINUS primary
        | primary MULTIPLY primary
        | primary DIVIDE primary
        | primary EXPONENT primary
        | primary EQ primary
        | primary NEQ primary
        | primary LT primary
        | primary GT primary
        | primary LTEQ primary
        | primary GTEQ primary
        | primary AND primary
        | primary OR primary
        | primary XOR primary
        | NOT primary
        | FN VAR_NAME LPAREN expr RPAREN
        ;




%%

//driver code
int main()
{
yyin = fopen("input.txt","r");

yyparse();


if(flag==0){
printf("Code is Valid\n");

}
return 0;
}

void yyerror(const char* msg)
{
  fprintf(stderr , "Parse error :%s at line %d\n" , msg,yylineno);
  flag=1;
}
