module Fizzle where

import Control.Parallel

plus1 = map (+1) [0..10]
force = plus1 `pseq` ()

{-

*Main> :sprint plus1
plus1 = _
*Main> force
()
*Main> :sprint plus1
plus1 = _ : _

-}

force' [] = ()
force' (x:xs) = x `pseq` force' xs

{-

*Main> force' plus1 
()
*Main> :sprint plus1
plus1 = [1,2,3,4,5,6,7,8,9,10,11]

-}
