To run this program 

Type these commands on command line or terminal:-

bison -v -d BMM1.y; flex BMM1.l ; gcc BMM1.tab.c ; ./a.exe

OR

flex BMM1.l
bison -v -d BMM1.y
gcc BMM1.tab.c
.\a.exe  
 
( This commands has to change accordingly if worked on linux environment like lex in place of flex and yacc in place of bison.)


In BMM_Scanner.l we have specified all the pattern matching rules for the lex.
 We have used flex to generate lexical analyser (or scanner) that can recognize source code for programming language B--.
In BMM_Parser.y we have defined all the grammar rules for yacc. 
We have used bison to generate a syntax analyser that can recognize source code of programming language  B--.

Commands to create our compiler a.exe for B-- language are:
bison -v -d BMM1.y          #create BMM.tab.h, BMM.tab.c
flex BMM1.l                 #create lex.yy.c
gcc BMM1.tab.c              #compiler

bison reads the grammar descriptions in BMM_Praser.y and generates a syntax analyser (parser) that includes the function yyparse, in file BMM.tab.c. 
Included in file BMM_Parser.y are token declarations. The -d option causes bison to generate definitions for tokens and place them in file BMM.tab.h. 
Flex reads the pattern descriptions in BMM_Scanner.l, includes file BMM.tab.h and generates a lexical analyser that includes function yylex in file lex.yy.c.
Finally the lexer and parser are compiled and linked together to create an executable file a.exe. 
From main we call yyparse to run the compiler. Function yyparse automatically calls yylex to obtain each token.

Input - There is two sample files in the folder. Copy it and paste it in input.txt file , whose instructions would be parsed.
 
Output - If there is any error , it will appear on console with some messages like Invalid character or synatx error.
         Otherwise , "code is valid" will be written.



Team_Members:

Khushboo Gupta (2021csb1105)
Niroopma Verma (2021csb1115)
