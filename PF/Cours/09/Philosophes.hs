module Main where

import Control.Monad
import Control.Concurrent
import Control.Concurrent.STM
import System.Random

-- | Illustration de l’utilisation de STM pour faire des séquences
-- d’opérations exécutées atomiquement

type Baguette = TMVar ()

prendBaguettes :: Baguette -> Baguette -> IO ()
prendBaguettes d g = atomically $ do takeTMVar d
                                     takeTMVar g

lacheBaguettes :: Baguette -> Baguette -> IO ()
lacheBaguettes d g = atomically $ do putTMVar d ()
                                     putTMVar g ()

attend :: IO ()
attend = threadDelay =<< randomRIO (500000, 2000000)

philosophe :: Int -> Baguette -> Baguette -> IO ()
philosophe n d g = forever $ do
        affiche "pense"
        attend
        affiche "a faim"
        prendBaguettes d g
        affiche "mange"
        attend
        affiche "n’a plus faim"
        lacheBaguettes d g
  where
        affiche v = putStrLn ("Le philosophe " ++ show n ++ " " ++ v ++ ".")

main :: IO ()
main = do baguettes <- atomically $
                replicateM nombrePhilos (newTMVar ())
          mapM_ (forkIO . creePhilo baguettes) [1 .. nombrePhilos - 1]
          creePhilo baguettes 0
    where
        nombrePhilos        = 5
        eniemeBaguette bs n = bs !! (n `mod` nombrePhilos)
        creePhilo bs n      = philosophe n (eniemeBaguette bs n) (eniemeBaguette bs (n+1))
