module Parser ( Parser
              , Resultat
              , runParser
              , unCaractereQuelconque
              , echoue
              , reussit
              , (|||)
              , carCond
              , car
              , chaine
              , unOuPlus
              , zeroOuPlus
              , complet
              , resultat )
where

import Control.Applicative
import Control.Monad (ap, liftM)

-- | Définition du type des analyseurs syntaxiques
type    Resultat a = Maybe (a, String)
newtype Parser a   = MkParser (String -> Resultat a)

-- | Déclenche un analyseur syntaxique sur une chaîne donnée
runParser :: Parser a -> String -> Resultat a
runParser (MkParser f) = f

-- | Briques de base

-- | Analyseur syntaxique qui retrouve le premier caractère de la
-- chaîne
unCaractereQuelconque :: Parser Char
unCaractereQuelconque = MkParser f
    where f ""     = Nothing
          f (c:cs) = Just (c, cs)

-- | Analyseur qui échoue toujours
echoue :: Parser a
echoue = MkParser (const Nothing)

-- | Analyseur qui réussit toujours, avec le résultat indiqué
reussit :: a -> Parser a
reussit v = MkParser (\s -> Just (v, s))

-- | Alternative
-- Combinateur qui retourne le résultat du premier analyseur si
-- celui-ci réussit, sinon celui du second
(|||) :: Parser a -> Parser a -> Parser a
p ||| p' = MkParser (\s -> case runParser p s of
                             Nothing -> runParser p' s
                             r       -> r)

-- | Séquence
-- La séquence est définie par l’opérateur (>>>) mais il ne sera pas
-- exporté, puisqu’il ferait double emploi avec (>>=)
(>>>) :: Parser a -> (a -> Parser b) -> Parser b
p >>> fp = MkParser f
    where f s = case runParser p s of
                  Nothing      -> Nothing
                  Just (x, s') -> runParser (fp x) s'


-- | Instance de Monad
-- Les analyseurs syntaxiques sont une monade. La définition de
-- l’instance de la classe de type Monad donne accès à la notation do
instance Monad Parser where
    return = reussit
    (>>=)  = (>>>)
    fail _ = echoue

-- | Instances de Applicative et Functor
-- À partir de GHC 7.10, toutes les instances de Monad doivent aussi
-- être des instances de Applicative et du coup aussi de Functor
-- Avant GHC 7.10, ça ne fait pas de mal
instance Applicative Parser where
    pure  = return
    (<*>) = ap

instance Functor Parser where
    fmap  = liftM


-- | Petits analyseurs utiles

-- | Parse un caractère qui vérifie une condition donnée
carCond :: (Char -> Bool) -> Parser Char
carCond cond = unCaractereQuelconque >>= filtre
   where filtre c | cond c    = return c
                  | otherwise = echoue

-- | Parse un unique caractère
car :: Char -> Parser Char
car c = carCond (c ==)

-- | Parse une chaîne constante
chaine :: String -> Parser String
chaine ""     = return ""
chaine (c:cs) = do car c
                   chaine cs
                   return (c:cs)

-- | Combine des parseurs pour des séquences d’au moins un élément
unOuPlus :: Parser a -> Parser [a]
unOuPlus p = do r <- p
                rs <- zeroOuPlus p
                return (r:rs)

-- | Combine des parseurs pour des séquences de zéro ou plusieurs
-- éléments
zeroOuPlus :: Parser a -> Parser [a]
zeroOuPlus p = unOuPlus p ||| return []

-- | Détecte si l’analyse a complètement réussi (c’est-à-dire si toute
-- la chaîne a été analysée)
complet :: Resultat a -> Bool
complet (Just (_, "")) = True
complet _              = False

-- | Extrait le résultat, en cas de réussite du parseur
resultat :: Resultat a -> a
resultat (Just (r, _)) = r
