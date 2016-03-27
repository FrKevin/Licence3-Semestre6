module Mystere where

import Data.List (sort)
import Test.QuickCheck

myst :: Ord a => [a] -> [a]
myst     [] = []
myst (x:xs) = myst ys ++ (x:ws) ++ myst zs
    where ys = [ y | y <- xs, y < x]
          zs = [ z | z <- xs, z > x]
          ws = [ w | w <- xs, w == x]

propriete xs = myst xs == sort xs

propriete' (1:xs) = True
