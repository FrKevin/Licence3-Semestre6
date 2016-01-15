f :: Num a => a -> a
f x = 3 * x



sommeDeXaY :: (Num a, Ord a) => a -> a -> a
sommeDeXaY x y =
  if x > y then 0
  else x + sommeDeXaY (x+1) y


somme :: Num a => [a] -> a
somme [] = 0
somme (x:xs) = x + somme xs

-- Prends le dernier element de la liste
myLast :: [a] -> a
myLast [a] = a
myLast (x:xs) = head (reverse xs)

-- init prends tous les éléments de la liste sauf le dernier
myInit :: [a] -> [a]
myInit xs =   reverse (tail (reverse xs))




-- !!  prend le ième élément take limite-1
getIemeElement :: [a] -> Int -> a
getIemeElement l i = last (take (i+1) l)



-- concat :: [[a]] -> [a]
myConcat :: [[a]] -> [a]
myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs


myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = [(f x)] ++ (myMap f xs)




-- question 7 : représente une fonction qui prend en paramètre une position du tableau l, et retourne la valeur à la position donnée.



longueurListe :: [a] -> Int
longueurListe t = somme (map (\x -> 1) t)



-- question 9
listeFN :: (a -> a) -> a -> Int -> [a]
listeFN f x n = if n<=0
            then []
            else x : listeFN f (f x) (n-1)

-- question 10

listeEntiers :: Int -> [Int]
listeEntiers n = listeFN (\x -> x + 1) 0 (n+1)

main :: IO()
main = do
 print ""

