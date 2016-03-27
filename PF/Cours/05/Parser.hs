module Parser where

import Data.Char (isDigit)

-- | Type des parseurs

type ResultatParse a = Maybe (a, String)
-- type Parser a = String -> Maybe (a, String)
newtype Parser a = MkParser (String -> ResultatParse a)


-- | Parseurs de base

unCaractereQuelconque :: Parser Char
unCaractereQuelconque = MkParser f
    where f ""     = Nothing
          f (c:cs) = Just (c, cs)

echoue :: Parser a
echoue = MkParser (const Nothing)
-- echoue = MkParser (\_ -> Nothing)

reussit :: a -> Parser a
reussit v = MkParser (\s -> Just (v, s))
-- ou alors :
-- reussit v = MkParser f
--     where f s = Just (v, s)


-- | Déclenchement d’un parseur

runParser :: Parser a -> String -> ResultatParse a
runParser (MkParser f) = f


-- | Combinateurs de parseurs

(|||) :: Parser a -> Parser a -> Parser a
p ||| p' = MkParser f
    where f s = case runParser p s of
                  Nothing -> runParser p' s
                  r       -> r

alt1 = runParser (unCaractereQuelconque ||| echoue) ""
alt2 = runParser (unCaractereQuelconque ||| reussit 'a') ""
alt3 = runParser (unCaractereQuelconque ||| reussit 'a') "b"

(>>>) :: Parser a -> (a -> Parser b) -> Parser b
p >>> fp = MkParser f
    where f s = case runParser p s of
                  Nothing      -> Nothing
                  Just (x, s') -> runParser (fp x) s'


-- | Quelques parseurs obtenus par combinaison

carCond :: (Char -> Bool) -> Parser Char
carCond cond = unCaractereQuelconque >>> f
    where f c | cond c    = reussit c
              | otherwise = echoue

ex1 = runParser (carCond isDigit) "bbépbép"
ex2 = runParser (carCond isDigit) "1bbépbép"
ex3 = runParser (carCond isDigit) ""

car :: Char -> Parser Char
car c = carCond (c ==)

chaine :: String -> Parser String
chaine     "" = reussit ""
chaine (c:cs) = car c          >>> \_ ->
                chaine cs      >>> \_ ->
                reussit (c:cs)

ex4 = runParser (chaine "123") "auie"
ex5 = runParser (chaine "123") "12auie"
ex6 = runParser (chaine "123") "123auie"

unOuPlus :: Parser a -> Parser [a]
unOuPlus p = p            >>> \x ->
             zeroOuPlus p >>> \xs ->
             reussit (x:xs)

zeroOuPlus :: Parser a -> Parser [a]
zeroOuPlus p = unOuPlus p ||| reussit []

chiffre :: Parser Char
chiffre = carCond isDigit

nombre :: Parser String
nombre = unOuPlus chiffre

entier :: Parser Integer
entier = nombre >>> \cs -> reussit (read cs)

ex7 = runParser nombre "123auie"
ex8 = runParser entier "123auie"


-- | Utilisation pour parser des expressions arithmétiques (simples)

data Expression a = Nombre a
                  | Add (Expression a) (Expression a)
                  | Mul (Expression a) (Expression a)
                  deriving (Show, Eq)

type ExprInteger = Expression Integer

foldExpr :: (a -> b) -> (b -> b -> b) -> (b -> b -> b) -> Expression a -> b
foldExpr n a m (Nombre x) = n x
foldExpr n a m (Add e e') = foldExpr n a m e `a` foldExpr n a m e'
foldExpr n a m (Mul e e') = foldExpr n a m e `m` foldExpr n a m e'

evalExpr :: Num a => Expression a -> a
evalExpr (Nombre n) = n
evalExpr (Add e e') = evalExpr e + evalExpr e'
evalExpr (Mul e e') = evalExpr e * evalExpr e'

evalExpr' :: Num a => Expression a -> a
evalExpr' = foldExpr id (+) (*)

facteurP :: Parser ExprInteger
facteurP = entier             >>> \n ->
           reussit (Nombre n)

termeP :: Parser ExprInteger
termeP = facteurP      >>> \n ->
         ( car '*'     >>> \_ ->
           termeP      >>> \e ->
           reussit (Mul n e) )
         ||| reussit n

expressionP :: Parser ExprInteger
expressionP = termeP           >>> \f ->
              ( car '+'        >>> \_ ->
                expressionP    >>> \e ->
                reussit (Add f e) )
              ||| reussit f

ex9 = runParser expressionP "1+2*4+3"

parseEval :: String -> Integer
parseEval s = case runParser expressionP s of
                Just (e, _) -> evalExpr e

ex10 = parseEval "1+2*4+3"
