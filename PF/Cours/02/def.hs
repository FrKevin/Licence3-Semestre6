module Definitions where

absolue :: Integer -> Integer
absolue n = if n >= 0
                then n
                else (-n)

{- Définition avec
 - des if imbriqués
 -}
signe :: Integer -> Integer
signe n = if n > 0
            then 1
            else if n == 0
                    then 0
                    else -1

pairSuivant :: Integer -> Integer
pairSuivant n = n + 1 + if n `mod` 2 == 0
                            then 1
                            else 0

-- Définition avec gardes
signe' :: Integer -> Integer
signe' n | n > 0     = 1
         | n == 0    = 0
         | otherwise = -1

non :: Bool -> Bool
non True  = False
non False = True

(&&&) :: Bool -> Bool -> Bool
-- (&&&) True True = True
True  &&& True  = True
True  &&& False = False
False &&& True  = False
False &&& False = False

(&&&&) :: Bool -> Bool -> Bool
True &&&& True = True
_    &&&& _    = False
-- a    &&&& b    = False

(&&&&&) :: Bool -> Bool -> Bool
b &&&&& True = b
_ &&&&& _    = False

(&&&&&&) :: Bool -> Bool -> Bool
-- b &&&&&& b = b
b &&&&&& b' | b == b' = b
_ &&&&&& _            = False

tete :: [a] -> a
tete (x:_) = x
tete [] = -- undefined
          error "liste vide"

decompose :: [a] -> (a, [a])
decompose tous@(x:_) = (x, tous)

troisieme :: [a] -> a
-- troisieme (_:(_:(x:_))) = x
troisieme (_:_:x:_) = x

tete' :: [[t]] -> t
tete' ((x:_):_) = x

cas :: [t] -> String
cas []        = "zéro"
cas [_]       = "un"
cas [_,_]     = "deux"
cas (_:_:_:_) = "au moins trois"

eclair :: [a] -> [b] -> [(a,b)]
eclair     []      _ = []
eclair      _     [] = []
eclair (x:xs) (y:ys) = (x,y) : eclair xs ys

decomposePaire :: (a, b) -> a
decomposePaire (x, _) = x

-- eclair x y = x

impairs :: [Integer]
impairs = map f [0..]
    where f x = 2 * x + 1

impairs' :: [Integer]
impairs' = let f x = 2 * x + 1
           in  map f [0..]

impairs'' :: [Integer]
impairs'' = map (\x -> 2 * x + 1) [0..]

f :: Int -> String
f i = replicate i 'a' ++ "h !"

f' :: Int -> String
f' = \i -> replicate i 'a' ++ "h !"

carrés :: [Integer]
carrés = map (^ 2) [0..10]

puissancesDeux :: [Integer]
puissancesDeux = map (2 ^) [0..10]
