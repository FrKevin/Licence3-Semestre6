data Arbre coul val = Noeud { valeur :: val,
                              couleur:: coul,
                              gauche :: Arbre coul val,
                              droit  :: Arbre coul val
                            }
                            | Feuille
  deriving Show

mapArbre:: (v->v2) -> Arbre c v -> Arbre c v2
mapArbre _ Feuille = Feuille
mapArbre f (Noeud v c g d) = Noeud (f v) c (mapArbre f g) (mapArbre f d)

foldrArbre:: (v -> a -> a -> a) -> a -> Arbre c v -> a
foldrArbre _  acc Feuille = acc
foldrArbre op acc (Noeud v c g d) = op v (foldrArbre op acc g) (foldrArbre op acc d)

hauteur:: Arbre c v -> Integer
hauteur Feuille = 0
hauteur Noeud(v c g d) = 

main :: IO ()
main = do
   print Noeud {valeur="fff", couleur="vert", gauche= Feuille, droit= Feuille}
