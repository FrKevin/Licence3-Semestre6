module Pascal where

-- Fonction qui permet de calculer la ligne i+1 du triangle de pascal en fournissant la ligne i
pasPascal :: [Int] -> [Int]
pasPascal [] = [1]
pasPascal l = [1] ++ zipWith (+) (tail l) (init l) ++ [1]

-- Fonction qui genere le triangle de pascal de maniere infini en appelant la fonction ci dessus
pascal :: [[Int]]
pascal = iterate pasPascal []

main :: IO ()
main = do
  print "Pascal 1 a 10 :"
  print (take 10 pascal)
