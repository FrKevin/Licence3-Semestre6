module Main where

import Control.Monad
import Control.Concurrent

renvoie :: MVar a -> MVar a -> IO ()
renvoie a b = do c <- takeMVar a
                 putMVar b c

main = do a <- newEmptyMVar
          b <- newEmptyMVar

          forkIO (renvoie a b)
          renvoie b a
