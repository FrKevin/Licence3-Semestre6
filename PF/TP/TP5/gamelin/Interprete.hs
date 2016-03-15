import Data.Char
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

espaceP :: Parser ()
espaceP = zeroOuPlus (car ' ') >>= \_ -> return ()

nomP :: Parser Nom
nomP = do x <- unOuPlus (carCond isLower)
          espaceP
          return x

varP :: Parser Expression
varP = do x <- nomP
          return (Var x)

applique :: [Expression] -> Expression
applique [e] = e
applique [e1, e2] = App e1 e2
applique (x:xs) = App exp (last xs)
  where exp = applique (x:init xs)

applique' :: [Expression] -> Expression
applique' = foldl1 App


exprsP = unOuPlus varP  >>= \x -> return ( applique x )

lambdaP :: Parser Expression
lambdaP = car '\\' >>=
          \_ ->  car 'x' >>=
          \_  -> car ' ' >>=
          \_ ->  car '-' >>=
          \_ ->  car '>' >>=
          \_ ->  car ' ' >>=
          \_ ->  exprsP >>=
          \exp -> return (Lam "x" exp)

exprP :: Parser Expression
exprP = lambdaP ||| varP

exprParentheseeP :: Parser Expression

main :: IO ()
main = do
  print "fejfjojejjo"
