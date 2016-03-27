module Lambda where

-- | Exemple d’une fermeture

ex1 = let x = True
      in  \f -> f x

-- | Entiers de Church

type Entier t = (t -> t) -> t -> t

zero :: Entier t
zero = \f x -> x

un :: Entier t
un = \f x -> f x

deux :: Entier t
deux = \f x -> f (f x)

successeur :: Entier t -> Entier t
-- successeur n = \f x -> f (n f x)
successeur n = \f x -> n f (f x)

resultat :: Entier Int -> Int
resultat n = n (+1) 0
