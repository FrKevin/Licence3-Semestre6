module Effets where

import Parser

affiche :: String -> ()
affiche = undefined

_ = [ affiche "12", affiche "43" ]

id' :: a -> a
id' x = let _ = putStr "id'"
        in  x

id'' :: a -> IO a
id'' x = putStr "id''" >>= \_ ->
         return x

-- echo = putChar getChar
echo :: IO ()
-- echo = getChar >>= \c -> putChar c
echo = getChar >>= putChar

echo2 :: IO ()
echo2 = getChar   >>= \c ->
        putChar c >>= \_ ->
        putChar c

echo2' :: IO ()
echo2' = do c <- getChar
            putChar c
            putChar c

get2Char :: IO (Char, Char)
get2Char = do c1 <- getChar
              c2 <- getChar
              putStrLn ""
              return (c1, c2)

get2Char' :: IO (Char, Char)
get2Char' = getChar >>= \c1 ->
            getChar >>= \c2 ->
            return (c1, c2)

litLigne :: IO String
litLigne = do c <- getChar
              if c == '\n'
                  then return ""
                  else do cs <- litLigne
                          return (c:cs)

afficheChaine :: String -> IO ()
afficheChaine ""     = return ()
afficheChaine (c:cs) = do putChar c
                          afficheChaine cs

evalue :: String -> String
evalue = show . parseEval

ligneALigne :: (String -> String) -> IO ()
ligneALigne f = do l <- getLine
                   putStrLn (f l)

boucleInteraction :: IO () -> IO ()
boucleInteraction act = do act
                           boucleInteraction act

main :: IO ()
main = boucleInteraction (ligneALigne evalue)
