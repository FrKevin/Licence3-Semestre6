module Main where
import Graphics.Gloss


alterne :: [a]  -> [a]
alterne [] = []
alterne [e] = [e]
alterne (x1 : _ : xs) = x1 : (alterne xs)

combine :: (a -> b -> c) -> [a] -> [b] -> [c]
combine _ [] [] = []
combine _ [] (_ : _) = []
combine _ (_ : _) [] = []
combine fct (x1 : xs1) (x2 : xs2) = (fct x1 x2) : (combine fct xs1 xs2)

pasPascal :: [Int] -> [Int]
pasPascal [] = [1]
pasPascal l = [1] ++ (zipWith (+) (tail l) (init l)) ++ [1]

pascal :: [[Int]]
pascal = (iterate pasPascal [])

pointAintercaler :: Point -> Point -> Point
pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)

pasDragon :: Path -> Path
pasDragon [] = []
pasDragon [xa] = [xa] -- cas d'arret n impair element n >= 3
pasDragon [xa, xb] = xa : [pointAintercaler xa xb] ++ [xb] -- cas d'arret n pair element n >= 3
pasDragon (xa : xb : xc : xs) =
    xa : (pointAintercaler xa xb) : xb : (pointAintercaler xc xb) : (pasDragon (xc:xs))

dragon :: Point -> Point -> [Path]
dragon (xA, yA) (xB, yB) = (iterate pasDragon [(xA, yA),(xB, yB)])


main :: IO ()
main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))
