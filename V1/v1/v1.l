%option noyywrap

%%

[+-]?[0-9]+         { printf("broj: %s\n", yytext); }

0[xX][a-fA-F0-9]{1,4}	{ printf("heksa: %s\n", yytext); }

[+-]?[0-9]+\.[0-9]*		{ printf("realan broj: %s\n", yytext); }

[bB][rR][eE][aA][kK]		{ printf("break: %s\n", yytext); }

\/\/.*	{ printf("komentar: %s\n", yytext); }

"/*"(.|\n)*"*/"	{ printf("blok komentar: %s\n", yytext); }

[+-]?[0-9]+"F"	{ printf("%d°C\n", ((atoi(yytext)  -  32)  *  5/9)); }


%%

int main() {
  yylex();
}
