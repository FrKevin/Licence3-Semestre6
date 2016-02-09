module ArbreBinaire where

import Test.QuickCheck

-- question 1
data Arbre c v = Noeud { coul :: c
                              , val :: v
                              , gauche :: Arbre c v
                              , droite :: Arbre c v }
                      | Feuille
                      deriving (Show)

-- question 2
mapAB :: (a -> b) -> Arbre c a -> Arbre c b
mapAB _ Feuille = Feuille
mapAB f (Noeud c v g d) = Noeud c (f v) (mapAB f g) (mapAB f d)

foldAB :: (a -> b -> b -> b) -> b -> Arbre c a -> b
foldAB _ n Feuille = n
foldAB f n (Noeud _ v g d) = f v (foldAB f n g) (foldAB f n d)

-- question 3
hauteur :: Arbre c a -> Int
hauteur Feuille = 0
hauteur (Noeud _ _ g d) = 1 + max (hauteur g) (hauteur d)

taille :: Arbre c a -> Int
taille Feuille = 0
taille (Noeud _ _ g d) = 1 + taille g + taille d

hauteur' :: Arbre c a -> Int
hauteur' = foldAB (\_ y z -> 1 + max y z) 0

taille' :: Arbre c a -> Int
taille' = foldAB (\_ y z -> 1 + y + z) 0

-- question 4
peigneGauche :: [(c, a)] -> Arbre c a
peigneGauche = foldr (\(c, v) x -> Noeud c v x Feuille) Feuille

-- question 5
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)
-- elle vérifie si la hauteur du peigneGauche est égale à la longueur du tableau correspondant.

-- question 6
prop_taillePeigne xs = length xs == taille (peigneGauche xs)
prop_taillePeigne' xs = length xs == taille' (peigneGauche xs)

-- question 7
estComplet :: Arbre c a -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ g d) = estComplet g && estComplet d && (hauteur g == hauteur d)

-- question 8
-- l'arbre vide et l'arbre avec 1 seul élément

-- question 9
complet :: Int -> [(c, a)] -> Arbre c a
complet 0 _ = Feuille
complet _ [] = error "Pas assez d'élément dans le tableau"
complet x t = Noeud c v (complet (x-1) s1) (complet (x-1) s2)
         where (s1, ((c,v):s2)) = splitAt (length t `quot` 2) t

-- question 10
-- il s'agit de repeat
repeat' :: a -> [a]
repeat' = iterate id





-- question 11
tailleListe :: Int -> Int
tailleListe 0 = 0
tailleListe n = 1 + 2 * tailleListe (n-1)

-- ce qui suit ne sert que pour générer de grand nombre d'identifiant de noeuds pour graphviz

nextWords [] = []
nextWords (s:xs) = [s ++ [t] | t <- ['a'..'z']] ++ (nextWords xs)

identifiers = concat (iterate nextWords (map (\x -> [x]) ['a'..'z']))

-- implémentation de base pour l'exercice 11 :
-- createListe = [((),j) | j <- ['a'..]]

-- implémentation améliorée
createListe = [((),j) | j <- identifiers]

createListForComplet n = take (tailleListe n) createListe

-- exemple de création d'un arbre complet :
-- complet 5 (createListForComplet 5)





-- question 12
aplatit :: Arbre c a -> [(c, a)]
aplatit Feuille = []
aplatit (Noeud c a g d) = aplatit g ++ [(c, a)] ++ aplatit d

-- question 13
element :: Eq a => a -> Arbre c a -> Bool
element _ Feuille = False
element a (Noeud _ v g d) = (v == a) || (element a g) || (element a d)




-- question 14
charToString :: Char -> String
charToString c = [c]


noeud :: (c -> String) -> (a -> String) -> (c, a) -> String
noeud fc fv (c, v) = fv v ++ " [color=" ++ strC ++ ", fontcolor=" ++ strC ++ "]"
                where strC = fc c

-- question 15
valNoeud :: Arbre c a -> a
valNoeud Feuille = error "C'est une feuille"
valNoeud (Noeud _ v _ _) = v

arcs :: Arbre c a -> [(a, a)]
arcs Feuille = []
arcs (Noeud _ _ Feuille Feuille) = []
arcs (Noeud _ v g Feuille) = [(v, valNoeud g)] ++ (arcs g)
arcs (Noeud _ v Feuille d) = [(v, valNoeud d)] ++ (arcs d)
arcs (Noeud _ v g d) = [(v, valNoeud g), (v, valNoeud d)] ++ (arcs g) ++ (arcs d)
-- TODO à simplifier surement

-- question 16
arc :: (a -> String) -> (a, a) -> String
arc f (x, y) = (f x) ++ " -> " ++ (f y)

-- question 17
dotise :: String -> (c -> String) -> (a -> String) -> Arbre c a -> String
dotise t fc fv a = unlines (
                    ["digraph \"" ++ t ++ "\" {",
                     "node [shape=circle]"]
                    ++ (map (noeud fc fv) (aplatit a))
                    ++ (map (arc fv) (arcs a))
                    ++ ["}"]
                )


-- test :
testArbre :: IO ()
testArbre = do
        writeFile "arbre.dot" (dotise "Test 1" (\_ -> "black") id (complet 6 (createListForComplet 6)))






-- question 18
elementR :: Eq a => a -> Arbre c a -> Bool -- reprends la signature de la question 13
elementR v Feuille = False
elementR a (Noeud _ v g d)  | a == v = True
                            | a < v  = elementR a g
                            | a > v  = elementR a d


-- question 19
type Couleur = Rouge | Noir

couleurToString :: Couleur -> String
couleurToString Rouge = "red"
couleurToString Noir = "black"



-- question 20
