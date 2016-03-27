module Monade where

addMaybe :: Maybe Integer -> Maybe Integer -> Maybe Integer
addMaybe mn mn' = case mn of
                    Just n -> case mn' of
                                Just n' -> Just (n + n')
                                Nothing -> Nothing
                    Nothing -> Nothing

-- Maybe est une monade

(>>>) :: Maybe a -> (a -> Maybe b) -> Maybe b
ma >>> fmb = case ma of
               Just a  -> fmb a
               Nothing -> Nothing

addMaybe' mn mn' = mn >>> \n -> mn' >>> \n' -> Just (n+n')

addMonad mn mn' = do n  <- mn
                     n' <- mn'
                     return (n + n')

paires :: Monad m => m a -> m b -> m (a, b)
paires ma mb = do a <- ma
                  b <- mb
                  return (a, b)

-- Les listes sont un autre exemple de monades

pairesL as bs = [ (a, b) | a <- as, b <- bs ]

(>>>>) :: [a] -> (a -> [b]) -> [b]
as >>>> fbs = concatMap fbs as
