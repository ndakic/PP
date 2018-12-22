%option noyywrap

%%

Z2. Napraviti skener koji prepoznaje single-line komentar (//) i izbacuje ga iz koda.
za domaći: rešiti prepoznavanje blok komentara (pogledati i rešenje u zbirci)

 {printf("rez: %s\n", yytext);}
\n
.


%%

int main() {
  yylex();
}


