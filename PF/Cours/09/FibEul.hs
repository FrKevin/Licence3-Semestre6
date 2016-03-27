module Main where

import Control.Parallel
import System.Environment (getArgs)

-- | Exemple de fonctions intenses en calcul
-- Peu nous importe ici ce qui est calculé
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

euler :: Int -> Int
euler n = length [ x | x <- [1..n-1], gcd x n == 1 ]

sumEuler :: Int -> Int
sumEuler n = sum [ euler x | x <- [1..n] ]

-- | Premier `main`, parallélisation d’un fib avec un sumEuler
verif :: Int -> Int -> Bool
verif n m = fibok `par` (eulok `pseq` fibok && eulok)
    where fibok = fib n /= 0
          eulok = sumEuler m /= 0

-- main = do args <- getArgs
--           let (n:m:_) = map read args
--           print (verif n m)

-- | Deuxième `main`, parallélisation de l’évaluation de liste
force [] = ()
force (x:xs) = x `pseq` force xs

fibs = map fib [40, 41, 42]
euls = map sumEuler [7500, 7501]
-- fibeuls = sum fibs + sum euls
fibeuls = force fibs `par`
          (force euls `pseq`
          sum fibs + sum euls)

main = print fibeuls
