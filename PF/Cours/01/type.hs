add :: (Int, Int) -> Int
add (x, y) = x + y

zeroTo :: Integer -> [Integer]
zeroTo n = [0..n]

-- duplique :: Int -> (Int, Int)
duplique :: a -> (a, a)
duplique n = (n, n)

add' :: Int -> Int -> Int
add' x y = x + y

moyenne ns  = sum ns `div` length ns
moyenne' ns = div (sum ns) (length ns)

longPrem :: [[a]] -> Int
longPrem (xs:xss) = length xs
