module Arbre where
import Control.Concurrent (threadDelay)

data Arbre c v = Noeud { coul :: c
                              , val :: v
                              , gauche :: Arbre c v
                              , droite :: Arbre c v }
                | Feuille
                      deriving (Show, Eq, Ord)

mapArbre :: (a -> b) -> Arbre c a -> Arbre c b
mapArbre _ Feuille         = Feuille
mapArbre f (Noeud c v g d) = Noeud c (f v) (mapArbre f g) (mapArbre f d)

foldArbre :: (a -> b -> b -> b) -> b -> Arbre c a -> b
foldArbre _ n Feuille         = n
foldArbre f n (Noeud _ v g d) = f v (foldArbre f n g) (foldArbre f n d)


foldArbre' :: ((c,a) -> b -> b -> b) -> b -> Arbre c a -> b
foldArbre' _ n Feuille         = n
foldArbre' f n (Noeud c v g d) = f (c,v) (foldArbre' f n g) (foldArbre' f n d)

hauteur :: Arbre c a -> Int
hauteur Feuille = 0
hauteur (Noeud _ _ g d) = 1 + max (hauteur g) (hauteur d)

taille :: Arbre c a -> Int
taille Feuille = 0
taille (Noeud _ _ g d) = 1 + taille g + taille d

hauteur' :: Arbre c a -> Int
hauteur' = foldArbre (\_ y z -> 1 + max y z) 0

taille' :: Arbre c a -> Integer
taille' = foldArbre (\_ y z -> 1 + y + z) 0

peigneGauche :: [(c, a)] -> Arbre c a
peigneGauche = foldr (\ (c, v) x -> Noeud c v x Feuille) Feuille

prop_hauteurPeigne :: [(c, a)] -> Bool
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)
-- use in GHCI  :module + Test.QuickCheck
--        ghci> quickCheck prop_hauteurPeigne

estComplet :: Arbre c a -> Bool
estComplet Feuille         = True
estComplet (Noeud _ _ g d) = (hauteur g == hauteur d) && estComplet g && estComplet d

-- Il existe deux cas : Vide et un element

complet :: Int -> [(c, a)] -> Arbre c a
complet 0 [] = Feuille
complet 0 _  = error ""
complet h l  = Noeud c v (complet (h-1) lg) (complet (h-1) ld)
  where (lg , (c, v):ld) = splitAt (length l `quot` 2) l

-- Question 10 :
-- La fonction ayant cette signature est repeat

repeat' :: a -> [a]
repeat' = iterate id

listeTuple :: [((), Char)]
listeTuple = foldr (\x y-> ((), x) : y) [] ['a'..]

listeTuple' :: [((), Char)]
listeTuple' = [((), x) | x <- ['a'..]]

aplatit :: Arbre c a -> [(c, a)]
aplatit = foldArbre' (\x y z -> y ++ [x] ++ z) []

complet1 :: Arbre String Char
complet1 = complet 1 [("blue", 'a')]

complet2 :: Arbre String Char
complet2 = complet 2 [("blue", 'a'), ("blue", 'b'), ("blue", 'c')]

complet3 :: Arbre String Char
complet3 = complet 3 [("blue", 'a'), ("blue", 'b'), ("blue", 'c'),
                      ("blue", 'd'), ("blue", 'e'), ("blue", 'f'), ("blue", 'g')]

complet4 :: Arbre String Char
complet4 = complet 4 [("blue", 'a'), ("blue", 'b'), ("blue", 'c'),
                      ("blue", 'd'), ("blue", 'e'), ("blue", 'f'), ("blue", 'g'),
                      ("blue", 'h'), ("blue", 'i'), ("blue", 'j'),
                      ("blue", 'k'), ("blue", 'l'), ("blue", 'm'),
                      ("blue", 'n'), ("blue", 'o')]

a' :: Arbre Couleur String
a' = Noeud N "a" Feuille Feuille

b' :: Arbre Couleur String
b' = Noeud N "b" Feuille Feuille

c' :: Arbre Couleur String
c' = Noeud N "c" Feuille Feuille

d' :: Arbre Couleur String
d' = Noeud N "d" Feuille Feuille

desequilibre1 :: Arbre Couleur String
desequilibre1 = Noeud N "z" (Noeud R "y" (Noeud R "x" a' b') c') d'

desequilibre2 :: Arbre Couleur String
desequilibre2 = Noeud N "z" (Noeud R "x" a' (Noeud R "y" b' c')) d'

desequilibre3 :: Arbre Couleur String
desequilibre3 = Noeud N "x" a' (Noeud R "z" (Noeud R "y" b' c') d')

desequilibre4 :: Arbre Couleur String
desequilibre4 = Noeud N "x" a' (Noeud R "y" b' (Noeud R "z" c' d'))

