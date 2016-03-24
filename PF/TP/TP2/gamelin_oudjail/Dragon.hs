module Dragon where
import Graphics.Gloss

-- Fonction qui prend deux point et qui calcule le point intermediaire d'apres
-- la courbe du dragon
pointAintercaler :: Point -> Point -> Point
pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)


-- Fonction qui prend une ligne de la courbe et qui calcule la suivante à partir de celle ci
pasDragon :: Path -> Path
pasDragon [] = []
pasDragon [xa] = [xa] -- cas d'arret n impair element n >= 3
pasDragon [xa, xb] = xa : pointAintercaler xa xb : [xb] -- cas d'arret n pair element n >= 3
pasDragon (xa : xb : xc : xs) =
    xa : pointAintercaler xa xb : xb : pointAintercaler xc xb : pasDragon (xc:xs)

-- Fonction qui creer la courbe du dragon de maniere infini
dragon :: Point -> Point -> [Path]
dragon (xA, yA) (xB, yB) = iterate pasDragon [(xA, yA),(xB, yB)]

main :: IO ()
main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))
