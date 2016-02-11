module ArbreBinaire where

data ArbreBinaire c v = Noeud { coul :: c
                              , val :: v
                              , gauche :: ArbreBinaire c v
                              , droite :: ArbreBinaire c v }
                      | Feuille
                      deriving (Show, Eq)

mapArbreBinaire :: (a -> b) -> ArbreBinaire c a -> ArbreBinaire c b
mapArbreBinaire _ Feuille = Feuille
mapArbreBinaire f (Noeud c v g d) = Noeud c (f v) (mapArbreBinaire f g) (mapArbreBinaire f d)


foldArbreBinaire :: (a -> b -> b -> b) -> b -> ArbreBinaire c a -> b
foldArbreBinaire _ n Feuille = n
foldArbreBinaire f n (Noeud _ v g d) = f v (foldArbreBinaire f n g) (foldArbreBinaire f n d)


foldArbreBinaire' :: ((c,a) -> b -> b -> b) -> b -> ArbreBinaire c a -> b
foldArbreBinaire' _ n Feuille = n
foldArbreBinaire' f n (Noeud c v g d) = f (c,v) (foldArbreBinaire' f n g) (foldArbreBinaire' f n d)


hauteur :: ArbreBinaire c a -> Int
hauteur Feuille = 0
hauteur (Noeud _ _ g d) = 1 + max (hauteur g) (hauteur d)

taille :: ArbreBinaire c a -> Int
taille Feuille = 0
taille (Noeud _ _ g d) = 1 + taille g + taille d

hauteur' :: ArbreBinaire c a -> Int
hauteur' = foldArbreBinaire (\_ y z -> 1 + max y z) 0

taille' :: ArbreBinaire c a -> Integer
taille' = foldArbreBinaire (\_ y z -> 1 + y + z) 0

peigneGauche :: [(c, a)] -> ArbreBinaire c a
peigneGauche = foldr (\ (c, v) x -> Noeud c v x Feuille) Feuille

prop_hauteurPeigne :: [(c, a)] -> Bool
prop_hauteurPeigne xs = length xs == hauteur (peigneGauche xs)
-- use in GHCI  :module + Test.QuickCheck
--        ghci> quickCheck prop_hauteurPeigne

estComplet :: ArbreBinaire c a -> Bool
estComplet Feuille = True
estComplet (Noeud _ _ g d) = (hauteur g == hauteur d) && estComplet g && estComplet d

-- Il existe deux cas : Vide et un element

complet :: Int -> [(c, a)] -> ArbreBinaire c a
complet 0 [] = Feuille
complet 0 _ = error ""
complet h l = Noeud c v (complet (h-1) lg) (complet (h-1) ld)
  where (lg , (c, v):ld) = splitAt (length l `quot` 2) l

-- Question 10 :
-- La fonction ayant cette signature est repeat

repeat' :: a -> [a]
repeat' = iterate id

listeTuple :: [((), Char)]
listeTuple = foldr (\x y-> ((), x) : y) [] ['a'..]

listeTuple' :: [((), Char)]
listeTuple' = [((), x) | x <- ['a'..]]

aplatit' :: ArbreBinaire c a -> [(c, a)]
aplatit' = foldArbreBinaire' (\x y z -> x:(y ++ z)) []

complet1 :: ArbreBinaire String Char
complet1 = complet 1 [("blue", 'a')]

complet2 :: ArbreBinaire String Char
complet2 = complet 2 [("blue", 'a'), ("blue", 'b'), ("blue", 'c')]

complet3 :: ArbreBinaire String Char
complet3 = complet 3 [("blue", 'a'), ("blue", 'b'), ("blue", 'c'),
                      ("blue", 'd'), ("blue", 'e'), ("blue", 'f'), ("blue", 'g')]

complet4 :: ArbreBinaire String Char
complet4 = complet 4 [("blue", 'a'), ("blue", 'b'), ("blue", 'c'),
                      ("blue", 'd'), ("blue", 'e'), ("blue", 'f'), ("blue", 'g'),
                      ("blue", 'h'), ("blue", 'i'), ("blue", 'j'),
                      ("blue", 'k'), ("blue", 'l'), ("blue", 'm'),
                      ("blue", 'n'), ("blue", 'o')]

element :: Eq a => a -> ArbreBinaire c a -> Bool
element elm = foldArbreBinaire' (\(_, x) y z -> elm == x || y || z) False




main :: IO ()
main =
  putStrLn "TP3 :"
