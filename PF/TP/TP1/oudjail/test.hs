module Main where


sommeDeXaY:: (Num a, Ord a) => a -> a -> a
sommeDeXaY x y = if x >= y
  then x
  else x + sommeDeXaY (x+1) y

somme:: [Int] -> Int
somme [] = 0
somme (x:xs) = x + somme xs

mlast:: [a] -> a
mlast [a] = a
mlast xs = mlast (tail xs)

minit:: [a] -> [a]
minit xs = reverse (tail (reverse xs))

getElmSimple:: [a] -> Int ->  a
getElmSimple l i = last (take (i+1) l)

getElmRecA:: [a] -> Int -> Int->  a
getElmRecA l cpt i = if cpt == i
  then head l
  else getElmRecA (tail l) (cpt+1) i



getElmRec:: [a] -> Int ->  a
getElmRec l i = getElmRecA l 0 i

mplus:: [a] -> [a] -> [a]
mplus [] l = l
mplus l1 l2 = (last l1):(mplus (init l1) l2)



main :: IO ()
main = do
  print (somme [1, 2, 3])
  print (sommeDeXaY 1 3)
