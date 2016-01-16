
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






