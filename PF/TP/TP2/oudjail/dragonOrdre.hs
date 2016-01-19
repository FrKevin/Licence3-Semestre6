module Main where
import Graphics.Gloss

-- Fonction qui permet de calculer le point au centre de celui qui sont passes en parametre
pointAintercaler :: Point -> Point -> Point
pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)

-- Fonction alternative qui permet de calculer la courbe du dragon
dragonOrdre :: Point -> Point -> Int -> Path
dragonOrdre pA pB 0 = [pA, pB]
dragonOrdre pA pB n = let pC = (pointAintercaler pA pB) in
              (dragonOrdre pA pC (n-1)) ++ (dragonOrdre pB pC (n-1))


main :: IO ()
main = animate (InWindow "Dragon Ordre" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

dragonAnime a b t = Line (dragonOrdre a b (round t `mod` 20))
