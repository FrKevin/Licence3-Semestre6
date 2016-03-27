>   module Paresse where

>   import System.Environment (getArgs)

>   carre n = n * n

Appel par valeur, évaluation stricte :

carre (1+2) = carre 3
            = 3 * 3
            = 9

Appel par nom :

carre (1+2) = (1+2) * (1+2)
            = 3 * (1+2)
            = 3 * 3
            = 9

Forme normale : plus de réduction possible

>   trouNoir = trouNoir
>
>   ex1 = fst (1, trouNoir)

>   ifThenElse True  t _ = t
>   ifThenElse False _ e = e

>   _ &&& False = False
>   b &&& True  = b


Fermeture :

carre (1+2) = let n = 1+2  -- environnement
              in  n * n    -- code
            = let n = 3
              in  n * n
            = 9

>   boum = [1, 2, undefined]

*Paresse> boum
[1,2,*** Exception: Prelude.undefined

>   long = [0..1000000]
>   quatre = long !! 4

*Paresse> :sprint long
long = _
*Paresse> quatre
4
*Paresse> :sprint long
long = 0 : 1 : 2 : 3 : 4 : _

>   uns = 1 : uns

Calcul de la suite de Fibonacci

>   fib = 0 : 1 : zipWith (+) fib (tail fib)

En compilant le programme :

    ghc --make -main-is Paresse.main Paresse.lhs

on voit que :

    Paresse 100000 +RTS -s

a besoin de beaucoup moins de mémoire que ghci quand on évalue
« fib !! 100000 ». Le compilateur ou le RTS se rendent compte qu’il
n’est pas nécessaire de conserver toute la liste.

>   main = do (n:_) <- getArgs
>             print (fib !! read n)

L’évaluation n’est pas forcément continue

>   plus1 = map (+1) [0..]
>
>   douze = let _ = plus1 !! 20
>           in  12
>
>   douze' = plus1 !! 20 `seq` 12

La paresse permet de faire du code plus modulaire

>   donnees = [1..]
>   controle = take 5
>
>   prog = controle donnees


Crible (infini) d’Ératosthène

>   premiers = crible [2..]
>     where crible (n:ns) = n : crible [ ns' | ns' <- ns, ns' `mod` n /= 0 ]
>
>   premiers' = crible [2..]
>     where crible (n:ns) = n : crible (filter (\n' -> n' `mod` n /= 0) ns)

Contrôle du crible :

>   cent = premiers !! 100
>   cents = take 100 premiers

Calcul de la racine carrée :

>   heron n = iterate f 1
>       where f x = (x + n / x) / 2

>   arret ecart (a:b:_) | abs (a - b) < ecart = b
>   arret ecart (_:bs)                        = arret ecart bs

>   arretRapp rapport (a:b:_) | abs (a / b - 1) < rapport = b
>   arretRapp rapport (_:bs)                              = arretRapp rapport bs
