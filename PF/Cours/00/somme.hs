module Somme where

somme n = sum [1..n]

somme' n = sum (enumFromTo 1 n)

sommePairs n = sum [0,2..n]

sommeImpairs n = sum [1,3..n]

sommeCarres n = sum (map (^2) [1..n])
