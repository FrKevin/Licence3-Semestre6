module Main where

-- Echauffement
---- Alterne
alterne :: [t] -> [t]
alterne [] = []
alterne (t:_:v:q) = t : alterne (v:q)
alterne (t:_) = [t]

---- Combine
combine :: (a->b->c)->[a]->[b]->[c]
combine _ _ [] = []
combine _ [] _ = []
combine f [t1] [t2] = [f t1 t2]
combine f (t1:q1) (t2:q2) = f t1 t2 : combine f  q1 q2


-- Pascal

pasPascal :: [Integer]->[Integer]
pasPascal [] = [1]
pasPascal l = 1 : combine (+) (init l) (tail l) ++ [1]

pascal :: [[Integer]]
pascal = iterate pasPascal []

main :: IO ()
main = putStrLn "Hello World"