element :: Eq a => a -> Arbre c a -> Bool
element elm = foldArbre' (\(_, x) y z -> elm == x || y || z) False

noeud :: (c -> String) -> (a -> String) -> (c,a) -> String
noeud pC pV (c, v) = let sC = pC c in pV v ++ " [color=" ++ sC ++ ", fontcolor=" ++ sC ++ "]"

arcs :: Arbre c a -> [(a,a)]
arcs Feuille                                           = []
arcs (Noeud _ _ Feuille Feuille)                       = []
arcs (Noeud _ v Feuille d@(Noeud _ vd _ _))            = (v,vd):arcs d
arcs (Noeud _ v g@(Noeud _ vg _ _) Feuille)            = (v,vg):arcs g
arcs (Noeud _ v g@(Noeud _ vg _ _) d@(Noeud _ vd _ _)) = (v,vg):(v,vd):arcs g ++ arcs d

arcs' :: Arbre c a -> [(a,a)]
arcs' Feuille         = []
arcs' (Noeud _ v g d) = parser v g ++ parser v d ++ arcs' g ++ arcs' d
  where parser _ Feuille         = []
        parser x (Noeud _ y _ _) = [(x, y)]


arc :: (a -> String) -> (a,a) -> String
arc pS (v1, v2) = pS v1 ++ " -> " ++ pS v2


dotise :: String -> (c -> String) -> (a -> String) -> Arbre c a -> String
dotise n pcs pvs abr = unlines (header ++ map (noeud pcs pvs) (aplatit abr) ++ lArcs ++ footer)
  where header = ["digraph \"" ++ n ++ "\" {", "node [fontname=\"DejaVu-Sans\", shape=circle]"]
        lArcs  = map (arc pvs) (arcs abr)
        footer = ["}"]


elementR :: Ord a => a -> Arbre c a -> Bool
elementR _ Feuille                       = False
elementR a (Noeud _ v g d)  | a == v     = True
                            | a < v      = elementR a g
                            | otherwise  = elementR a d


data Couleur = R
             | N
             deriving(Show, Eq)


couleurToString :: Couleur -> String
couleurToString R = "red"
couleurToString N = "black"

equilibre :: Arbre Couleur a -> Arbre Couleur a
equilibre (Noeud _ z (Noeud R y (Noeud R x a b) c) d) = Noeud R y (Noeud N x a b) (Noeud N z c d)
equilibre (Noeud _ z (Noeud R x a (Noeud R y b c)) d) = Noeud R y (Noeud N x a b) (Noeud N z c d)
equilibre (Noeud _ x a (Noeud R z (Noeud R y b c) d)) = Noeud R y (Noeud N x a b) (Noeud N z c d)
equilibre (Noeud _ x a (Noeud R y b (Noeud R z c d))) = Noeud R y (Noeud N x a b) (Noeud N z c d)
equilibre abr                                         = abr

racineToujoursNoir :: Arbre Couleur a -> Arbre Couleur a
racineToujoursNoir Feuille         = Feuille
racineToujoursNoir (Noeud _ r g d) = Noeud N r g d

insertion :: Ord a => a -> Arbre Couleur a -> Arbre Couleur a
insertion valeur arbre = racineToujoursNoir (ins valeur arbre)
  where ins v Feuille                              = Noeud R v Feuille Feuille
        ins v abr@(Noeud c r g d) | elementR v abr = abr
                                  | v < r          = equilibre (Noeud c r (ins v g) d)
                                  | otherwise      = equilibre (Noeud c r g (ins v d))

arbresDot :: String -> [String]
arbresDot chaine  = f chaine Feuille
  where f "" _       = []
        f (x:xs) abr = dotise "Arbre" couleurToString id newAbr : f xs newAbr
          where newAbr = insertion [x] abr

-- Windows :
-- cmd> touch arbre.ps
-- cmd> evince arbre.ps
-- cmd> dot -Tps arbre.dot -o arbre.ps
-- cmd> ...

main :: IO ()
main = mapM_ ecrit arbres
    where ecrit a = do writeFile "Arbre.dot" a
                       threadDelay 10
                                -- 1000000
          arbres  = arbresDot "gcfxieqzrujlmdoywnbakhpvst"
                           -- ['a'..'z']
