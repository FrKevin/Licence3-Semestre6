type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

motSuivant:: Regles -> Mot -> Mot
motSuivant _ [] = []
motSuivant r (x:xs) = (r x) ++ ( motSuivant r xs)

motSuivant':: Regles -> Mot -> Mot
motSuivant' regle mot = 

motSuivant'':: Regles -> Mot -> Mot

-- Exemple
regle:: Symbole -> Mot
regle '+' = "+"
regle '-' = "-"
regle 'F' = "F-F+ +F-F"

-- motSuivant regle F
