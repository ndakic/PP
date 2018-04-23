%option noyywrap

%%


0[xX][0-9a-fA-F]{1,4}  {printf("heksa: %s\n", yytext);}
\n
.


%%

int main() {
  yylex();
}
