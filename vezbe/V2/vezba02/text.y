%{
	#include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;

  int upitneRecenice = 0;
  int uzvicneRecenice = 0;
  int izjavneRecenice = 0;

  int pasusi = 0;

%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token  _Q
%token  _U
%token  _COMMA
%token  _NEWLINE

%%

text 
  :  /* empty text */
  |  text pasus _NEWLINE { pasusi++; }
  ;

//  Pasus je niz od jedne ili više rečenica.

pasus
  : sentence 
  | pasus sentence
  ;
          
sentence 
  :  _CAPITAL_WORD words _DOT { izjavneRecenice++;}
  |  _CAPITAL_WORD words _Q { upitneRecenice++;}
  |  _CAPITAL_WORD words _U { uzvicneRecenice++;}
  ;

words 
  : /* empty */
  | words _COMMA _WORD
  | words _CAPITAL_WORD
  | words _WORD
  ;


%%

int main() {
  yyparse();
  printf("Upitne recenice : %d\n", upitneRecenice);
  printf("Uzvicnerecenice : %d\n", uzvicneRecenice);
  printf("Izjavne recenice : %d\n", izjavneRecenice);
  printf("Pasusi : %d\n", pasusi);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

