-- MAROINE BALOUP TP3 LSysteme

module LSysteme where

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

-- Classique récursive
motSuivant :: Regles -> Mot -> Mot
motSuivant _ [] = []
motSuivant r (x:xs) = r x ++ motSuivant r xs

-- Liste de compréhention
motSuivant' :: Regles -> Mot -> Mot
motSuivant' r m = concat [r i | i <- m]

-- Fonction bien choisie
motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' = concatMap

-- Regle pour le remplacement de F
regle :: Axiome
regle = "F-F++F-F"

-- Déclaration des règles de vonKoch
vonKoch :: Regles
vonKoch '+' = "+"
vonKoch '-' = "-"
vonKoch 'F' = regle

-- lsysteme :: [Char] -> (Char -> [Char]) -> [[Char]] pour une meilleure compréhension
lsysteme :: Axiome -> Regles -> LSysteme
lsysteme a r = iterate (motSuivant r) a

-- Permet de voir la taille d'une exécution de vonKoch à un n donné
tailleVonKoch :: Int -> Int
tailleVonKoch n = length (lsysteme "F" vonKoch !! n)
