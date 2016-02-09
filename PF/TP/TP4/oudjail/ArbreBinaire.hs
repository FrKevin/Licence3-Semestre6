module ArbreBinaire where

data ArbreBinaire c v = Noeud { coul :: c
                              , val :: v
                              , gauche :: ArbreBinaire c v
                              , droite :: ArbreBinaire c v }
                      | Feuille
                      deriving (Show)

mapArbreBinaire :: (a -> b) -> ArbreBinaire c a -> ArbreBinaire c b
mapArbreBinaire _ Feuille = Feuille
mapArbreBinaire f (Noeud c v g d) = Noeud c (f v) (mapArbreBinaire f g) (mapArbreBinaire f d)


foldArbreBinaire :: (a -> b -> b -> b) -> b -> ArbreBinaire c a -> b
foldArbreBinaire _ n Feuille = n
foldArbreBinaire f n (Noeud _ v g d) = f v (foldArbreBinaire f n g) (foldArbreBinaire f n d)


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
peigneGauche = foldl (\ x (c, v) -> Noeud c v x Feuille) Feuille



main :: IO ()
main = putStrLn "Hello World"
