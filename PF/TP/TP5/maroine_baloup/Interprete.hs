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
exprP = varP ||| lambdaP ||| exprParentheseeP ||| nombreP ||| booleenP

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
          \expr -> espacesP >>=
          \_ -> return (Lam (get x) expr)
   where get (Var xx) = xx
         get _ = error ""

-- question 8
exprParentheseeP :: Parser Expression
exprParentheseeP = car '(' >>=
                   \_ -> espacesP >>=
                   \_ -> exprsP >>=
                   \e -> espacesP >>=
                   \_ -> car ')' >>=
                   \_ -> espacesP >>=
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
          \e -> espacesP >>=
          \_ -> return (Lit (Entier e))

-- question 10
booleenP :: Parser Expression
booleenP = chaine "True" ||| chaine "False" >>=
           \b -> espacesP >>=
           \_ -> return (Lit (Bool (b == "True")))

-- question 11
expressionP :: Parser Expression
expressionP = espacesP >>= \_ -> exprsP >>= \x -> return x

-- question 12
ras :: String -> Expression
ras s = verif (runParser expressionP s)
        where verif Nothing = error "Erreur d'analyse syntaxique"
              verif c@(Just (r,_)) | not (complet c)  = error "Erreur d’analyse syntaxique : le parsing n'est pas terminé"
                                   | otherwise        = r



data ValeurA = VLitteralA Litteral
             | VFonctionA (ValeurA -> ValeurA)
-- question 13
--           deriving Show

-- question 14
instance Show ValeurA where
    show (VFonctionA _)          = "lambda "
    show (VLitteralA (Entier n)) = show n
    show (VLitteralA (Bool n))   = show n


-- question 15
type Environnement a = [(Nom, a)]


interpreteA :: Environnement ValeurA -> Expression -> ValeurA
interpreteA _   (Lit x)   = VLitteralA x
interpreteA env (Var x)   = fromJust (lookup x env)
interpreteA env (Lam x y) = VFonctionA (\v -> interpreteA ((x, v):env) y)
interpreteA env (App x y) = vFonctionAOrError (interpreteA env x) (interpreteA env y)
        where vFonctionAOrError (VFonctionA f) = f
              vFonctionAOrError e = error ("Erreur d'interprétation : lambda expression attendu, \"" ++ (show e) ++ "\" lu")


-- question 16
negA = VFonctionA f
       where f (VLitteralA (Entier v)) = VLitteralA (Entier (-v))
             f e = error ("Erreur d'interprétation : nombre entier attendu, \"" ++ (show e) ++ "\" lu")






























