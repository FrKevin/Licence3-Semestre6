module MonadeMaybe where

-- | Maybe est une monade
-- Redéfinissons (>>=) et return

(>>>) :: Maybe a -> (a -> Maybe b) -> Maybe b
Nothing >>> _ = Nothing
Just a  >>> f = f a

retourne :: a -> Maybe a
retourne = Just

ex = do a <- Just 12
        b <- Just (a + 1)
        return b

ex' = Just 12      >>= \a ->
      Just (a + 1) >>= \b ->
      return b
