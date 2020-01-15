%{
#include<stdio.h>
Extern File *yyin;
%}


%union{
char *chaine;
char car;
int entier;
float reel;
}

%token	key_program
%token	key_begin
%token	key_end
%token	key_var
%token	key_integer
%token	key_float
%token	key_char
%token	key_string
%token	key_const
%token	key_let
%token	key_return
%token	key_if
%token	key_else
%token	key_end_if
%token	key_for
%token	key_end_for
%token	key_show
%token	key_get
%token	key_kaddition
%token	key_soustraction
%token	key_deux_points
%token	key_affectation
%token	key_point
%token	key_multiplication	
%token	key_division
%token	key_commentaire
%token	key_superieur
%token	key_inferieur
%token	key_egal
%token	key_supegal
%token	key_infegal
%token	key_different
%token	key_fin
%token	key_barre
%token	key_parouv
%token	key_parfer
%token	key_apostrophe
%token	key_blanc
%token	key_guillemets
%token	key_accouv
%token	key_accfer
%token	key_saut_de_ligne
%token	key_tabulation
%token	<chaine> idf
%token	<entier> cste_entier
%token	<car>	cste_char
%token	<reel>	cste_reel
%token	<chaine> cste_string

%left key_addition key_soustraction
%left key_multiplication key_division
%left key_superieur key_supegal key_egal key_different key_infegal key_inferieur

%%

S 				: Key_program idf  Bloc_declaration key_begin Bloc_inst key_end
				;
Bloc_declaration:  Liste_declaration_simple
				|  Liste_declaration_tab
				|  Liste_declaration_const
				;
Liste_declaration_simple: Liste_declaration_simple key_var Liste_variable key_deux_points Type key_fin	
						| key_var Liste_variable key_deux_points Type key_fin
						;
						
Liste_declaration_tab: Liste_declaration_tab key_var Liste_variable key_croouv Cste key_crofer key_deux_points key_croouv Type key_crofer key_fin
					 |key_var Liste_variable key_croouv Cste key_crofer key_deux_points key_croouv Type key_crofer key_fin
					 ;
					 
Liste_declaration_const: Liste_declaration_const key_let Liste_variable Type key_affectation Cste key_fin
					   | key_let Liste_variable Type key_affectation Cste key_fin
					   |key_let Liste_variable key_affectation Cste key_fin
					   ;
					 
Liste_variable	 : 	Liste_variable key_pipe idf 
				| idf
				;

Bloc_inst		: Bloc_inst Inst
				|Inst
				;
			
Inst			: Aff
				| ES
				| Cond_if
				| Boucle
				| Commentaire
				;
				
Aff				: Aff idf key_affectation Exp key_fin
				| idf key_affectation Exp key_fin 
				;

ES				: ES key_get key_parouv key_inferieur cste_string key_superieur key_deux_points key_signe  idf key_parfer key_fin
				| ES key_show key_parouv key_guillemets cste_string idf cste_string key_guillemets key_deux_points idf key_parfer key_fin
				| key_get key_parouv key_inferieur cste_string key_superieur key_deux_points key_signe  idf key_parfer key_fin
				| key_show key_parouv key_guillemets cste_string idf cste_string key_guillemets key_deux_points idf key_parfer key_fin
				;

Exp 			: Exp_Arithm
				| Cond
				| Exp_log
				| Cste
;
				
Exp_Arithm		: Exp_Arithm key_addition Exp_Arithm1
				| Exp_Arithm1
;
Exp_Arithm1		: Exp_Arithm1 key_soustraction Exp_Arithm2
				| Exp_Arithm2
				;
Exp_Arithm2		: Exp_Arithm2 key_multiplication Exp_Arithm3
				| Exp_Arithm3
				;
Exp_Arithm3		: Exp_Arithm3 key_division Exp_Arithm4
				| Exp_Arithm4
				;
Exp_Arithm4		: idf 
				| cste_entier 
				| cste_reel
				| key_parouv Exp_Arithm key_parfer
				| 
				;
				
Type			: key_integer 
				| key_string
				| key_char
				| key_float
				;
				
Cste			: cste_entier
				| cste_char
				| cste_reel
				| cste_string
				;

Cste_num		: cste_entier 
				| cste_reel 
				| cste_booleenne
				;



Cond	                : Cond_arith	
				|Cond_idf
				|Cond_cste 
				;



Commentaire             : key_commentaire cste_string key_commentaire
				;

Boucle                  : key_for key_parouv idf key_deux_points cste_entier key_deux_points Cond key_parouv Bloc_inst key_end_for
				;
Cond_arith              : Exp_Arithm key_egal Exp_Arithm
				|Exp_Arithm key_supegal Exp_Arithm
				|Exp_Arithm key_infegal Exp_Arithm
				|Exp_Arithm key_different Exp_Arithm
				|Exp_Arithm key_superieur Exp_Arithm
				|Exp_Arithm key_inferieur Exp_Arithm
				
				;
Cond_idf		: idf key_egal idf 
				|idf key_supegal idf 
				|idf key_infegal idf 
				|idf key_different idf 
				|idf key_superieur idf
				|idf key_inferieur idf 
				;
					
Cond_cste		: Cste_num key_egal Cste_num 
				|Cste_num key_supegal Cste_num 
				|Cste_num key_infegal Cste_num 
				|Cste_num key_different Cste_num 
				|Cste_num key_superieur Cste_num
				|Cste_num key_inferieur Cste_num 
				;


Cond_if       		: key_if Cond accouv Inst Inst key_return key_parouv key_idf parfer accfer key_else accouv Inst Inst key_return key_parouv key_idf key_parfer accfer key_end_if
				;

%%

1

int main(){
  
	yyin=fopen("test1.txt","r");
	yyparse();
