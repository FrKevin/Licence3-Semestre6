module Interprete where

import Parser
import Data.Char
import Data.Maybe
import System.Exit


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
exprsP = unOuPlus exprP >>= \x
         -> return (applique x)

--question 6
lambdaP :: Parser Expression
lambdaP =    car '\\' >>= \_
          -> espacesP >>= \_
          -> varP     >>= \x
          -> espacesP >>= \_
          -> car '-'  >>= \_
          -> car '>'  >>= \_
          -> espacesP >>= \_
          -> exprsP   >>= \expr
          -> espacesP >>= \_
          -> return (Lam (get x) expr)
   where get (Var v) = v

-- question 8
exprParentheseeP :: Parser Expression
exprParentheseeP =    car '('  >>= \_
                   -> espacesP >>= \_
                   -> exprsP   >>= \e
                   -> espacesP >>= \_
                   -> car ')'  >>= \_
                   -> espacesP >>= \_
                   -> return e

-- Question 9
chiffre :: Parser Char
chiffre = carCond isDigit

nombre :: Parser String
nombre = unOuPlus chiffre

entier :: Parser Integer
entier =    nombre >>= \n
         -> return (read n)

nombreP :: Parser Expression
nombreP =    entier   >>= \e
          -> espacesP >>= \_
          -> return (Lit (Entier e))

-- question 10
booleenP :: Parser Expression
booleenP =    chaine "True" ||| chaine "False" >>= \b
           -> espacesP                         >>= \_
           -> return (Lit (Bool (b == "True")))

-- question 11
expressionP :: Parser Expression
expressionP =    espacesP >>= \_
              -> exprsP   >>= \x
              -> return x

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
    show (VFonctionA _)          = "lambda"
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
negA :: ValeurA
negA = VFonctionA f
       where f (VLitteralA (Entier v)) = VLitteralA (Entier (-v))
             f e = error ("Erreur d'interprétation : nombre entier attendu, \"" ++ (show e) ++ "\" lu")

-- question 17
addA :: ValeurA
addA = VFonctionA f
       where f (VLitteralA (Entier x)) = VFonctionA g
                    where g (VLitteralA (Entier y)) = VLitteralA (Entier (x + y))
                          g e = error ("Erreur d'interprétation : nombre entier attendu, \"" ++ (show e) ++ "\" lu")
             f e = error ("Erreur d'interprétation : nombre entier attendu, \"" ++ (show e) ++ "\" lu")

-- question 18
releveBinOpEntierA :: (Integer -> Integer -> Integer) -> ValeurA
releveBinOpEntierA op = VFonctionA f
       where f (VLitteralA (Entier x)) = VFonctionA g
                    where g (VLitteralA (Entier y)) = VLitteralA (Entier (op x y))
                          g e = error ("Erreur d'interprétation : nombre entier attendu, \"" ++ (show e) ++ "\" lu")
             f e = error ("Erreur d'interprétation : nombre entier attendu, \"" ++ (show e) ++ "\" lu")

envA :: Environnement ValeurA
envA = [ ("neg",   negA)
       , ("add",   releveBinOpEntierA (+))
       , ("soust", releveBinOpEntierA (-))
       , ("mult",  releveBinOpEntierA (*))
       , ("quot",  releveBinOpEntierA quot)
       , ("if",    ifthenelseA) ]


-- question 19
ifthenelseA :: ValeurA
ifthenelseA = VFonctionA f
            where f (VLitteralA (Bool x)) = VFonctionA g
                    where g (VLitteralA y) = VFonctionA h
                            where h (VLitteralA z) = VLitteralA (if x then y else z)
                                  h e = error ("Erreur d'interprétation : valeur litteral attendu, \"" ++ (show e) ++ "\" lu")
                          g e = error ("Erreur d'interprétation : valeur litteral attendu, \"" ++ (show e) ++ "\" lu")
                  f e = error ("Erreur d'interprétation : booléen attendu, \"" ++ (show e) ++ "\" lu")


-- question 20
main :: IO()
main = do putStr "minilang> "
          cmd <- getLine
          if (length cmd == 0) then
            exitSuccess
          else
            print (interpreteA envA (ras cmd))
          main





-- gestion d'erreur


-- question 21
data ValeurB = VLitteralB Litteral
             | VFonctionB (ValeurB -> ErrValB)

type MsgErreur = String
type ErrValB   = Either MsgErreur ValeurB

instance Show ValeurB where
    show (VFonctionB _)          = "lambda"
    show (VLitteralB (Entier n)) = show n
    show (VLitteralB (Bool n))   = show n

-- question 22
interpreteB :: Environnement ValeurB -> Expression -> ErrValB
interpreteB _   (Lit x)   = Right (VLitteralB x)
interpreteB env (Var x)   = case lookup x env of
                                    Nothing -> Left ("Erreur d'interprétation : la variable " ++ x ++ " n'est pas défini")
                                    Just v  -> Right v
interpreteB env (Lam x y) = Right (VFonctionB (\v -> interpreteB ((x, v):env) y))
interpreteB env (App x y) = case interpreteB env x of
                                    e@(Left _) -> e
                                    Right (VFonctionB f) -> case (interpreteB env y) of
                                                                    e@(Left _) -> e
                                                                    Right v    -> f v
                                    Right e -> Left ("Erreur d'interprétation : fonction attendu, mais " ++ (show e) ++ " trouvé")



























