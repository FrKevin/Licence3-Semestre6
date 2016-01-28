module Tortue where
import  Graphics.Gloss
import  LSysteme

type EtatTortue = (Point, Float)

type Config = (EtatTortue -- État initial de la tortue
              ,Float      -- Longueur initiale d’un pas
              ,Float      -- Facteur d’échelle
              ,Float      -- Angle pour les rotations de la tortue
              ,[Symbole]) -- Liste des symboles compris par la tortue

type EtatDessin = ([EtatTortue], [Path])

iEtat :: EtatTortue
iEtat = ((-150.0, 0.0), 0.0)

iLongueur :: Float
iLongueur = 100.0

iFacteurE :: Float
iFacteurE = 1.0

iAngle :: Float
iAngle = pi/3

iSymboles :: [Symbole]
iSymboles = "F+-[]"

iConfig :: Config
iConfig = (iEtat, iLongueur, iFacteurE, iAngle, iSymboles)

etatInitial :: Config -> EtatTortue
etatInitial (c, _, _, _, _) = c

longueurPas :: Config -> Float
longueurPas (_, lp, _, _, _) = lp

facteurEchelle :: Config -> Float
facteurEchelle (_, _, fe, _, _) = fe

angle :: Config -> Float
angle (_, _, _, a, _) = a

symbolesTortue :: Config -> [Symbole]
symbolesTortue (_, _, _, _, s) = s


avance :: Config -> EtatTortue -> EtatTortue
avance c ((x, y), cap) = ((x', y'), cap)
                        where
                          x' = x + longueurPas c * cos cap
                          y' = y + longueurPas c * sin cap

tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c (point, cap) = (point, cap')
                        where
                          cap' = cap + angle c

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c (point, cap) = (point, cap')
                        where
                          cap' = cap - angle c

filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue c m = [s | s <- m, s `elem` symbolesTortue c]


interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (etat:lE, path:lP) s
      | s == 'F' = ([eAvance], [dAvance])
      | s == '+' = ([eTourneAGauche], [dTourneAGauche])
      | s == '-' = ([eTourneADroite], [dTourneADroite])
      | s == '[' = (etat:lE, path:lP)
      | s == ']' = (head lE, head lP)
      | otherwise = error "Symbole not match"
      where eAvance = avance c etat
            eTourneADroite = tourneADroite c etat
            eTourneAGauche = tourneAGauche c etat
            dAvance = path ++ [fst eAvance]
            dTourneADroite = path ++ [fst eTourneADroite]
            dTourneAGauche = path ++ [fst eTourneAGauche]

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

lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime ls c t = interpreteMot conf (ls !! enieme)
  where enieme = round t `mod` 10
        conf = case c of
          (e, p, fE, a, s) -> (e, p * (fE ^ enieme), fE, a, s)

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1/3, pi/3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1/2, pi/2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi/2, "F+-")

dessin :: Picture
dessin = interpreteMot (((-150,0),0),100,1,pi/3,"F+-") "F+F--F+F"

main :: IO ()
main = animate (InWindow "L-systeme" (1000, 1000) (0, 0)) white hilbertAnime
