# Language Specification

## 1. Language Definition

### 1.1 Alphabet
- Upper (A-Z) and lower-case letters (a-z) of the English alphabet
- Underline character '_'
- Decimal digits (0-9)

### 1.2 Lexicon

#### a. Special Symbols
- Operators: + - * / = < <= == >=
- Separators: [ ] { } ; space
- Reserved Words: read write list const do while if else integer character

#### b. Identifiers
- A sequence of letters and digits, with the first character being a letter.
- Rules:
  - identifier ::= letter {letter | digit}
  - letter ::= "a" | "b" | ... | "z" | "A" | "B" | ... | "Z"
  - digit ::= "0" | "1" | ... | "9"
  - nonzero_digit ::= "1" | ... | "9"

#### c. Constants
1. Integer:
   - intconst := +digits | -digits | digits
   - digits := digit | nonzero_digit {digit}
2. Character:
   - character := letter | digit | ',' | '?' | '!' | ':' | '.' | '(' | ')' | '{' | '}' | '[' | ']' | '%'
3. String:
   - constcharacter := "string"
   - string := character {character}

## 2. Syntax

### 2.1 Predefined Tokens
The words and predefined tokens are specified between double quotes (e.g., "VARS").

### 2.2 Syntactical Rules

- program ::= "VARS" decllist ";" cmpdstmt
- decllist ::= declaration | {declaration}
- declaration ::= type " " list_identifiers ";"
- list_identifiers ::= identifier { ',' identifier }
- type1 ::= "character" | "integer"
- arraydecl ::= "list" "[" integer "]" type1 identifier ";"
- type ::= type1 | arraydecl
- cmpdstmt ::= "START" stmtlist "STOP"
- stmtlist ::= stmt | stmt ";" stmtlist
- stmt ::= simplstmt | structstmt
- simplstmt ::= assignstmt | iostmt
- assignstmt ::= IDENTIFIER "=" expression
- expression ::= expression "+" term | expression "-" term | term
- term ::= term "*" factor | term "/" factor | factor
- factor ::= "(" expression ")" | IDENTIFIER
- iostmt ::= "read" | "write" "("identifier")"
- structstmt ::= cmpdstmt | ifstmt | whilestmt
- ifstmt ::= "if" "(" condition ")" "{" stmt "}" {"else" "{" stmt "}"}
- whilestmt ::= "while" "(" condition ")" "{" stmt "}"
- condition ::= expression RELATION expression
- RELATION ::= "<" | "<=" | "==" | "!=" | ">=" | ">"
