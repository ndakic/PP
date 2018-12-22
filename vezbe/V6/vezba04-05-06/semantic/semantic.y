%{
  #include <stdio.h>
  #include "defs.h"
  #include "symtab.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  int var_num = 0;
  int fun_idx = -1;
  int fcall_idx = -1;

  int postojiReturn = 0;
  int block;

  int poslednji;
  int poslednji_for;

  int nizKonstanti[20];
  int nizCount = 0;

  int prom;

  int t;
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token <i> _AROP
%token <i> _RELOP
%token _COMMA
%token _INC

%token _DO
%token _WHILE
%token _FOR

%token _SWITCH
%token _CASE
%token _DEFAULT
%token _COLON
%token _BREAK




%type <i> type num_exp exp literal
%type <i> function_call argument rel_exp

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : function_list
      {  
        int idx = lookup_symbol("main", FUN);
        if(idx == -1)
          err("undefined reference to 'main'");
        else 
          if(get_type(idx) != INT)
            warn("return type of 'main' is not int");
      }
  ;

function_list
  : function
  | function_list function
  ;

function
  : type _ID
      {
        fun_idx = lookup_symbol($2, FUN);
        if(fun_idx == -1)
          fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
        else 
          err("redefinition of function '%s'", $2);
      }
    _LPAREN parameter _RPAREN body
      { 
        // print_symtab();
        clear_symbols(fun_idx + 1);
        // print_symtab();
        var_num = 0;

        if(get_type(fun_idx) != VOID){
          if(postojiReturn == 0){
            warning("Funkcija ocekuje neku povratnu vrednost");
            }

        }

        postojiReturn = 0;

      }
  ;

type
  : _TYPE
      { $$ = $1; }
  ;

parameter
  : /* empty */
      { set_atr1(fun_idx, 0); }

  | type _ID
      {
        if($1 == VOID)
          err("parametar ne moze biti tipa void");

        insert_symbol($2, PAR, $1, 1, NO_ATR);
        set_atr1(fun_idx, 1);
        set_atr2(fun_idx, $1);
      }
  ;

body
  : _LBRACKET variable_list statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
   : vars _SEMICOLON 
   ;

vars
   :  type {t = $1;} _ID      
     {
        if($1 == VOID)
          err("varijabla ne moze biti tipa void");

        int postoji = lookup_symbol($3, VAR|PAR);
    
        if((postoji != -1) && (get_atr2(postoji) == block))
           err("redefinition1 of '%s'", $3);
        else 
          insert_symbol($3, VAR, t, ++var_num, block);
      }
   |  vars _COMMA _ID
      {
        int postoji = lookup_symbol($3, VAR|PAR);
    
        if((postoji != -1) && (get_atr2(postoji) == block))
           err("redefinition1 of '%s'", $3);
        else 
          insert_symbol($3, VAR, t, ++var_num, block);
      }
   ;

// =======================================================================

do_statement
   :  _DO statement _WHILE _LPAREN _ID _RELOP literal _RPAREN _SEMICOLON 
     {  
        int index = -1;
        if((index = lookup_symbol($5, (VAR|PAR))) == -1)
           err("Greska, promenjiva nije definisana!'%s'", $5);   

        if(get_type(index) != get_type($7))
           err("Greska, tipovi nisu isti!'%s'", $5);  
      }
   ;


inc_statement
   :  _ID _INC _SEMICOLON
   {
        if(lookup_symbol($1, VAR|PAR) == -1)
           err("Greska!'%s'", $1);   
      }
   ;


for_statement
  : _FOR _LPAREN _TYPE _ID _ASSIGN literal _SEMICOLON { insert_symbol($4, VAR, $3, ++var_num, ++block); poslednji_for = get_last_element(); } rel_exp _SEMICOLON _ID _INC _RPAREN statement 
    {

      int index1 = lookup_symbol($4, VAR);

      if(get_type(index1) != get_type($6))
        err("Moraju biti istog tipa!");

      int index2 = lookup_symbol($11, VAR);

      if(index1 != index2)
        err("Moraju biti iste promenjive!");

      block--; 
      clear_symbols(poslednji_for);

    }
  ;


default_statement
  : /* empty */
  | _DEFAULT _COLON case_body
  ;

break_statement
  : /* empty */
  | _BREAK _SEMICOLON
  ;

case_list
  : case_
  | case_list case_
  ;

case_
   : _CASE literal {
     
      // char lit_str[12];
      // sprintf(lit_str, "%d", $2);

      int i = 0;

      while(i < nizCount){

        if(nizKonstanti[i] == $2)
          err("Case vec postoji!");

        i++;
      }

      nizKonstanti[nizCount] = $2;
      nizCount++;

      if(get_type(prom) != get_type($2))
        err("Nisu istog tipa!");

   }
   _COLON case_body break_statement 

   ;

case_body
  : compound_statement 
  | assignment_statement
  ;

switch_statement
  : _SWITCH _LPAREN _ID 
    { 

      prom = lookup_symbol($3, VAR);
      if(prom == -1)
        err("Promenjiva nije definisana!");

    }

    _RPAREN _LBRACKET case_list default_statement _RBRACKET
  ;


// ======================================================================

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | inc_statement
  | do_statement
  | for_statement
  | switch_statement
  ;

compound_statement
  : _LBRACKET {block++; poslednji = get_last_element(); } variable_list statement_list _RBRACKET { block--; clear_symbols(poslednji + 1);}
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == -1)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($3))
            err("incompatible types in assignment");
      }
  ;

num_exp
  : exp
  | num_exp _AROP exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: arithmetic operation");
      }
  ;

exp
  : literal
  | _ID
      {
        $$ = lookup_symbol($1, VAR|PAR);
        if($$ == -1)
          err("'%s' undeclared", $1);
      }
  | function_call
  | _LPAREN num_exp _RPAREN
      { $$ = $2; }
  ;

literal
  : _INT_NUMBER
      { $$ = insert_literal($1, INT); }

  | _UINT_NUMBER
      { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
      {
        fcall_idx = lookup_symbol($1, FUN);
        if(fcall_idx == -1)
          err("'%s' is not a function", $1);
      }
    _LPAREN argument _RPAREN
      {
        if(get_atr1(fcall_idx) != $4)
          err("wrong number of args to function '%s'", 
              get_name(fcall_idx));
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
      }
  ;

argument
  : /* empty */
    { $$ = 0; }

  | num_exp
    { 
      if(get_atr2(fcall_idx) != get_type($1))
        err("incompatible type for argument in '%s'",
            get_name(fcall_idx));
      $$ = 1;
    }
  ;

if_statement
  : if_part %prec ONLY_IF
  | if_part _ELSE statement
  ;

if_part
  : _IF _LPAREN rel_exp _RPAREN statement
  ;

rel_exp
  : num_exp _RELOP num_exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: relational operator");
      }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
      {

        if(get_type(fun_idx) == VOID)
          err("Void funckija ne sme da ima return");


        if(get_type(fun_idx) != get_type($2))
          err("incompatible types in return");

        postojiReturn = 1;
      }
  | _RETURN _SEMICOLON 
    {

      warning("funckija ocekuje da joj se vrati neka vrednost!");
      postojiReturn = 2;

    }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();

  synerr = yyparse();

  clear_symtab();
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count)
    printf("\n%d error(s).\n", error_count);

  if(synerr)
    return -1;
  else
    return error_count;
}

