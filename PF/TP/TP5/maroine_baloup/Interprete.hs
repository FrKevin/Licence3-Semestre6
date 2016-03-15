module Interprete where

import Parser
import Data.Char
import Data.Maybe


type Nom = String

data Expression = Lam Nom Expression
                | App Expression Expression
                | Var Nom
                | Lit Litteral
                deriving (Show,Eq)

data Litteral = Entier Integer
              | Bool   Bool
              deriving (Show,Eq)


espacesP :: Parser ()
espacesP = zeroOuPlus (car ' ') >>= \_ -> return ()

nomP :: Parser Nom
nomP = unOuPlus (carCond isLower) >>= \x -> espacesP >>= \_ -> return x

varP :: Parser Expression
varP = nomP >>= \x -> return (Var x)

applique :: [Expression] -> Expression
applique [e] = e
applique t = App (applique ti) tl
             where ti = init t
                   tl = last t

                   