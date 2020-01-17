%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "synjaz1.tab.h"

int InsererTS(char *entitee);
int RechercherTS(char *entitee);

   int ligne=1;
   int col=0;	

typedef struct {char nom[20]; char type[20];} TypeTS;
TypeTS TS[100];
int TailleTS = 0;

%}


idf [A-Z][a-zA-Z0-9]*
cste_entier [+-]?[0-9]+
cste_reel [0-9]+"."[0-9]+
cste_char ('[a-zA-Z]')
cste_string ("[a-zA-Z]*")
cste_bool [0-1]

%%
"PROGRAM"     {col=col+yyleng;	return	key_program;}  
"BEGIN"       {col=col+yyleng;	return	key_begin;}  
"END" 	      {col=col+yyleng;	return	key_end;}  
"var"	      {col=col+yyleng;	return	key_var;}  
"INTEGER"     {col=col+yyleng;	return	key_integer;}  
"FLOAT"	      {col=col+yyleng;	return	key_float;}  
"CHAR"	      {col=col+yyleng;	return	key_char;}  
"STRING"      {col=col+yyleng;	return	key_string;} 
"let"	      {col=col+yyleng;	return	key_let;}  
"RETURN"      {col=col+yyleng;	return	key_return;}  
"IF"	      {col=col+yyleng;	return	key_if;}  
"ELSE"	      {col=col+yyleng;	return	key_else;}  
"END_IF"      {col=col+yyleng;	return	key_end_if;}  
"FOR"	      {col=col+yyleng;	return	key_for;}  
"END_FOR"     {col=col+yyleng;	return	key_end_for;}  
"SHOW"	      {col=col+yyleng;	return	key_show;}  
"GET"	      {col=col+yyleng;	return	key_get;}  
"+"	      {col=col+yyleng;	return	key_addition;}  
"-"	      {col=col+yyleng;	return	key_soustraction;}  
":"	      {col=col+yyleng;	return	key_deux_points;}  
"="	      {col=col+yyleng;	return	key_affectation;}  
"."	      {col=col+yyleng;	return 	key_point;}  
"*"	      {col=col+yyleng;	return	key_multiplication;}  
"/"	      {col=col+yyleng;	return	key_division;}  
"//"	      {col=col+yyleng;	return	key_commentaire;}  
">>"	      {col=col+yyleng;	return	key_superieur;}  
"<<"	      {col=col+yyleng;	return	key_inferieur;}	  
"=="	      {col=col+yyleng;	return	key_egal;} 
">>="	      {col=col+yyleng;	return	key_supegal;}	  
"<<="	      {col=col+yyleng;	return	key_infegal;}  
"<<>>"	      {col=col+yyleng;	return	key_different;}  
"£"	      {col=col+yyleng;	return	key_fin;}  
"||"	      {col=col+yyleng;	return	key_pipe;}  
"("	      {col=col+yyleng;	return	key_parouv;}  
")"	      {col=col+yyleng;	return	key_parfer;}  
"'"	      {col=col+yyleng;	return	key_apostrophe;}  
" " 	      {col=col+yyleng;}  
"\""	      {col=col+yyleng;	return	key_guillemets;} 
"@" 	      {col=col+yyleng;	return	key_signe;} 
"{"	      {col=col+yyleng;	return	key_accouv;}  
"}"	      {col=col+yyleng;	return	key_accfer;}  
"["	      {col=col+yyleng;	return	key_croouv;} 
"]"	      {col=col+yyleng;	return	key_crofer;}  		 
"\n"          {ligne++;col=0;}	  
"\t"	      {col=col+8;}  	
{idf}         {col=col+yyleng;} {if(yyleng>7){printf("ERREUR lexicale, Ligne: %d ,Col: %d, Entite: %s\n",ligne,col,yytext);} else if (RechercherTS(yytext)==0) InsererTS(yytext); return idf;}
{cste_entier} {col=col+yyleng;}	{ if(atoi(yytext)>32768 || atoi(yytext)>+32768 
|| atoi(yytext)<-32768)
printf("\nERREUR lexicale!,Ligne:%d,col:%d,Entite:%s\n",ligne,col,yytext); else if  (RechercherTS(yytext)==0) {InsererTS(yytext);}return cste_entier;} 
{cste_reel}   {col=col+yyleng;} { if (RechercherTS(yytext)==0){InsererTS(yytext);} return cste_reel;}
{cste_char}   {col=col+yyleng;} { if (RechercherTS(yytext)==0) {InsererTS(yytext);} return cste_char;}
{cste_string} {col=col+yyleng;}	{ if (RechercherTS(yytext)==0) {InsererTS(yytext);} return cste_string;}
.	      {col=col+yyleng;} {printf("\nERREUR lexicale!, Ligne: %d,Col: %d,Entite:  %s\n",ligne,col,yytext);}
%%


int InsererTS(char *entitee)
{ 
	strcpy(TS[TailleTS].nom, entitee); TailleTS++;
}

int RechercherTS(char *entitee)
{ 
	int i;
	for(i=0;i<TailleTS; i++) {if (!strcmp(TS[i].nom, entitee)) return 1;}
	return 0;
}

