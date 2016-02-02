data Arbre val coul = Noeud (val,coul) [Arbre coul val]
    deriving Show

mapArbre :: (a -> b) -> Arbre a c -> Arbre a c
mapArbre f (Noeud x  fils) = Noeud ( f(fst x), snd x ) (map (mapArbre f) fils)

main :: IO ()
main = print ""
