module TestTortue where
import Tortue

testEtatInitial :: Bool
testEtatInitial = (etatInitial iConfig) == iEtat

testLongueurPas :: Bool
testLongueurPas = (longueurPas iConfig) == iLongueur

testFacteurEchelle :: Bool
testFacteurEchelle = (facteurEchelle iConfig) == iFacteurE

testAngle :: Bool
testAngle = (angle iConfig) == iAngle

testSymboleTortue :: Bool
testSymboleTortue = (symbolesTortue iConfig ) == iSymboles

exeptedAvance :: EtatTortue
exeptedAvance = ((-50.0,0.0),0.0)



mainTest :: IO ()
mainTest = do
  putStrLn "testEtatInitial :"
  print (testEtatInitial)
  putStrLn "\ntestLongueurPas :"
  print (testLongueurPas)
  putStrLn "\ntestFacteurEchelle :"
  print (testFacteurEchelle)
  putStrLn "\ntestAngle :"
  print (testAngle)
  putStrLn "\ntestSymboleTortue :"
  print (testSymboleTortue)
  print (avance iConfig iEtat)
