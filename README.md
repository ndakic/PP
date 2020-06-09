# Translators

##### The task of program translators is to translate programs written in one (source) programming language into programs of the same meaning that are written in another (target) programming language.

## The phases of a compiler are:
- Lexical analysis
- Syntax analysis
- Semantic analysis
- Code generation
- Optimization

### Lexical analysis
- Symbol recognition (words).
- Detection of wrong symbols -> lexical errors.
- The scanner picks up character by character and tries to recognize the symbol.
- Example: use of illegal characters e.g. cou#nt

### Syntax analysis
- Recognition of statements (sentences).
- Detection of false statements. Syntax errors.
- The task of the parser is to check whether the input string of symbols is in accordance with the grammar.
- Example: Omitting the open parentheses after the if statement.


### Semantic analysis
- Recognizing the meaning of a statement (sentence).
- Detection of semantically incorrect statements -> semantic error
- Example: using an undefined variable.
