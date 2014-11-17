%option noyywrap

%{
	#include <stdbool.h>
	#include <stdio.h>
	
	#include "parser.tab.h"
%}

%x comment

%%

type			return SYM_TYPE;


"&&"                    return SYM_AMPAMP;
"||"                    return SYM_PPPP;

"=="                    return SYM_EQEQ;
">="                    return SYM_GTEQ;
"<="                    return SYM_LTEQ;
"!="                    return SYM_BANGEQ;

"<<"                    return SYM_LTLT;
">>"                    return SYM_GTGT;

"++"                    return SYM_PLUSPLUS;
"--"                    return SYM_DASHDASH;

[a-zA-Z_][a-zA-Z0-9_]*  yylval = SExString(yytext); return IDENTIFIER;

[1-9][0-9]*             yylval = SExString(yytext); return DECIMAL;
0[0-7]*                 yylval = SExString(yytext); return OCTAL;
0[xX][0-9a-fA-F]+       yylval = SExString(yytext); return HEXADECIMAL;
[0-9][0-9a-zA-Z]+       fprintf(stderr, "Invalid numeric constant\n"); exit(1);

\"\"                    yylval = SExString(""); return STRING;
\"([^\"\\]|(\\.))*\"    yylval = SExString(UnescapeString(yytext)); return STRING;
\'([^\'\\]|(\\.))*\'    yylval = SExString(UnescapeString(yytext)); return CHAR;

"//"[^\n]*              /* Ignore comment. */

"/*"                    BEGIN(comment);
<comment>[^*]*          /* eat anything that's not a '*' */
<comment>"*"+[^*/]*     /* eat up '*'s not followed by '/'s */
<comment>"*"+"/"        BEGIN(INITIAL);

[:space:]               /* Ignore space. */

[\)\}\]]                return (unsigned)*yytext;
[\(\{\[,:;\+\*\/\%\-\.\=\<\>\@\&\|!\?] return (unsigned)*yytext;

.                       fprintf(stderr, "Unexpected character: '%s'\n", yytext); exit(1);
