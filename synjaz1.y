%{
#include<stdio.h>
#include<stdlib.h>
extern FILE* yyin;

extern int ligne;
extern int col;

typedef struct {char nom[20]; char type[20];} TypeTS;
extern TypeTS TS[100];
extern int TailleTS;


int yylex();
int InsererTS(char *entitee);
int RechercherTS(char *entitee);
int yyerror();

%}


%union{
char *chaine;
char car;
int entier;
float reel;
}

%token key_program	
%token key_begin	
%token key_end	
%token key_var	
%token key_integer	
%token key_float	
%token key_char	
%token key_string	
%token key_const	
%token key_let	
%token key_return	
%token key_if	
%token key_else	
%token key_end_if	
%token key_for	
%token key_end_for	
%token key_show	
%token key_get	
%token key_kaddition	
%token key_soustraction	
%token key_deux_points	
%token key_affectation	
%token key_point	
%token key_multiplication		
%token key_division	
%token key_commentaire	
%token key_superieur	
%token key_inferieur	
%token key_egal	
%token key_supegal	
%token key_infegal	
%token key_different	
%token key_fin	
%token key_pipe	
%token key_parouv	
%token key_parfer	
%token key_apostrophe		
%token key_guillemets	
%token key_signe
%token key_accouv	
%token key_accfer	
%token key_croouv
%token key_crofer	
%token	<chaine> idf
%token	<entier> cste_entier
%token	<car>	cste_char
%token	<reel>	cste_reel
%token	<chaine> cste_string
%token <entier> cste_bool

%left key_addition key_soustraction
%left key_multiplication key_division
%left key_superieur key_supegal key_egal key_different key_infegal key_inferieur

%start S
%%

S 						: key_program   idf Bloc_declaration   key_begin   Bloc_inst   key_end
						;

Bloc_declaration		: key_var Liste_variable Decl1 key_fin Bloc_declaration 
						| key_let idf Decl2 key_fin Bloc_declaration
						|
						;

Decl1					: key_deux_points Type
						| key_croouv Cste key_crofer key_deux_points key_croouv Type key_crofer
						;
						
Decl2					: key_deux_points Type key_affectation Cste
						| key_affectation Cste
						;

					 
Liste_variable	 		: Liste_variable key_pipe idf 
						| idf 
						;
	
Type					: key_integer 
						| key_string
						| key_char
						| key_float
						;
				
Cste					: cste_entier
						| cste_char
						| cste_reel
						| cste_string
						;
						
Bloc_inst				: Inst Bloc_inst
						|
						;
						
						
Inst					: Aff
						| ES
						| Exp_Arithm
						| Cond_if
						| Boucle_for
						| Commentaire
						;
						
Commentaire    			: key_commentaire cste_string key_commentaire
						;						
						
Aff						:  idf key_affectation Exp  key_fin 
						;
	
Exp 						: Exp_Arithm
						| cste_char
						| cste_string
						;

Exp_Arithm					: Exp_Arithm key_addition Exp_Arithm
						| Exp_Arithm key_soustraction Exp_Arithm
						| Exp_Arithm key_multiplication Exp_Arithm 
						| Exp_Arithm key_division Exp_Arithm
						| idf
						| cste_reel	
						| cste_entier
						| key_parouv Exp_Arithm key_parfer
						;

						
ES						: key_get key_parouv key_inferieur cste_string key_superieur key_deux_points key_signe  idf key_parfer key_fin
						| key_show key_parouv key_guillemets cste_string idf cste_string key_guillemets key_deux_points idf key_parfer key_fin				
	
						;
						
Cond_if       			: key_if key_parouv Cond key_parfer key_accouv Cond_inst key_accfer Bloc_cond key_end_if
						;

Cond					: Exp_Arithm key_egal Exp_Arithm
						| Exp_Arithm key_supegal Exp_Arithm
						| Exp_Arithm key_infegal Exp_Arithm
						| Exp_Arithm key_different Exp_Arithm
						| Exp_Arithm key_superieur Exp_Arithm
						| Exp_Arithm key_inferieur Exp_Arithm
						;

					

Bloc_cond				: key_else key_accouv Cond_inst key_accfer
						|
						;
						
Cond_inst				: Bloc_inst key_return key_parouv Res key_parfer
						;
Res					: Cste
					| idf
					;
						
Boucle_for      		: key_for key_parouv idf key_deux_points cste_entier key_deux_points Cond key_parouv For_inst key_end_for
						;
						
For_inst				: Bloc_inst	
						;
						
						
%%
int yyerror ()
{
   printf("Erreur syntaxique, Ligne : %d, Colonne: %d\n",ligne,col );
}

int main(){
  
	yyin=fopen("test1.txt","r");
	yyparse();
	
	printf("\n\n-------------------------\nTS (Nom) :\n-------------------------\n");
	for(int i=0;i<TailleTS; i++) {printf("%s\n", TS[i].nom);}
}
