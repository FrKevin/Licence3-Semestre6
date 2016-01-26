module Main where
-- import Graphics.Gloss

-- certaines lignes sonc commentés car la librairie n'est pas
-- sur mon ordinateur et l'installation de celle-ci n'aboutie pas


-- question 1
alterne :: [a] -> [a]
alterne [] = []
alterne [x] = [x]
alterne (x:xs) = x : alterne (tail xs) 

-- question 2
combine :: (a -> b -> c) -> [a] -> [b] -> [c]
combine f x [] = []
combine f [] y = []
combine f (x:xs) (y:ys) =  (f x y) : (combine f xs ys)



-- question 3
pasPascal :: [Integer] -> [Integer]
pasPascal [] = [1]
pasPascal l = [1] ++ (zipWith (+) (tail l) (init l)) ++ [1]


-- question 4
pascal :: [[Integer]]
pascal = iterate pasPascal [1]





-- question 5
-- pointAintercaler :: Point -> Point -> Point
pointAintercaler :: Fractional a => (a,a) -> (a,a) -> (a,a)
pointAintercaler (xA, yA) (xB, yB) = ((xA + xB)/2 + (yB - yA)/2, (yA + yB)/2 + (xA - xB)/2)

-- question 6
-- pasDragon :: Path -> Path
pasDragon :: Fractional a => [(a,a)] -> [(a,a)]
pasDragon [] = []
pasDragon [xa] = [xa]
pasDragon [xa, xb] = xa : [pointAintercaler xa xb] ++ [xb]
pasDragon (xa : xb : xc : xs) =   xa
                                : (pointAintercaler xa xb)
                                : xb
                                : (pointAintercaler xc xb)
                                : (pasDragon (xc:xs))

-- question 7
dragon :: Fractional a => (a,a) -> (a,a) -> [[(a,a)]]
dragon a b = (iterate pasDragon [a,b])



-- main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

-- dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))


-- question 8
-- dragonOrdre :: Point -> Point -> Int -> Path
dragonOrdre :: Fractional a => (a,a) -> (a,a) -> Int -> [(a,a)]
dragonOrdre a b o | o <= 0  = [a, b] -- prends le cas o < 0 pour éviter une récursivité infini si l'utilisateur appelle (dragonOrdre a b (-1))
dragonOrdre a b o           = pasDragon (dragonOrdre a b (o-1))

-- question 9
-- dragonAnime a b t = Line (dragonOrdre a b (round t `mod` 20))

