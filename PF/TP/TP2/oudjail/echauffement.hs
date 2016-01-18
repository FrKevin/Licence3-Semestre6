module Main where

alterne :: [a]  -> [a]
alterne [] = []
alterne [e] = [e]
alterne (x1 : _ : xs) = x1 : (alterne xs)

combine :: (a -> b -> c) -> [a] -> [b] -> [c]
combine _ [] [] = []
combine _ [] (_ : _) = []
combine _ (_ : _) [] = []
combine fct (x1 : xs1) (x2 : xs2) = (fct x1 x2) : (combine fct xs1 xs2)

main :: IO ()
main = do
  print "Fonction alterne [1..5] -> [1, 3, 5] :"
  print (alterne [1..5])
  print "Fonction combine (+) [1, 1, 1] [1, 1, 1] -> [2, 2, 2] :"
  print (combine (+) [1, 1, 1] [1, 1, 1])
