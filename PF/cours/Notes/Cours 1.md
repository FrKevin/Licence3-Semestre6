Le 05/01/16

Les liens sur le portail pédagogique dans la session document sont un plus.

Programmation fonctionnelle ? Kezako ?
1- C’est un paradigme, (pas un langage , c'est une 'façon de faire")
2- Fonction citoyens de 1er classe, (" tout est fonction")
3- Différent d'un langage Impératif, (suite d'instructions, modification de l’état)
4- La programmation fonctionnelle s’écrit avec des expressions (série de valeurs), l'environnement (éxé, compilation) est "oublié".
5- On parle de pureté quand il n’y a pas d’effet de bord(side effect) c'est à dire pas de changement de valeurs ( évite les problèmes de maintenance, facilite les tests,parallélisme concurrence).
6- La transparence référentielle est une propriété des expressions d'un langage de programmation qui fait qu'une expression peut être remplacée par son résultat sans changer le comportement du programme.
7- Proche des langages applicatifs( l’élément central est l’application d’une fonction).
8- Proche des langages déclaratif (déclare les résultats à obtenir) exemple = SQL
___________________________________________________

Un peu d'histoire :

_ LISP (1958) est un langage impératif et fonctionnel, le 1er, encore utilisé
_ ML (1980) est un langage généraliste fonctionnel. (ex: OCAML: qui est fonctionnel, impératif, objet)
_ ERLANG, utilisé dans les télécoms
_ SCALA (JVM) fonctionnel et objet, ( https://www.typesafe.com/, entreprise qui réalise du conseil client pr gérer la quantité de données grandissantes)
_ CLOJURE ressemble à LISP dans la syntaxe
Nous allons utiliser le langage Haskell comme exemple à la programmation fonctionnelle. (utilisé par Google, Microsoft).
Mr Hym, le trouve joli et pratique, c'est une langage paresseux. Il est difficile à apprendre.

Ce cours est une introduction à la programmation fonctionnelle

" You must unlearn what you have learned"

Les objectifs sont : - apprendre à coder avec élégance
- ...
_______________________________________________
( fichier utilisé : somme.c, somme.java, somme.hs)
Somme de 1 à n en C:
int somme(int n) {
        int i, somme = 0;
        for(i = 0; i < n; i++){
                somme +=i;
}
        return 0;
}

Somme de 1 à n en Haskell:
somme n = sum [1..n]
( équivalent à )
somme’ n = sum (enumFromTo 1 n)

sommePairs n = sum [0,2..n

sommeImpairs n = sum [1,3..n]

sommeCarres n = sum (map (^2) [1..n])
___________________________________________
(fichier utilisé: mystere.hs) Représente le tri rapide
module Mystere where

myst :: [Int] -> [Int]  (définit le type)
myst []         = []      (liste vide = liste vide)
myst (x:xs) = myst ys ++ [x] ++ myst zs   ( myst (tete de la liste : queue de la liste) = myst ys concatené à [pivot] concatené à myst zs )
        where ys = [y | y <-  xs, y < x]              (...)
                zs = [z | z <- xs, z > x]                  (...)
....



Listes centrales (sucre syntaxique)
GHC:  Glasgow Haskell Compiler : REPL (Read-Eval-Print-Loop)
...
propriete xs = myst xs == sort xs
propriete’ (1:xs) = True

Deux equations definissant la même chose doivent être alignés pour fonctionner car Haskell utlise l'indentation pour s'y retrouver ds un fichier.

On a aussi parlé de Quickcheck propriete
Et de la différence entre les Majuscules et les minuscules dans Haskell/


Fin du premier cours.
___________________________________________________
