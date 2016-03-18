/*****************************************************
 * Analyseur lexical
 * fichier de description pour JFlex
 * produit ScannerLogic.java
 * Thomas Pietrzak
 * 09/02/15
 ****************************************************/

/***********************************************************************
 * Première partie : code utilisateur inclus tel quel dans le fichier
 * .java généré. On met typiquement ici les déclarations de paquetage
 * (package) et les importations de classes (import).
 ***********************************************************************/

// déclaration du paquetage auquel appartient la classe générée
package logicline.analyseurs;

%%

/***********************************************************************
 * Seconde partie : options et déclarations de macros. 
 ***********************************************************************/

/*************************   Options  **********************/ 

// ATTENTION : le % doit toujours être en 1ère colonne

// la classe générée implantant l'analyseur s'appelle ScannerInit.java
%class ScannerLogic
// et est publique
%public
// la cl. générée implante l'itf java_cup.runtime.Scanner fournie par Cup
%implements java_cup.runtime.Scanner
// pour utiliser les caractères unicode
%unicode
// pour garder trace du numéro de ligne du caractère traité
%line
// pour garder trace du numéro de colonne du caractère traité
%column
// l'an. lex. retourne des symboles de type java_cup.runtime.Symbol
%type java_cup.runtime.Symbol
// la fonction de l'analyseur fournissant le prochain Symbol s'appelle
// next_token...
%function next_token
// ... et lève une exception ScannerException en cas d'erreur lexicale
%yylexthrow{
ScannerException
%yylexthrow}
// action effectuée qd la fin du fichier à analyser est rencontrée
// le type EOF est généré automatiquement par Cup
%eofval{
  return new Symbole(TypeSymboles.EOF);
%eofval}
// code recopié dans la classe générée
%{
  private Symbole creerSymbole(String representation, int type) {
    return new Symbole(representation,type,yyline,yycolumn);
  }

  private Symbole creerSymbole(String representation, int type, Object valeur) {
    return new Symbole(representation,type,valeur,yyline,yycolumn);
  }  
%}

/*************************   définitions macros  **********************/ 

// une macro est une abbréviation pour une expression régulière

// syntaxe : <nom_macro> = <expr_reg>
// une macro peut être utilisée pour en définir une autre (de
// manière non récursive !) : il faut alors entourer son
// identificateur d'accolades.

finLigne = \r|\n|\r\n 

// convention Java
// | est le choix des expr reg de JFlex
// \n = retour-chariot sous Unix, \r = rc sous Windows

blancs = {finLigne} | [ \t\f] 
// \t = tabulation, \f = form-feed
// [ \t\f] est une classe de caractères qui dénote soit " ", soit \t,
// soit \f   

//lettre = [A-Z]|[a-z]

//chiffre = [0-9]

id = [A-Za-z_][A-Za-z_0-9]*

%%

/***********************************************************************/
/* Troisième partie : règles lexicales et actions. */
/***********************************************************************/

// syntaxe : { <nom_macro> | <expr_reg> } { <code_java> } un return ds
// le code Java correspond au retour d'un symbole (ici de type Symbol)
// résultat de la méthode d'analyse (ici la fonction next_token). 
// S'il n'y a pas de return, on passe au symbole suivant.

{blancs} { /* on ignore les blancs */ }

"T" {
  return creerSymbole("TRUE", TypeSymboles.TRUE);
}

"F" {
  return creerSymbole("FALSE", TypeSymboles.FALSE);
}

"-" {
  return creerSymbole("NON", TypeSymboles.NON);
}

"+" {
  return creerSymbole("OU", TypeSymboles.OU);
}

"*" {
  return creerSymbole("ET", TypeSymboles.ET);
}

"=>" {
  return creerSymbole("IMPL", TypeSymboles.IMPL);
}

"<=>" {
  return creerSymbole("EQUIV", TypeSymboles.EQUIV);
}

"table" {
  return creerSymbole("TABLE", TypeSymboles.TABLE);
}

"fnc" {
  return creerSymbole("FNC", TypeSymboles.FNC);
}

"dpll" {
  return creerSymbole("DPLL", TypeSymboles.DPLL);
}

"vl" {
  return creerSymbole("VL", TypeSymboles.VL);
}

"(" {
  return creerSymbole("PO", TypeSymboles.PO);
}

")" {
  return creerSymbole("PF", TypeSymboles.PF);
}

"[" {
  return creerSymbole("CO", TypeSymboles.CO);
}

"]" {
  return creerSymbole("CF", TypeSymboles.CF);
}

"," {
  return creerSymbole("VIR", TypeSymboles.VIR);
}

"." {
  return creerSymbole("POINT", TypeSymboles.POINT);
}

"<=" {
  return creerSymbole("AFF", TypeSymboles.AFF);
}

{id} {
	return creerSymbole("VARIABLE",TypeSymboles.VARIABLE,yytext());	
}

[^]|\n {// erreur : .|\n désigne n'importe quel caractère non reconnu
      // par une des règles précédentes 
  throw new ScannerException("symbole inconnu, caractère " + yytext() + 
				 " ligne " + yyline + " colonne " + yycolumn);
}  
