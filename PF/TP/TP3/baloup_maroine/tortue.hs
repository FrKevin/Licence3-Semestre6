module Main where
import Graphics.Gloss

--------------------------------------------------------------------------------
------------------------------------TYPES---------------------------------------
--------------------------------------------------------------------------------

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

type EtatTortue = (Point, Float)

type Config = (EtatTortue -- État initial de la tortue
              ,Float      -- Longueur initiale d’un pas
              ,Float      -- Facteur d’échelle
              ,Float      -- Angle pour les rotations de la tortue
              ,[Symbole]) -- Liste des symboles compris par la tortue

type EtatDessin = (EtatTortue, Path)

--------------------------------------------------------------------------------
-----------------------------------FONCTIONS------------------------------------
--------------------------------------------------------------------------------

-- Etat initial
etatInitial :: Config -> EtatTortue
etatInitial (a,_,_,_,_) = a

-- Longueur pas
longueurPas :: Config -> Float
longueurPas (_,a,_,_,_) = a

-- facteur echelle
facteurEchelle :: Config -> Float
facteurEchelle (_,_,a,_,_) = a

-- angle
angle :: Config -> Float
angle (_,_,_,a,_) = a

-- symbolesTortues
symbolesTortue :: Config -> [Symbole]
symbolesTortue (_,_,_,_,a) = a


avance :: Config -> EtatTortue -> EtatTortue
avance c ((x,y),a) = ((x',y'),a)
                where x' = x + (longueurPas c) * (cos a)
                      y' = y + (longueurPas c) * (cos a)


-- Tourner à gauche
tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c (point, cap) = (point, cap')
                where cap' = cap + (angle c)

-- tourner à droite
tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c (point, cap) = (point, cap')
                where cap' = cap - (angle c)

-- Filtre symbole tortue
filtreSymboleTortue :: Config -> Mot -> Mot
filtreSymboleTortue c m = [s | s <- m, s `elem` symbolesTortue c]




main = putStrLn "Hello World"
