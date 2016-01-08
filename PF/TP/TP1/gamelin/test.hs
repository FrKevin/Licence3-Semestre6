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
