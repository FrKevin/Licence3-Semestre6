module Main where

import Control.Monad
import Control.Concurrent

-- | Exemple montrant comment synchroniser les deux fils par échange
-- de message

echo :: MVar () -> Int -> Int -> String -> IO ()
echo fin delais repetitions ident =
    do replicateM_ repetitions $ do
            putStrLn (ident ++ " s’exécute")
            threadDelay delais
       putMVar fin ()

main :: IO ()
main = do fin <- newEmptyMVar
          forkIO (echo fin 700000 4 "fork")
          takeMVar fin
