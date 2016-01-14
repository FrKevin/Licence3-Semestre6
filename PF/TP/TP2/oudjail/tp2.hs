module Main where

alterne:: [a]  -> [a]
alterne [] = []
alterne [e] = [e]
alterne (x1 : _ : xs) = x1 : (alterne xs)

combine:: (a -> b -> c) -> [a] -> [b] -> [c]
combine _ [] [] = []
combine _ [] (_ : _) = []
combine _ (_ : _) [] = []
combine fct (x1 : xs1) (x2 : xs2) = (fct x1 x2) : (combine fct xs1 xs2)

pasPascal:: [Int] -> [Int]
pasPascal [] = [1]
pasPascal l = [1] ++ (zipWith (+) (tail l) (init l)) ++ [1]

pascal:: [[Int]]
pascal = (iterate pasPascal [])


main :: IO ()
main = do
  print "Q1 - "
  print (alterne [1, 2, 3])
