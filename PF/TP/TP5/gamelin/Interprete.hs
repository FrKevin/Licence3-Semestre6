import Parser

type Nom = String

data Expression = Lam Nom Expression
                | App Expression Expression
                | Var Nom
                | Lit Litteral
                deriving (Show,Eq)

data Litteral = Entier Integer
              | Bool   Bool
              deriving (Show,Eq)

espacesP:: String -> Parser ()
espacesP ""  = return ()
espacesP (c:cs) = if c == ' ' then
                    espacesP cs
                  else return ()



main :: IO ()
main = do
  print "fejfjojejjo"
