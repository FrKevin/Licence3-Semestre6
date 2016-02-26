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

foldArbre' :: ((c,a) -> b -> b -> b) -> b -> Arbre c a -> b
foldArbre' _ n Feuille         = n
foldArbre' f n (Noeud c v g d) = f (v,c) (foldArbre' f n g) (foldArbre' f n d)

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

--Q12
aplatit :: Arbre c a -> [(c, a)]
aplatit = foldArbre' (\x y z -> y ++ [x] ++ z) []

--Q13
element :: Eq a => a -> Arbre c a -> Bool
element _ Feuille = False
element n (Noeud v _ g d) | v == n = True
                          | otherwise = element n g || element n d
--Q14
noeud :: (c -> String) -> (a -> String) -> (c,a) -> String
noeud fc fv (c, v) = let sc = fc c in fv v ++ " [color=" ++ sc ++ ", fontcolor=" ++ sc ++ "]"

--Q15
arcs :: Arbre c a -> [(a,a)]
arcs Feuille                                           = []
arcs (Noeud _ _ Feuille Feuille)                       = []
arcs (Noeud v _ Feuille d@(Noeud vd _ _ _))            = (v,vd):arcs d
arcs (Noeud v _ g@(Noeud vg _ _ _) Feuille)            = (v,vg):arcs g
arcs (Noeud v _ g@(Noeud vg _ _ _) d@(Noeud vd _ _ _)) = (v,vg):(v,vd):arcs g ++ arcs d

--Q16
arc :: (a -> String) -> (a,a) -> String
arc fs (v1, v2) = fs v1 ++ " -> " ++ fs v2

--Q17
dotise :: String -> (c -> String) -> (a -> String) -> Arbre c a -> String
dotise s pcs pvs abr = unlines (header ++ map (noeud pcs pvs) (aplatit abr) ++ lArcs ++ footer)
  where header = ["digraph \"" ++ s ++ "\" {", "node [fontname=\"DejaVu-Sans\", shape=circle]"]
        lArcs  = map (arc pvs) (arcs abr)
        footer = ["}"]

--Q52
id' :: a -> a
id' x = x

-- tests
prop_hauteurPeigne_with_rec xs = length xs == hauteurRec (peigneGauche xs)
prop_hauteurPeigne_with_fold xs = length xs == hauteurF (peigneGauche xs)

prop_taille_width_rec xs = length xs ==  tailleRec (peigneGauche xs)
prop_taille_width_fold xs = length xs ==  tailleF (peigneGauche xs)

main :: IO ()
main = do
   print Noeud {valeur="fff", couleur="vert", gauche= Feuille, droit= Feuille}
