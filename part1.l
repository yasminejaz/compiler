%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "syntaxique.tab.h" // Laison avec Bison
extern YYSTYPE yylval;

int ligne=1;
int col=0;	

typedef struct elt{
 char nom[20];
 char type[20];
}elt;

//DEclaration de la TS 
elt ts[100];
int indiceTS=-1;


void InsereTS(char* nom,char* type,int* indiceTS){

	strcpy(ts[*indiceTS].nom,nom);
	strcpy(ts[*indiceTS].type,type);

}


int rechercher(char* nom, char* type,int* indiceTS)
{
int i=0;

while(i<=*indiceTS)
{

if ( strcmp(nom,ts[i].nom) !=0)
 i++;

else
return 1;
}
//Fin TS sans avoir trouver l'entite'
// Inserer l'entite' dans la TS 

(*indiceTS)++;
InsereTS(nom,type,indiceTS);
return 0;
}



void afficherTS(int taille){
int i=0;

printf("Nom:\tType:\n");
 while (i<=taille){
  printf("%s\t%s\n",ts[i].nom,ts[i].type);
   i++;}
}



%}

idf [A-Z][a-zA-Z0-9]*
cste_entier [+-]?[0-9]+
cste_reel [0-9]+"."[0-9]+
cste_char ('[a-zA-Z]')
cste_string ("[a-zA-Z]*")

%%
"PROGRAM"     {col=col+yyleng;	return	key_program;}  
"BEGIN"       {col=col+yyleng;	return	key_begin;}  
"END" 	      {col=col+yyleng;	return	key_end;}  
"var"	      {col=col+yyleng;	return	key_var;}  
"INTEGER"     {col=col+yyleng;	return	key_integer;}  
"FLOAT"	      {col=col+yyleng;	return	key_float;}  
"CHAR"	      {col=col+yyleng;	return	key_char;}  
"STRING"      {col=col+yyleng;	return	key_string;} 
"CONST"	      {col=col+yyleng;	return	key_const;}  
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
"||"	      {col=col+yyleng;	return	key_barre;}  
"("	      {col=col+yyleng;	return	key_parouv;}  
")"	      {col=col+yyleng;	return	key_parfer;}  
"'"	      {col=col+yyleng;	return	key_apostrophe;}  
" " 	      {col=col+yyleng;	return	key_blanc;}  
"\""	      {col=col+yyleng;	return	key_guillemets;}  
"{"	      {col=col+yyleng;	return	key_accouv;}  
"}"	      {col=col+yyleng;	return	key_accfer;}  
"\n"          {ligne++;col=0;	return	key_saut_de_ligne;}  
"\t"	      {col=col+8;	return	key_tabulation;}  	
{idf}         {col=col+yyleng;} {if(yyleng>7){printf("ERREUR lexicale, Ligne: %d ,Col: %d, Entite: %s\n",ligne,col,yytext);} else rechercher(yytext,"Idf",&indiceTS); return idf}
{cste_entier} {col=col+yyleng;}	{ if(atoi(yytext)>32768 || atoi(yytext)>+32768 
|| atoi(yytext)<-32768)
printf("\nERREUR lexicale!,Ligne:%d,col:%d,Entite:%s\n",ligne,col,yytext); else rechercher(yytext,"Cste_Entier",&indiceTS); return cste_entier;} 
{cste_reel}   {col=col+yyleng;} {rechercher(yytext,"Cste_Reel",&indiceTS); return cste_reel;}
{cste_char}   {col=col+yyleng;} {rechercher(yytext,"Cste_Char",&indiceTS); return cste_char;}
{cste_string} {col=col+yyleng;}	{rechercher(yytext,"Cste_String",&indiceTS);}
.	      {col=col+yyleng;} {printf("\nERREUR lexicale!, Ligne: %d,Col: %d,Entite:  %s\n",ligne,col,yytext); return cste_string;} 
%%
/*
int main(){
	elt TS[100];
	yyin=fopen("test1.txt","r");
	yylex();
	afficherTS(indiceTS);
}
*/
int yywrap()
{
return 0 ;
}
