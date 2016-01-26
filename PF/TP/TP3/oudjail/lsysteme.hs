module LSysteme where

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

regle :: Axiome
regle = "F"
regle' :: Axiome
regle' = "F-F++F-F"

regle'' :: Axiome
regle'' = "F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F"

vonKoch :: Symbole -> Mot
vonKoch '+' = "+"
vonKoch '-' = "-"
vonKoch 'F' = regle'
vonKoch _ = fail ""

lsysteme :: Axiome -> Regles -> LSysteme
lsysteme a r = iterate (motSuivant r) a

lengthVonKoch :: Int -> Int
lengthVonKoch 0 = length regle
lengthVonKoch 1 = length regle'
lengthVonKoch 2 = length regle''
lengthVonKoch 3 = 148
lengthVonKoch _ = -1

assertVonKoch :: (Regles -> Mot -> Mot) -> Bool
assertVonKoch f = length (f vonKoch regle) == lengthVonKoch 1 &&
                  length (f vonKoch regle') == lengthVonKoch 2 &&
                  length (f vonKoch regle'') == lengthVonKoch 3

main :: IO ()
main = do
  putStrLn "motSuivant vonKoch \"F-F++F-F\" :"
  print (motSuivant vonKoch "F-F++F-F")
  putStrLn "\nmotSuivant' vonKoch \"F-F++F-F\" :"
  print (motSuivant' vonKoch "F-F++F-F")
  putStrLn "\nmotSuivant'' vonKoch \"F-F++F-F\" :"
  print (motSuivant'' vonKoch "F-F++F-F")
  putStrLn "\ntake 3 (lsysteme \"F\" vonKoch)"
  print (take 3 (lsysteme "F" vonKoch))
  putStrLn "\nassertVonKoch motSuivant :"
  print (assertVonKoch motSuivant)
