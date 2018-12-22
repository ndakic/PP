%option noyywrap

%%


[bB][rR][eE][aA][kK] {printf("rez: %s\n", yytext);}
\n
.


%%

int main() {
  yylex();
}

