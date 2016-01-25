Bonjour à tous.

Cours du 13/01/16

Fichier contenant les exemples 'def.hs' disponible sur le portail onglet "Documents" dans un dépôt git.

----------------def.hs (un fichier .hs  défint un module, un module est une série d'équations définissant des fonctions (ou des constantes de types non fonctionnels, les fonctions ne sont pas si différentes des entiers, etc.))
module Definitions where  

     1 ) Definition de fonction par équation
 (A) nom :: type
 (B) nom argu = valeur

  (A) défintion du type de la fonction = documentation permettant de comprendre la fonction et aussi pour s'assurer que la fonction écrite respecte le type spécifié

    2) IF THEN ELSE
       Un IF THEN est toujours suivi d'un ELSE en Haskell et leurs valeurs sont toujours du même type  ( voir fonction "absolue" )
      Imbrication possible  ( voir fonction "signe"' )
      Attention à l'indentation

absolue :: Integer -> Integer   
absolue n = if n >= 0
                then n
                else (-n)

{- Définition avec                             Commentaire multiligne " {- blabla -}"
 - des if imbriqués
 -}
signe :: Integer -> Integer
signe n = if n > 0
            then 1
            else if n == 0
                    then 0
                    else -1

pairSuivant :: Integer -> Integer                                      
pairSuivant n = n + 1 + if n `mod` 2 == 0                            
                            then 1                                                              
                            else 0

  3) Notation infixe et préfixe
   la notation préfixe correspond à  " nomfonction  argu1 argu2"
   la noation infixe  correspond à " argu1 nomfonction argu2" , souvent  utilisé pour les opérateurs


 4) Définiton avec gardes
  Une garde est une condition (voir fonction signe' ci dessous)
  " otherwise" correspond à "tous les autres cas" = True ( documentation Prelude pour plus d'information )

-- Définition avec gardes       (Commenaire sur une ligne, utilisation de "--" )
signe' :: Integer -> Integer
signe' n | n > 0     = 1
         | n == 0    = 0
         | otherwise = -1

  5) Filtrage de motif
  L'interprete GHCI boucle afin d'évaluer les expressions, de ce fait quand il rencontre une série d'équation, une analyse est faite afin de savoir quoi appliquer à (aux) l'argument(s) passé en paramêtre (c’est-à-dire quelle est la première équation qui s’applique).

non :: Bool -> Bool
non True  = False
non False = True

6) Nom d'une fonction
 - minuscule
- suite de lettres, chiffre (pas en 1er position), apostrophe
- suite de symboles ( attention pas tous, voir documentation)

(&&&) :: Bool -> Bool -> Bool      
-- (&&&) True True = True            (notation infixe)
True  &&& True  = True                 (notation préfixe)
True  &&& False = False
False &&& True  = False
False &&& False = False

7) Underscore
Utilisé pour définir    "n'importe quelle valeur"

(&&&&) :: Bool -> Bool -> Bool
True &&&& True = True
_    &&&& _    = False
-- a    &&&& b    = False     ( à éviter car a et b ne sont pas définis, underscore powa !)


(&&&&&) :: Bool -> Bool -> Bool
b &&&&& True = b
_ &&&&& _    = False

(&&&&&&) :: Bool -> Bool -> Bool
-- b &&&&&& b = b     ( "overlapped", conflit pour b )
b &&&&&& b' | b == b' = b  (solution )
_ &&&&&& _            = False



8) Liste  
Quand on rencontre comme erreur à la compilation "non exhaustive patterns in function blabla", c'est qu'un cas important pour la fonction n'a pas été défini
Donc, toujours, démarrer par le type, le cas de base en cas de filtrage de motif, les cas spéciaux et ensuite la fameuse fonction
Dans le cas d'une liste vide, utilisation de "error" ou "undifined" (voir fonction "tete" ci dessous)

tete :: [a] -> a
tete (x:_) = x
tete [] = -- undefined
          error "liste vide"


9) (x:xs)
Historiquement appelé "cons" pour constructeur, en effet les deux points : permettent en Haskell de construire et de déconstruire des listes
les parenthèses sont nécéssaires car Haskell applique les arguments à une fonction. Donc sans ( ) , tete x:xs , sera compris comme (tete x):xs
: n'est pas un symbole pour nom de fonction
"mot@(x:xs)"  permet de désigner la liste complete via "mot"  (voir fonction "decompose" ci dessous)

decompose :: [a] -> (a, [a])
decompose tous@(x:_) = (x, tous)

troisieme :: [a] -> a
-- troisieme (_:(_:(x:_))) = x
troisieme (_:_:x:_) = x

tete' :: [[t]] -> t
tete' ((x:_):_) = x

cas :: [t] -> String
cas []        = "zéro"   (liste vide)
cas [_]       = "un"     (liste à un élément)
cas [_,_]     = "deux"
cas (_:_:_:_) = "au moins trois"

eclair :: [a] -> [b] -> [(a,b)]      (similaire à la fonction zip, voir Document Prelude)
eclair     []      _ = []
eclair      _     [] = []
eclair (x:xs) (y:ys) = (x,y) : eclair xs ys


decomposePaire :: (a, b) -> a
decomposePaire (x, _) = x

-- eclair x y = x  

10) Fonction anomymes
   \ nom -> expression
   Cette fonction est est dite anonyme car elle est définie là ou elle apparait ( voir fonction "impair'' " et "f''' "  ci dessous)
   Utilisation du symbole "\" car il ressemble aux Lambda, tiré du Lambda Calcul

impairs :: [Integer]
impairs = map f [0..]
    where f x = 2 * x + 1

impairs' :: [Integer]
impairs' = let f x = 2 * x + 1
           in  map f [0..]

impairs'' :: [Integer]
impairs'' = map (\x -> 2 * x + 1) [0..]


f :: Int -> String
f i = replicate i 'a' ++ "h !"

f' :: Int -> String
f' = \i -> replicate i 'a' ++ "h !"

11) Application partielle d'un opérateur = SECTION
Dans GHCI, différence entre (+1) et (+)
:t (+1)
:t (+)

carrés :: [Integer]
carrés = map (^ 2) [0..10]

puissancesDeux :: [Integer]
puissancesDeux = map (2 ^) [0..10]




11) HASKELL BROOKS CURRY
Formes curryfiées

12) HLINT
Outil de vérification de syntaxe Haskell

13) W , WALL
Dans ghci ou dans un fichier .ghci  l'option -W permet l'activation d'avertissement, Wall est encore plus gentil et donne encore plus de détail, à vous de choisir.
:set -W
:set Wall
-----------------------------------------------------------------------

Fin des cours sur la syntaxe Haskell.
