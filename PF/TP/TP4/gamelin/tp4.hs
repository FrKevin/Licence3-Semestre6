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

hauteur_rec:: Arbre c v -> Int
hauteur_rec Feuille = 0
hauteur_rec (Noeud _ _ g d) = 1 + max (hauteur_rec g) (hauteur_rec d)

hauteur_f :: Arbre c a -> Int
hauteur_f = foldrArbre (\ _ y z -> 1 + max y z) 0

taille_rec:: Arbre c v -> Int
taille_rec Feuille = 0
taille_rec (Noeud _ _ g d) = 1 + (taille_rec g) + (taille_rec d)

taille_f :: Arbre c v -> Int
taille_f = foldrArbre (\ _ y z -> 1 + y + z) 0

peigneGauche :: [(c,v)] -> Arbre c v
peigneGauche [] = Feuille
peigneGauche (x:xs) =  Noeud {valeur= snd(x), couleur= fst(x), gauche= (peigneGauche xs), droit= Feuille}

estComplet :: Arbre c a -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ g d) = taille_rec g == taille_rec d

-- tests
prop_hauteurPeigne_with_rec xs = length xs == hauteur_rec (peigneGauche xs)
prop_hauteurPeigne_with_fold xs = length xs == hauteur_f (peigneGauche xs)

prop_taille_width_rec xs = length xs ==  taille_rec (peigneGauche xs)
prop_taille_width_fold xs = length xs ==  taille_f (peigneGauche xs)

main :: IO ()
main = do
   print Noeud {valeur="fff", couleur="vert", gauche= Feuille, droit= Feuille}
