Journal de bord
======
###### lundi 4 jan: Apprentissage de Pharo
###### vendredi 15 jan: Apprentissage de Pharo

Voici un résumé de notre apprentissage sur Pharo :

#### Entete d'une classe
	- Object subclass: #Toto

#### Note sur la syntaxe :
	- Les expressions (sauf les declarations) doivent ce finir par un point, à part la derniere.

	- [], les expression permettent d'etre evaluer (bloc d'evaluation)

##### Declaration :
	 Les declaration de variable doivent etre entourer de pipe |...|
	 Exemple :
	    |x|
	    |x y|

#### Commentaire:
	- "C'est mon commentaire"

#### Appel de methode :
	- Object toString
	- Object equals : a

#### Methode de print
	- Transcript show: 'sexe'; cr. (cr modelise le retour à la ligne,  c'est une methode)

	- (;) represente un appel de methode multiple sur un objet courant (facilité synthaxique)

	- Aide: Ouvrir une console permettant d'afficher la sortie standard : Tools -> Transcript

#### Ajouter un package pour de nouvelle class
	- 1er colone de gauche -> Add package

#### Ajouter une classe
	1) Dans la deuxième fenetre (en partant de la  gauche) -> click droit -> Add class.
	2) Dans la colone en bas a gauche ecrire le corps de la class

#### Ajouter une categorie de fonction
	- Avant dernière colonne: Add protocol (droite)

#### Ajouter une méthode
	1) Selectioner un package
	2) Ecrire dans la méthode  grâce a la fenêtre en bas a gauche

#### Méthode avec paramètre :
	- Ajouter ':' à la fin du nom de la méthode et mettre les paramètres


#### Structure de controle :
	- Conditionnelle :

	Contrairement au langage classique, les structure conditionnelles ne sont pas des mot clé qui prennent
    un type bool (primitive)
    En effet en PHARO, les conditions "classique" sont implementé par des methodes appartenant à la classe Boolean
    Par exemple :
     JAVA
      if (condition) {
        action();                             
      } else {                         
      }   
                                         ;
	PHARO
		(condition) ifTrue : ["action"]; ifFalse : ["autreAction"]
		- condition est une instance de la classe Boolean
		- ifTrue est une methode de la classe Boolean, elle prend une autreAction();                        
		- (closure [] : Fonction anonyme permettant d’exécuter du code)  quelle exécutera si la condition et vrai et renvoie la condition quoiqu'il arrive.
		- ;ifFalse methode appeler sur condition (on peut ce passer du point virgule car ifTrue renvoie condition), si celle ci est vrai (cela implique faux pour ifTrue), la closure passer en paramètre serra exécuter  et renvoie la condition.

    Il existe des methodes comme `ifNotNil` qui sont plus specifique et qui sont implementé dans les objets en generale.

#### Iteratif :
	De meme que pour les conditions, les structures iteratif sont des methodes de l'objet Boolean
    Par exemple
          JAVA                                 PHARO
      while (condition) {                   (condition) whileTrue : ["action"]
        action();
      }

#### Notion avancé :
	- Customisation de classe :
	Concept qui permet de copier une classe dans un package specifique et de redefinir les methodes neccessaire.
	Pour ce faire, il faut allez dans la classe que l'ont veut custom.
	Il faut ensuite y ajoute un package qui doit suivre un certain nommage.
	Ce package doit commencé obligatoirement par une etoile,
    Il doit comporter le nom du package qui contiendra la classe customiser (la suite n'est pas totalement valide, je pense, il doit contenir un tiret suivie du nom du package courant de la classe cible)


----------

###### vendredi 22 jan: Choix des projets :
	2 projets nous ont intéréssé :

    Wizard Battle arena, jeux 2D SDL
    cdb : structure de données [Lien crypto](http://cr.yp.to/cdb.html)

###### vendredi 29 jan :

	Compréhension du projet cdb

###### vendredi 05 fevrier
	envoie d'un mmail sur la mail list de user pharo
	http://www.unixuser.org/~euske/doc/cdbinternals/
