type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

-- Exemple
regle:: Symbole -> Mot
regle '+' = "+"
regle '-' = "-"
regle 'F' = "F-F++F-F"

-- 1) Définissez la fonction motSuivant :: Regles -> Mot -> Mot qui prend en argument les règles d’un L-système et un mot un et calcule le mot un + 1.
motSuivant:: Regles -> Mot -> Mot
motSuivant _ [] = []
motSuivant r (x:xs) = (r x) ++ ( motSuivant r xs)

motSuivant' :: Regles -> Mot -> Mot
motSuivant' r m = concat [(r x) | x <- m]

motSuivant'':: Regles -> Mot -> Mot
motSuivant'' r m = concat (map r m)

-- 2) Pour vérifier vos fonctions, vous définirez la règle pour le L-système du flocon de von Koch
vonKoch:: Symbole -> Mot
vonKoch '+' = "+"
vonKoch '-' = "-"
vonKoch 'F' = "F-F++F-F"


gennerate_vonKoch = iterate (motSuivant vonKoch) ['F']

-- 3) Définissez une fonction lsysteme :: Axiome -> Regles -> LSysteme qui calcule le L-système défini par l’axiome et les règles données.
lsysteme :: Axiome -> Regles -> LSysteme
lsysteme a r = iterate (motSuivant r) a

main :: IO ()
main = do
    print ("Mot suivant de F (avec la recursivite) ")
    print ( motSuivant regle ['F'])
    print ("Mot suivant de F (avec une liste en comprehension) ")
    print ( motSuivant' regle ['F'])
    print ("Mot suivant de F (avec une fonction bien choisie du Prelude.) ")
    print ( motSuivant'' regle ['F'])
    print ("Generation des 3 premiers mots du flocon de von Koch")
    print (take 3 gennerate_vonKoch)
