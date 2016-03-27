module Types -- On explicite tout ce qu’exporte le module
             ( Point
             , bouge
             , Paire
             , duplique
             , Rayon
             , Cercle
             , Booleen
             , Reponse (..) -- le type Reponse et tous ses constructeurs
             , contredit
             , TupleEntiers (..)
             , f
             , somme
             , Message (..)
             , PeutEtre (..)
             , tete
             , Liste (..)
             , Liste' (..)
             , tete'
             , map'
             , convertit
             , Arbre (..)
             , arb1
             , mapArbre
             , foldArbre
             , somme'
             , res1
             , Arbre' (..)
             , arb2
             , arb3
             , arb4
             , valArb4
             , Point' -- mais pas MkPoint !
             , bouge' ) where

-- type String = [Char]

type Point = (Float, Float)
-- type Point = (Float, Float, Float)

bouge :: Point -> Point
-- bouge :: (Float, Float) -> (Float, Float)
bouge (x,y) = (x+1,y)

-- type Regles = Symbole -> Mot

type Paire a = (a, a)
_ = bouge :: Paire Float -> Paire Float

duplique :: a -> Paire a
duplique x = (x, x)

type Rayon = Float
type Cercle = (Point, Rayon)

-- type Arbre a = (a, Arbre a, Arbre a)

-- data Bool = True | False
data Booleen = Vrai | Faux

data Reponse = Oui | Non | PtetBenQuOuiPtetBenQuNon

contredit :: Reponse -> Reponse
contredit Oui                      = Non
contredit Non                      = Oui
contredit PtetBenQuOuiPtetBenQuNon = PtetBenQuOuiPtetBenQuNon

data TupleEntiers = Paire   Int Int
                  | Triplet Int Int Int
    deriving (Show, Eq)

f :: TupleEntiers -> Int
f (Triplet _ _ z) = z

somme :: TupleEntiers -> Int
somme (Paire n n')       = n + n'
somme (Triplet n n' n'') = n + n' + n''

data Message = Chaine String
             | Entier Integer

data PeutEtre a = Rien
                | Juste a
    deriving (Show, Eq)

tete :: [a] -> PeutEtre a
tete []    = Rien
tete (x:_) = Juste x

data Liste a = Vide
             | Cons a (Liste a)
    deriving (Show, Eq)

data Liste' a = V | a :- Liste' a
    deriving (Show, Eq)
infixr 5 :-

tete' :: Liste' a -> Maybe a
tete' V        = Nothing
tete' (x :- _) = Just x

map' :: (a -> b) -> Liste' a -> Liste' b
map' _ V         = V
map' f (x :- xs) = f x :- map' f xs

convertit :: [a] -> Liste' a
convertit = foldr (:-) V

data Arbre a = Noeud a [Arbre a]
    deriving (Show, Eq)

arb1 :: Num a => Arbre a
arb1 = Noeud 12 []

mapArbre :: (a -> b) -> Arbre a -> Arbre b
mapArbre f (Noeud x fils) =
    Noeud (f x) (map (mapArbre f) fils)

foldArbre :: (a -> [b] -> b) -> Arbre a -> b
foldArbre f (Noeud x fils) = f x (map (foldArbre f) fils)

somme' :: Num a => Arbre a -> a
somme' = foldArbre (\n ns -> n + sum ns)

res1 = somme' (Noeud 12 [Noeud 45 [], Noeud 56 [Noeud 78 []]])

data Arbre' a = Noeud' { valeur :: a
                       , gauche :: Arbre' a
                       , droit  :: Arbre' a }
              | Feuille
    deriving (Show, Eq)

arb2 = Noeud' 12 Feuille Feuille
arb3 = Noeud' { valeur = 12
              , gauche = Feuille
              , droit  = Feuille }
arb4 = arb3 { valeur = 34 }
valArb4 = valeur arb4

newtype Point' = MkPoint (Float, Float)
-- newtype est un cas particulier de data, pas de confusion possible
-- avec le type (Float, Float), contrairement à une déclaration avec
-- « type »
-- L’expression suivante est du coup mal typée
-- _ = bouge :: Point' -> Point'
bouge' (MkPoint (x, y)) = MkPoint (x+1, y)
