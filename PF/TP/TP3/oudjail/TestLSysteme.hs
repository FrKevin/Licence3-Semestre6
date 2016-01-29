module Main where
import LSysteme

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
