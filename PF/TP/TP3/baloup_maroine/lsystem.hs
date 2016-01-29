module Main where

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

user1 = "Maxime"
user2 = "Marc"

-- Classique récursive
motSuivant :: Regles -> Mot -> Mot
motSuivant _ [] = []
motSuivant r (x:xs) = r x ++ motSuivant r xs

-- Liste de compréhention
motSuivant' :: Regles -> Mot -> Mot
motSuivant' r m = concat [r i | i <- m]

-- Fonction bien choisie
motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' r m = concatMap r m

regle :: Axiome
regle = "F-F++F-F"

vonKoch :: Regles
vonKoch '+' = "+"
vonKoch '-' = "-"
vonKoch 'F' = regle

lsysteme :: Axiome -> Regles -> LSysteme
-- lsysteme :: [Char] -> (Char -> [Char]) -> [[Char]]
lsysteme a r = iterate (motSuivant r) a


tailleVonKoch :: Int -> Int
tailleVonKoch n = length ((lsysteme "F" vonKoch) !! n)


main :: IO()
main = do

putStrLn ("Salut " ++ user1 ++ " et " ++ user2)
