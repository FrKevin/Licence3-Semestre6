module Main where

import Control.Monad
import Control.Concurrent

-- | Création d’un nouveau fil d’exécution

echo :: Int -> String -> IO ()
echo delais ident = forever $ do
    putStrLn (ident ++ " s’exécute")
    threadDelay delais

main = do forkIO (echo 700000 "fork")
          echo 200000 "main"
