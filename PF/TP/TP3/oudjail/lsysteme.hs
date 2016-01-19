module Main where

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

motSuivant :: Regles -> Mot -> Mot
motSuivant _ [] = []
motSuivant r (x:xs) = (r x) ++ (motSuivant r xs)

motSuivant' :: Regles -> Mot -> Mot
motSuivant' r m = concat [(r x) | x <- m]

motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' r m = concat (map r m)

axiome :: Axiome
axiome = "F"

axiome' :: Axiome
axiome' = "F-F++F-F"

axiome'' :: Axiome
axiome'' = "F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F"

regle :: Symbole -> Mot
regle '+' = "+"
regle '-' = "-"
regle 'F' = axiome'
regle _ = fail ""

lsysteme :: Axiome -> Regles -> LSysteme
lsysteme a r = iterate (motSuivant r) a



lengthVonKoch :: Int -> Int
lengthVonKoch 0 = length axiome
lengthVonKoch 1 = length axiome'
lengthVonKoch 2 = length axiome''
lengthVonKoch 3 = 148
lengthVonKoch _ = -1

assertVonKoch :: (Regles -> Mot -> Mot) -> Bool
assertVonKoch f = length (f regle axiome) == lengthVonKoch 1 &&
                  length (f regle axiome') == lengthVonKoch 2 &&
                  length (f regle axiome'') == lengthVonKoch 3

main :: IO ()
main = do
  putStrLn "motSuivant regle \"F-F++F-F\" :"
  print (motSuivant regle "F-F++F-F")
  putStrLn "\nmotSuivant' regle \"F-F++F-F\" :"
  print (motSuivant' regle "F-F++F-F")
  putStrLn "\nmotSuivant'' regle \"F-F++F-F\" :"
  print (motSuivant'' regle "F-F++F-F")
  putStrLn "\ntake 3 (lsysteme \"F\" regle)"
  print (take 3 (lsysteme "F" regle))
  putStrLn "\nassertVonKoch motSuivant :"
  print (assertVonKoch motSuivant)
