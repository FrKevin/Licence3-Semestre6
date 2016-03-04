module Interprete where
import Parser
import Data.Char

type Nom = String

data Expression = Lam Nom Expression
                | App Expression Expression
                | Var Nom
                | Lit Litteral
                deriving (Show, Eq)

data Litteral = Entier Integer
              | Bool   Bool
              deriving (Show, Eq)

-- Executer un Parser : runParser

-- Etape 1
espaceP :: Parser ()
espaceP = zeroOuPlus (car ' ') >>= \_ -> return ()

-- Notation bis
espaceP' :: Parser ()
espaceP' = do zeroOuPlus (car ' ')
              return ()

-- Etape 2
nomP :: Parser Nom
nomP = unOuPlus (carCond isLower) >>= \x -> espaceP >>= \_ -> return x


nomP' :: Parser Nom
nomP' = do x <- unOuPlus (carCond isLower)
           espaceP
           return x

-- Etape 3
varP :: Parser Expression
varP = do x <- nomP
          return (Var x)





main :: IO ()
main = putStrLn "Hello World"
