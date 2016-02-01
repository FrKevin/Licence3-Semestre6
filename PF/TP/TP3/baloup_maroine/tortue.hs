module Tortue where

import Graphics.Gloss
import LSystem

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
filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue c m = [s | s <- m, s `elem` symbolesTortue c]

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (etat, path) 'F' = (etat', path ++ [fst etat'])
                where etat' = avance c etat

interpreteSymbole c (etat, path) '+' = (etat', path ++ [fst etat'])
                where etat' = tourneAGauche c etat

interpreteSymbole c (etat, path) '-' = (etat', path ++ [fst etat'])
                where etat' = tourneADroite c etat


interpreteMot :: Config -> Mot -> Picture
interpreteMot c m = line (snd (foldl (interpreteSymbole c) iE mF))
    where iP = fst (etatInitial c)
          iE = (etatInitial c, [iP])
          mF = filtreSymbolesTortue c m

vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

vonKoch2 :: LSysteme
vonKoch2 = lsysteme "F++F++F++" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

hilbert :: LSysteme
hilbert = lsysteme "X" regles
    where regles 'X' = "+YF-XFX-FY+"
          regles 'Y' = "-XF+YFY+FX-"
          regles  s  = [s]

dragon :: LSysteme
dragon = lsysteme "FX" regles
    where regles 'X' = "X+YF+"
          regles 'Y' = "-FX-Y"
          regles  s  = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1/3, pi/3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1/2, pi/2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi/2, "F+-")




dessin = interpreteMot (((-150,0),0),100,1,pi/3,"F+-") "F+F--F+F"

main :: IO()

main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin
