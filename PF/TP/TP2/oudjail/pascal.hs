module Main where

pasPascal :: [Int] -> [Int]
pasPascal [] = [1]
pasPascal l = [1] ++ (zipWith (+) (tail l) (init l)) ++ [1]

pascal :: [[Int]]
pascal = (iterate pasPascal [])

main :: IO ()
main = do
  print "Pascal 1 a 10 :"
  print (take 10 (pascal))
