# Language Specification

## 1. Language Definition

### 1.1 Alphabet
- Upper (A-Z) and lower-case letters (a-z) of the English alphabet
- Underline character '_'
- Decimal digits (0-9)

### 1.2 Lexicon

#### a. Special symbols, representing
- operators + - * / % = < <= == >=
- separators [ ] { } ; space
- reserved words: read write list const do while if else integer character

#### b. Identifiers
- A sequence of letters and digits, such that the first character is a letter. The rule is:
  - identifier ::=  letter {letter | digit}
  - letter ::= "a" | "b" | ...| "z" | "A" | "B" | ...| "Z"
  - digit ::= "0" | "1" |...| "9"
  - nonzero_digit ::= | "1" |...| "9"

#### c. Constants
1. Integer - rule:
   - intconst := + digits | - digits | digits
   - digits := digit | nonzero_digit {digit}
2. Character
   - character := letter | digit | ',' | '?' | '!' | ':' | '.' | '(' | ')' | '{' | '}' | '[' | ']' | '%'
3. String
   - constcharacter := "string"
   - string := character {character}
   - character := letter | digit | ',' | '?' | '!' | ':' | '.' | '(' | ')' | '{' | '}' | '[' | ']' | '%'

## 2. Syntax

### 2.1 Predefined Tokens
- The words - predefined tokens are specified between " and ".

### 2.2 Syntactical Rules
- `program ::= "VARS" decllist ";" cmpdstmt "."`
- `decllist ::= declaration | {declaration}`
- `declaration ::= type " " list_identifiers ";"`
- `list_identifiers ::= identifier { ',' identifier }`
- `type1 ::= "char" | "integer"`
- `arraydecl ::= "list" "[" nr "]" type1 identifier ";"`
- `type ::= type1 | arraydecl`
- `cmpdstmt ::= "START" stmtlist "STOP"`
- `stmtlist ::= stmt | stmt ";" stmtlist`
- `stmt ::= simplstmt | structstmt`
- `simplstmt ::= assignstmt | iostmt`
- `assignstmt ::= IDENTIFIER "=" expression`
- `expression ::= expression "+" term | expression "-" term | term`
- `term ::= term "*" factor | term "/" factor | term "%" factor | factor`
- `factor ::= "(" expression ")" | IDENTIFIER`
- `iostmt ::= "read" | "write" "(" identifier ")"`
- `structstmt ::= cmpdstmt | ifstmt | whilestmt`
- `ifstmt ::= "if" "(" condition ")" "{" stmt "}" { "else" "{" stmt "}" }`
- `whilestmt ::= "while" "(" condition ")" "{" stmt "}"`
- `condition ::= expression RELATION expression`
- `RELATION ::= "<" | "<=" | "==" | "!=" | ">=" | ">"`
