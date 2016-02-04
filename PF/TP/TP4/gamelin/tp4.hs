data Arbre coul val = Noeud (val,coul) [Arbre coul val]
    deriving Show

mapArbre:: (a->b) -> Arbre coul a -> Arbre coul b
mapArbre f (Noeud x  fils) = Noeud ( f(fst x), snd x ) (map (mapArbre f) fils)

hauteur:: [Arbre c v] -> Int
hauteur [Noeud _ []] = 0
hauteur [Noeud _ fils] = 1 + hauteur fils

main :: IO ()
main = print ""
