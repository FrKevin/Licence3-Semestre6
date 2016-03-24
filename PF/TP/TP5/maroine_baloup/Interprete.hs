module Interprete where

import Parser
import Data.Char
import Data.Maybe
import System.Exit
import Control.Monad


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
              verif c@(Just (r,_)) | not (complet c)  = error "Erreur d'analyse syntaxique : le parsing n'est pas terminé"
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


-- la "trace d'exécution" qui suit a pour but de comprendre pourquoi l'interprétation de
-- l'expression "(\\x -> x x)(\\x -> x x)" boucle indéfiniment.
-- en haskell de base, l'exécution de ce bout de code provoque une erreur : (\x -> x x)

-- interpreteA [] (App (Lam "x" (App (Var "x") (Var "x"))) (Lam "x" (App (Var "x") (Var "x"))))
--  -- interpreteA [] (Lam "x" (App (Var "x") (Var "x")))
--      -- return VFonctionA (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x")))
--  -- interpreteA [] (Lam "x" (App (Var "x") (Var "x")))
--      -- return VFonctionA (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x")))
--  -- (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x"))) (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x")))
--  |   -- interpreteA [("x", (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x"))))] (App (Var "x") (Var "x"))
--  |       -- interpreteA [("x", (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x"))))] (Var "x")
--  |           -- return VFonctionA (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x")))
--  |       -- interpreteA [("x", (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x"))))] (Var "x")
--  |           -- return VFonctionA (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x")))
--  |------ -- (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x"))) (\v -> interpreteA [("x", v)] (App (Var "x") (Var "x")))
-- On a ici une boucle récursive, ce qui explique la boucle infini lors de l'interprétation de l'expression


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
                                    e@(Left _)           -> e
                                    Right (VFonctionB f) -> case (interpreteB env y) of
                                                                    e@(Left _) -> e
                                                                    Right v    -> f v
                                    Right e              -> Left ("Erreur d'interprétation : fonction attendu, mais " ++ (show e) ++ " trouvé")


-- question 23
addB :: ValeurB
addB = VFonctionB f
       where f (VLitteralB (Entier x)) = Right (VFonctionB g)
                    where g (VLitteralB (Entier y)) = Right (VLitteralB (Entier (x + y)))
                          g e                       = Left ("Erreur d'interprétation (addB) : nombre entier attendu en deuxième paramètre, mais " ++ (show e) ++ " trouvé")
             f e = Left ("Erreur d'interprétation (addB) : nombre entier attendu en premier paramètre, mais " ++ (show e) ++ " trouvé")


-- question 24
quotB :: ValeurB
quotB = VFonctionB f
       where f (VLitteralB (Entier x)) = Right (VFonctionB g)
                    where g (VLitteralB (Entier 0)) = Left ("Erreur d'interprétation (quotB) : division par 0 impossible")
                          g (VLitteralB (Entier y)) = Right (VLitteralB (Entier (x `quot` y)))
                          g e                       = Left ("Erreur d'interprétation (quotB) : nombre entier attendu en deuxième paramètre, mais " ++ (show e) ++ " trouvé")
             f e = Left ("Erreur d'interprétation (quotB) : nombre entier attendu en premier paramètre, mais " ++ (show e) ++ " trouvé")




-- interprète traçant


data ValeurC = VLitteralC Litteral
             | VFonctionC (ValeurC -> OutValC)

type Trace   = String
type OutValC = (Trace, ValeurC)

-- question 25
instance Show ValeurC where
    show (VFonctionC _)          = "lambda"
    show (VLitteralC (Entier n)) = show n
    show (VLitteralC (Bool n))   = show n


-- question 26
interpreteC :: Environnement ValeurC -> Expression -> OutValC
interpreteC _   (Lit x)   = ("", VLitteralC x)
interpreteC env (Var x)   = ("", fromJust (lookup x env))
interpreteC env (Lam x y) = ("", VFonctionC (\v -> interpreteC ((x, v):env) y))
interpreteC env (App x y) = case interpreteC env x of
                                    (t, (VFonctionC f)) -> ((t++"."++(fst application)), snd application)
                                                            where application = f (snd (interpreteC env y))
                                    e                   -> error ("Erreur d'interprétation : fonction attendu, mais " ++ (show e) ++ " trouvé")

-- question 27
pingC :: ValeurC
pingC = VFonctionC (\x -> ("p", x))




-- Interprète monadique
data ValeurM m = VLitteralM Litteral
               | VFonctionM (ValeurM m -> m (ValeurM m))

-- question 28
instance Show (ValeurM m) where
    show (VFonctionM _)          = "lambda"
    show (VLitteralM (Entier n)) = show n
    show (VLitteralM (Bool n))   = show n


data SimpleM v = S v
              deriving Show

-- question 29
interpreteSimpleM :: Environnement (ValeurM SimpleM) -> Expression -> SimpleM (ValeurM SimpleM)
interpreteSimpleM _   (Lit x)   = S (VLitteralM x)
interpreteSimpleM env (Var x)   = S (fromJust (lookup x env))
interpreteSimpleM env (Lam x y) = S (VFonctionM (\v -> interpreteSimpleM ((x, v):env) y))
interpreteSimpleM env (App x y) = vFonctionAOrError (interpreteSimpleM env x) (getVSM (interpreteSimpleM env y))
        where vFonctionAOrError (S (VFonctionM f)) = f
              vFonctionAOrError e = error ("Erreur d'interprétation : lambda expression attendu, \"" ++ (show e) ++ "\" lu")
              getVSM (S v) = v

instance Monad SimpleM where
    return      = S
    (S v) >>= f = f v
instance Applicative SimpleM where
    pure  = return
    (<*>) = ap
instance Functor SimpleM where
    fmap  = liftM


-- question 30
interpreteM :: Monad m => Environnement (ValeurM m) -> Expression -> m (ValeurM m)
interpreteM _   (Lit x)   = return (VLitteralM x)
interpreteM env (Var x)   = return (fromJust (lookup x env))
interpreteM env (Lam x y) = return (VFonctionM (\v -> interpreteM ((x, v):env) y))
interpreteM env (App x y) =    (interpreteM env x) >>= \ifnc
                            -> (interpreteM env y) >>= \ivar
                            -> case ifnc of
                                    (VFonctionM f) -> (f ivar)
                                    e -> error ("Erreur d'interprétation : lambda expression attendu, \"" ++ (show e) ++ "\" lu")


-- question 31
type InterpreteM m = Environnement (ValeurM m) -> Expression -> m (ValeurM m)

interpreteS :: InterpreteM SimpleM
interpreteS = interpreteM



data TraceM v = T (Trace, v)
              deriving Show


-- question 32
instance Monad TraceM where
    return x = T ("", x)
    (T (t, x)) >>= f = T (t ++ tt, y)
                       where (T (tt, y)) = f x
instance Applicative TraceM where
    pure  = return
    (<*>) = ap
instance Functor TraceM where
    fmap  = liftM


interpreteMT :: InterpreteM TraceM
interpreteMT = interpreteM

pingM :: ValeurM TraceM
pingM = VFonctionM (\v -> T ("p", v))

-- question 33
interpreteMT' :: InterpreteM TraceM
interpreteMT' env (App x y) =    (interpreteM env y) >>= \ivar
                              -> (interpreteM env x) >>= \ifnc
                              -> T (".", ifnc)       >>= \ifnc' -- le point ne s'ajoute pas à chaque application
                              -> case ifnc' of
                                    (VFonctionM f) -> (f ivar)
                                    e -> error ("Erreur d'interprétation : lambda expression attendu, \"" ++ (show e) ++ "\" lu")
interpreteMT' env x         = interpreteMT env x





data ErreurM v = Succes v
               | Erreur String
               deriving Show

-- question 34
instance Monad ErreurM where
   return             = Succes
   fail               = Erreur
   (Succes v) >>= f   = f v
   (Erreur e) >>= _   = Erreur e
instance Applicative ErreurM where
    pure  = return
    (<*>) = ap
instance Functor ErreurM where
    fmap  = liftM

-- question 35
interpreteE :: InterpreteM ErreurM
interpreteE _   (Lit x)   = return (VLitteralM x)
interpreteE env (Var x)   = maybe (fail ("Erreur d'interprétation : la variable " ++ x ++ " n'est pas défini")) return (lookup x env)
interpreteE env (Lam x y) = return (VFonctionM (\v -> interpreteE ((x, v):env) y))
interpreteE env (App x y) =    (interpreteE env x) >>= \ifnc
                            -> (interpreteE env y) >>= \ivar
                            -> case ifnc of
                                    (VFonctionM f) -> (f ivar)
                                    e -> fail ("Erreur d'interprétation : lambda expression attendu, \"" ++ (show e) ++ "\" lu")






