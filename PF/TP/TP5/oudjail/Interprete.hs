module Interprete where
import Parser
import Data.Char
import Data.Maybe

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
-- Facilite les tests pour les exemple
parse :: Parser a -> String -> Resultat a
parse = runParser

getI :: Litteral -> Integer
getI (Entier n) = n
getI _          = undefined

getB :: Litteral -> Bool
getB (Bool b) = b
getB _        = undefined

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

-- Etape 4
applique :: [Expression] -> Expression
applique = foldl1 App

-- Etape 5-7-8-9-10
exprP :: Parser Expression
exprP = varP ||| exprParentheseeP ||| lambdaP ||| nombreP ||| booleenP

exprsP :: Parser Expression
exprsP = do exprs <- unOuPlus exprP
            return (applique exprs)

-- Etape 6
lambdaP :: Parser Expression
lambdaP = do car '\\'
             espaceP
             x <- varP
             espaceP
             car '-'
             car '>'
             espaceP
             expr <- exprsP
             return (Lam (get x) expr)
  where get (Var xx) = xx
        get _ = error ""

-- Etape 8
exprParentheseeP :: Parser Expression
exprParentheseeP = do car '('
                      e <- exprsP
                      car ')'
                      espaceP
                      return e

-- Etape 9
chiffre :: Parser Char
chiffre = carCond isDigit

nombre :: Parser String
nombre = unOuPlus chiffre

entier :: Parser Integer
entier = do nb <- nombre
            return (read nb)

nombreP :: Parser Expression
nombreP = do e <- entier
             espaceP
             return (Lit (Entier e))

-- Etape 10
booleenP :: Parser Expression
booleenP = do b <- chaine "True" ||| chaine "False"
              return (Lit (Bool (b == "True")))

-- Etape 11
expressionP :: Parser Expression
expressionP = do espaceP
                 exprsP

-- Etape 12
ras :: String -> Expression
ras s = case parse expressionP s of
          Nothing                           -> error "Erreur d’analyse syntaxique"
          c@(Just (r,_)) | not (complet c)  -> error "Erreur d’analyse syntaxique, le parsing n'est pas complet "
                         | otherwise        -> r

-- Etape 13-14
data ValeurA = VLitteralA Litteral
             | VFonctionA (ValeurA -> ValeurA)

getVL :: ValeurA -> Litteral
getVL (VLitteralA l) = l
getVL _              = undefined


instance Show ValeurA where
   show (VFonctionA _)          = "lambda "
                      -- ^ ou "VFonctionA _", ou "<fun>" ou toute
                      --   autre représentation des fonctions
   show (VLitteralA (Entier n)) = show n
   show (VLitteralA (Bool n))   = show n

-- Etape 15
type Environnement a = [(Nom, a)]

interpreteA :: Environnement ValeurA -> Expression -> ValeurA
interpreteA _ (Lit l)      = VLitteralA l
interpreteA env (Lam n e)  = VFonctionA (\v -> interpreteA ((n, v):env) e)
interpreteA env (Var x)    = fromJust (lookup x env)
interpreteA env (App e e') = f (interpreteA env e')
    where f = case interpreteA env e of (VLitteralA _) -> error ""
                                        (VFonctionA r) -> r

-- Etape 16
negA :: ValeurA
negA = VFonctionA (\x -> VLitteralA (Entier (-getI (getVL x)) ) )

-- Etape 17 (Avec defi notation sans fct exterieur)
addA :: ValeurA
addA = VFonctionA (\x1 -> case x1 of
                           (VLitteralA (Entier n1)) -> VFonctionA (\x2 -> case x2 of
                                                                           (VLitteralA (Entier n2)) -> VLitteralA (Entier (n1+n2))
                                                                           _                        -> undefined)
                           _                        -> undefined)


-- Etape 18
releveBinOpEntierA :: (Integer -> Integer -> Integer) -> ValeurA
releveBinOpEntierA op = VFonctionA (\x1 -> case x1 of
                                            (VLitteralA (Entier n1)) -> VFonctionA (\x2 -> case x2 of
                                                                                            (VLitteralA (Entier n2)) -> VLitteralA (Entier (n1 `op` n2))
                                                                                            _                        -> undefined)
                                            _                        -> undefined)

-- Etape 19, mettre des parenthéses
ifthenelseA :: ValeurA
ifthenelseA = VFonctionA (\if_ -> VFonctionA
                              (\then_ ->
                                  VFonctionA
                              (\else_ -> if getB (getVL if_)
                                            then then_
                                            else else_)))

envA :: Environnement ValeurA
envA = [ ("neg",   negA)
       , ("add",   releveBinOpEntierA (+))
       , ("soust", releveBinOpEntierA (-))
       , ("mult",  releveBinOpEntierA (*))
       , ("quot",  releveBinOpEntierA quot)
       , ("if", ifthenelseA)]


-- Interprète avec erreurs
data ValeurB = VLitteralB Litteral
            | VFonctionB (ValeurB -> ErrValB)

type MsgErreur = String
type ErrValB   = Either MsgErreur ValeurB



-- Etape 20 : A ameliorer
main :: IO ()
main = do putStr "minilang> "
          cmd <- getLine
          print (interpreteA envA (ras cmd))
          main
