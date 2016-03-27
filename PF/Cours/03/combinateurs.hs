module Combinateurs where

import           Data.Char (isLower)

add :: Int -> Int -> Int
add x y = x + y

ex1 :: Int -> Int
ex1 = add 1
-- ex1 y = add 1 y

deuxfois :: (a -> a) -> a -> a
deuxfois f x = f (f x)

ex2 = deuxfois (2 *) 2

stupide :: [a] -> [a]
stupide = deuxfois reverse

map' :: (a -> b) -> [a] -> [b]
map' f xs = [ f x | x <- xs ]

map'' :: (a -> b) -> [a] -> [b]
map'' _ []     = []
map'' f (x:xs) = f x : map'' f xs

ex3 = map reverse ["auie", "sreeop"]
ex3' = reverse ["auie", "sreeop"]

ex4 = map (map (1+)) [ [1..4], [6..9] ]
ex5 = sum (map sum [ [1..4], [6..9] ])

et :: [Bool] -> Bool
et []     = True
et (b:bs) = b && et bs

ex6  = et (map isLower "auieAUIEauieAUIE")
ex6' = et (map isLower "auieα")

filtre :: (a -> Bool) -> [a] -> [a]
filtre _ []                 = []
filtre p (x:xs) | p x       = x : filtre p xs
                | otherwise = filtre p xs

filtre' p xs = [ x | x <- xs, p x ]

ex7 = filtre isLower "auieAUIEauieAUIE"
ex8 = filtre even [1..]

trirapide :: (a -> a -> Ordering) -> [a] -> [a]
trirapide _       [] = []
trirapide cmp (x:xs) = trirapide cmp ys
                    ++ [x]
                    ++ trirapide cmp zs
    where ys = [ y | y <- xs, y `cmp` x == LT ]
          zs = [ z | z <- xs, z `cmp` x /= LT ]

ex9 = trirapide compare [43,21,1,212]

compareInverse x y = case compare x y of
                       LT -> GT
                       EQ -> EQ
                       GT -> LT

ex9' = trirapide compareInverse [43,21,1,212]
ex9'' = trirapide (\x y -> compare y x) [43,21,1,212]

inverse :: (a -> b -> c) -> b -> a -> c
inverse f x y = f y x

ex9''' = trirapide (inverse compare) [43,21,1,212]
ex9'''' = trirapide (flip compare) [43,21,1,212]

-- flip f a

trirapidestandard :: Ord a => [a] -> [a]
trirapidestandard = trirapide compare


somme []     = 0
somme (n:ns) = n + somme ns

produit [] = 1
produit (n:ns) = n * produit ns

generique :: (b -> a -> a) -> a -> [b] -> a
generique _  v []     = v
generique op v (x:xs) = x `op` generique op v xs

somme'   = generique (+) 0
produit' = generique (*) 1
et'      = generique (&&) True

longueur []     = 0
longueur (_:xs) = 1 + longueur xs

longueur' xs = sum (map (\_ -> 1) xs)

longueur'' :: [a] -> Integer
longueur'' = foldr (\_ l -> l + 1) 0

generique' :: (a -> b -> a) -> a -> [b] -> a
generique' f v [] = v
generique' f v (x:xs) = generique' f (f v x) xs
-- foldl

ex10 = foldr (^) 2 [2,2,2]
ex11 = foldl (^) 2 [2,2,2]

o :: (b -> a) -> (c -> b) -> c -> a
f `o` g = \x -> f (g x)

pair :: Integer -> Bool
pair = even

impair :: Integer -> Bool
impair = not . pair
-- impair n = not (pair n)

-- sort | uniq | head
ex12 = take 10 . nub . sort
