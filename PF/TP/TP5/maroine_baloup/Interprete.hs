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


-- question 1
espacesP :: Parser ()
espacesP = zeroOuPlus (car ' ') >>= \_ -> return ()

-- question 2
nomP :: Parser Nom
nomP = unOuPlus (carCond isLower) >>= \x -> espacesP >>= \_ -> return x

-- question 3
varP :: Parser Expression
varP = nomP >>= \x -> return (Var x)

-- question 4
applique :: [Expression] -> Expression
applique [e] = e
applique t = App (applique ti) tl
             where ti = init t
                   tl = last t

-- question 5
exprP :: Parser Expression
exprP = varP ||| lambdaP ||| exprParentheseeP

exprsP :: Parser Expression
exprsP = unOuPlus exprP >>= \x -> return (applique x)

--question 6
lambdaP :: Parser Expression
lambdaP = car '\\' >>=
          \_ -> espacesP >>=
          \_ -> varP >>=
          \x -> espacesP >>=
          \_ -> car '-' >>=
          \_ -> car '>' >>=
          \_ -> espacesP >>=
          \_ -> exprsP >>=
          \expr -> return (Lam (get x) expr)
   where get (Var xx) = xx
         get _ = error ""

-- question 8
exprParentheseeP :: Parser Expression
exprParentheseeP = car '(' >>=
          \_ -> exprsP >>=
          \e -> car ')' >>=
          \_ -> return e

-- Question 9
chiffre :: Parser Char
chiffre = carCond isDigit

nombre :: Parser String
nombre = unOuPlus chiffre

entier :: Parser Integer
entier = nombre >>=
         \n -> return (read n)

nombreP :: Parser Expression
nombreP = entier >>=
          \e -> return (Lit (Entier e))
