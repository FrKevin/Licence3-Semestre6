import           Test.QuickCheck

data Arbre coul val = Noeud { valeur  :: val,
                              couleur:: coul,
                              gauche  :: Arbre coul val,
                              droit   :: Arbre coul val
                            }
                            | Feuille
  deriving Show

mapArbre:: (v->v2) -> Arbre c v -> Arbre c v2
mapArbre _ Feuille = Feuille
mapArbre f (Noeud v c g d) = Noeud (f v) c (mapArbre f g) (mapArbre f d)

foldrArbre:: (v -> a -> a -> a) -> a -> Arbre c v -> a
foldrArbre _  acc Feuille = acc
foldrArbre op acc (Noeud v c g d) = op v (foldrArbre op acc g) (foldrArbre op acc d)

hauteurRec:: Arbre c v -> Int
hauteurRec Feuille = 0
hauteurRec (Noeud _ _ g d) = 1 + max (hauteurRec g) (hauteurRec d)

hauteurF :: Arbre c a -> Int
hauteurF = foldrArbre (\ _ y z -> 1 + max y z) 0

tailleRec:: Arbre c v -> Int
tailleRec Feuille = 0
tailleRec (Noeud _ _ g d) = 1 + tailleRec g + tailleRec d

tailleF :: Arbre c v -> Int
tailleF = foldrArbre (\ _ y z -> 1 + y + z) 0

peigneGauche :: [(c,v)] -> Arbre c v
peigneGauche [] = Feuille
peigneGauche (x:xs) =  Noeud {valeur= snd x, couleur= fst x, gauche= peigneGauche xs, droit= Feuille}

estComplet :: Arbre c a -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ g d) = (hauteurF g == hauteurF d) && estComplet g && estComplet d

complet :: Int -> [(c, a)] -> Arbre c a
complet 0 _ = Feuille

--Q10 repeat
repeat':: a -> [a]
repeat'= iterate id

--Q11
listeTuple =foldr (\ x y -> ( (), x) : y) [] ['a'..]
-- tests
prop_hauteurPeigne_with_rec xs = length xs == hauteurRec (peigneGauche xs)
prop_hauteurPeigne_with_fold xs = length xs == hauteurF (peigneGauche xs)

prop_taille_width_rec xs = length xs ==  tailleRec (peigneGauche xs)
prop_taille_width_fold xs = length xs ==  tailleF (peigneGauche xs)

main :: IO ()
main = do
   print Noeud {valeur="fff", couleur="vert", gauche= Feuille, droit= Feuille}
