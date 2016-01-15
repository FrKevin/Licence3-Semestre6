module Main where

-- Fonction sommeQ1, fait une somme des nombres de 1 à n
sommeQ1 :: (Num a, Enum a) => a -> a
sommeQ1 n = sum [1..n]

-- Fonction sommeDeXaY, fait une somme des entier ce trouvant entre x et y inclus
sommeDeXaY ::  Int -> Int -> Int -- Integer regroupe les deux contrainte (Num a, Ord a)
sommeDeXaY x y =
  if x >= y then
    x
  else
    x + sommeDeXaY (x+1) y

-- Fonction somme, fait une somme des entier de la liste passer en param
somme :: Num a => [a] -> a
somme [] = 0
somme (x:xs) = x + somme xs

-- Fonction mlast, donne le derniere element de la liste
mlast :: [a] -> a
mlast [a] = a
mlast xs = mlast (tail xs)

-- Fonction minit, donne la liste passer en param sans le dernier element
minit :: [a] -> [a]
minit xs = reverse (tail (reverse xs))

-- Fonction getElmSimple, donne le i-eme element de la liste passer en param
getElmSimple :: [a] -> Int ->  a
getElmSimple l i = last (take (i+1) l)

-- Fonction getElmRecA, donne le i-eme element de la liste passer en param (V2)
getElmRecA :: [a] -> Int -> Int->  a
getElmRecA l cpt i =
  if cpt == i then
    head l
  else
    getElmRecA (tail l) (cpt+1) i

-- Fonction getElmRec, encapsule l'initialisation de la fonction getElmRecA
getElmRec :: [a] -> Int ->  a
getElmRec l i = getElmRecA l 0 i

-- Fonction mplus, permet de concatener 2 liste
mplus :: [a] -> [a] -> [a]
mplus [] l = l
mplus l1 l2 = (head l1):(mplus (tail l1) l2) -- Motif non utilise, pb Indent

mmconcat :: [[a]] -> [a]
mmconcat [] = []
mmconcat (xs : xss) = xs ++ (mmconcat xss) -- Probleme de synthaxe avec mplus

mmap :: (a -> b) -> [a] -> [b]
mmap _ [] = []
mmap fct (x : xs) = (fct x) : (mmap fct xs)

-- Fonction numberOne, permet de transfomer tout objet en le chiffre un
numberOne :: a -> Int
numberOne _ = 1

-- Fonction mlenght, donne la taille d'une liste (containte etant l'utilisation des fct map, sum)
mlenght :: [a] -> Int
mlenght l = sum (map numberOne l)

applyFctN :: (a -> a) -> a -> Int -> a
applyFctN _ x 0 = x
applyFctN fct x i = applyFctN fct (fct x) (i-1)

createListeFctN :: (a -> a) -> a -> Int -> [a]
createListeFctN _ _ 0 = []
createListeFctN fct x i = (createListeFctN fct x (i-1)) ++ [(applyFctN fct x (i-1))]

createListeFctNWithIterate :: (a -> a) -> a -> Int -> [a]
createListeFctNWithIterate fct x i = take i (iterate fct x)

increment :: Int -> Int
increment x = x + 1

createListeN :: Int -> [Int]
createListeN n = createListeFctN increment 0 (n+1)

-- Foncion main, fonction executer au chargement
main :: IO ()
main = do
  print "Q1 - Result of sommeQ1 :"
  print (sommeQ1 3)
  print "-------"
  print "Q3 - Result of sommeDeXaY 1 3 :"
  print (sommeDeXaY 1 3)
  print "-------"
  print "Q4 - Result of somme [1, 2, 3] :" -- print a pour contrainte de type Show, sinon Warning
  print (somme [1, 2, 3])
  print "-------"
  print "Q5 - Result of mlast [4, 3, 2] :"
  print (mlast [4, 3, 2])
  print "-------"
  print "Q5 - Result of minit [4, 3, 2] :"
  print (minit [4, 3, 2])
  print "-------"
  print "Q6 - Result of (!!) getElmSimple [1, 42, 56, 3] :"
  print (getElmSimple [1, 42, 56, 3] 2)
  print "-------"
  print "Q6 - Result of (!!) bonus getElmRec [1, 42, 56, 3] :"
  print (getElmRec [1, 42, 56, 3] 2)
  print "-------"
  print "Q6 - Result of (++) mplus [4, 2] [6, 7] :"
  print (mplus [4, 2] [6, 7])
  print "-------"
  print "Q6 - Result of (concat) mmconcat [[1, 2], [3, 4], [5]] :"
  print (mmconcat [[1, 2], [3, 4], [5]])
  print "-------"
  print "Q6 - Result of (map) mmap abs [-1, -10, 5, -8] :"
  print (mmap abs [-1, -10, 5, -8])
  print "-------"
  print "Q7 - L'expression de |x = (!!)| 1 signifie que l'on met une fonction partielle (grace a la currification) dans |x|. Dans cette exemple on affecte a |x| la fonction |([a] -> a)|, celle ci attendra une liste en argument et renverra le premiere element."
  print "-------"
  print "Q8 - Result of mlenght ['a', 'd', 'd'] :"
  print (mlenght ['a', 'd', 'd'])
  print "-------"
  print "Q9 - Result of createListeFctN increment 1 1 :  "
  print (createListeFctN increment 1 6)
  print "-------"
  print "Q9 - Result of createListeFctNWithIterate (1+) 1 6 "
  print (createListeFctNWithIterate (1+) 1 6)
  print "-------"
  print "Q10 - Result of createListeN 8 : "
  print (createListeN 8)
