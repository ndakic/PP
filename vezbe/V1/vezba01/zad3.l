%option noyywrap

%%



[+-]?[0-9]+"."[0-9]*[+-]?e[0-9] {printf("realan broj: %s\n", yytext);}
\n
.


%%

int main() {
  yylex();
}
