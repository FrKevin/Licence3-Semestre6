Le 05/01/16
(fichier utilisé: types.hs)

LE TYPAGE:

Haskell est fortement typé statiquement.
Un type est un ensemble de valeurs.
Statiquement car la vérification du type se fait à la compilation.
Fortement car il n’y a pas d’erreur de type à l’exécution.
Le compilateur fait l’inférence de type (détecte à peu près automatiquement le type des variables).
"Il y a des types partout mais ils sont écrits nulpart" c'est ce qu'on appelle: l'inférence de type

_ Bool : True et False
_ Char : ‘a’ ‘b’...
_ Int: valeur max: 9223372036854775807 ( grâce à "maxbound::Int" dans ghci qui renvoie la valeur maximale de tout types bornés)
_ Integer: entier en précision arbitraire
_ Double
_ Liste  [a]  ( élements d'une liste, Attention les listes sont HOMOGENES)
_ String : [Char] (liste de caractère)
_ n_uplets (t1,t2,t3) (Char, Int)
_ t1 -> t2 (type de fonction)

add :: (Int, Int) -> Int  (type)
add (x, y) = x + y        (fonction)

zeroTo :: Int -> [Int]
zeroTo n = [0..n]

duplique :: a -> (a, a)
duplique n = (n, n).
______________________________

Curryfication: Les fonctions ont un seul argument et retournent éventuellement une fonction qui attend les autres
add’ :: Int -> Int -> Int   
add a b = a + b

add' 1 :: Int -> Int
add' 1  ( fonction qui attend son 2eme argument)

(add' 1) 2
/=
add' (1 2 )

add' x y :: t1->(t2->t3)
add x y = x + y
____________________________

Surchage = classes de types ( "You must unlearn what you have learned" , ... on oublie les classes Java, ici similaire à une interface java (en mieux) )
Prenons un exemple :
1 + 2

en C, cast implicite, explicite
en Ocaml, différence entre une addition d'entier et de flottant (+, .+)
en Haskell :
    (+) :: Num a => a -> a -> a -> a   ( qu'o obtient en tapant :t (+) dans ghci )
    Num a = contrainte de classe, a doit être un nombre

    :info Num
    définition de l'utilisation de Num

En java, pour Integer utilisatio de .equals
         pour Int utilisation de ==
En Haskell :  

    :t (==)
    (==): Eq => a -> a -> Bool
    :info Eq

     :t(<)

     Eq, Num, Ord, Show, Fractionnal,....
     Sont des classes de types, si un type appartient à une classe alors, il implémente le comportement décrit par la classe


 ____________________________

 Moyenne d'un ensemble de valeurs

 moyenne ns = sum ns 'div' length ns
 moyenne ns = div(sum ns)(length ns)


______________________________

Pattern matching : filtrage de motif

Liste de liste

longPrem [[a]] -> Int
longPrem (xs:xss) = length xs

On notera :
    [a]  xs
    [[a]] xss
    [[[a]]] xsss
    
