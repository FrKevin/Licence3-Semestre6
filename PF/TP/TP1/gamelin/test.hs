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

-- ++
mplus:: [a] -> [a] -> [a]
mplus [] l = l
mplus l1 l2 = (head l1):(mplus (tail l1) l2)

-- concat
mmconcat:: [[a]] -> [a]
mmconcat [] = []
mmconcat (xs : xss) = xs ++ (mmconcat xss)

-- map applique une fonction un l'ensemble des éléments de la liste
mmap:: (a -> b) -> [a] -> [b]
mmap _ [] = []
mmap fct (x : xs) = (fct x) : (mmap fct xs)

-- Utilisez map et somme pour définir une fonction calculant la longueur d’une liste
-- 1) la fonction f 
castListToOne:: a -> Int
castListToOne _ = 1

-- 2 on appel la fonction map
mlenght:: [a] -> Int
mlenght l = sum (map castListToOne l)
