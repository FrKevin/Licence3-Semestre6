longueur([], 0).
longueur([_ | L], R) :- longueur(L, T), R is T + 1.

somme([], 0).
somme([X | L], R) :- somme(L, T), R is T + X.

membre(E, [E | _]).
membre(E, [_ | L]) :- membre(E, L).

ajoute_en_tete(T, Q, [T | Q]).

ajoute_en_queue(E, [], [E]) :- !.
ajoute_en_queue(E, [X | TL], [X | L]) :- ajoute_en_queue(E, TL, L).

extraire_tete_v1(L, T, Q) :- ajoute_en_queue(T, Q, L).
extraire_tete_v2([X | L], X, L).

concatene(L, [], L) :- !.
concatene(L1, [X2 | L2], R) :- ajoute_en_queue(X2, L1, L), concatene(L, L2, R).

retourne([], A, A) :- !.
retourne([X | L], A, R) :- retourne(L, [X | A], R).

insert_trie(E, [], [E]) :- !.
insert_trie(E, [X | L1], R) :- E =< X, !, ajoute_en_tete(E, [X | L1], R).
insert_trie(E, [X | L1], [X | L2]) :- E > X, !, insert_trie(E, L1, L2).

tri_insert([], []) :- !.
tri_insert([X | L1], R) :- tri_insert(L1, T), insert_trie(X, T, R).

divise([], [], []) :- !.
divise([E], [E], []) :- !.
divise([X | L], [X | L1], [X2 | L2]) :- extraire_tete_v2(L, X2, Q), divise(Q, L1, L2).

fusion(L1, L2, R) :- concatene(L1, L2, L), tri_insert(L, R).

tri_fusion([], []) :- !.
tri_fusion([E], [E]) :- !.
tri_fusion(L, R) :- divise(L, L1, L2), tri_fusion(L1, TL1), tri_fusion(L2, TL2),
                    fusion(TL1, TL2, R).

balance(_, [], [], []) :- !.
balance(E, [X | L], [X | L1], L2) :- X < E, !, balance(E, L, L1, L2).
balance(E, [X | L], L1, [X | L2]) :- X >= E, !, balance(E, L, L1, L2).


tri_rapide([], []) :- !.
tri_rapide([X | L], R) :- balance(X, L, L1, L2),
                          tri_rapide(L1, TL1), tri_rapide(L2, TL2),
                          concatene(TL1, [X], Rp), concatene(Rp, TL2, R).
est_vide([]).

ajoute_ensemble(E, [], [E]) :- !.
ajoute_ensemble(E, [E | L], [E | L]) :- !.
ajoute_ensemble(E, [X | L], [X | R]) :- ajoute_ensemble(E, L, R).

sous_ensemble([], _).
sous_ensemble([X | L1], L2) :- membre(X, L2), !, sous_ensemble(L1, L2).


union([], L, L) :- !.
union(L, [], L) :- !.
union([X | L1], L2, R) :- ajoute_ensemble(X, L2, L3) , union(L1, L3, R).

intersect([], _, []) :- !.
intersect(_, [], []) :- !.
intersect([X | L], L2, [X | R]) :- membre(X, L2), !, intersect(L, L2, R).
intersect([_ | L], L2, R) :- intersect(L, L2, R).

diff([], _, []) :- !.
diff(_, [], []) :- !.
diff([X | L], L2, [X | R]) :- not(membre(X, L2)), !, diff(L, L2, R).
diff([_ | L], L2, R) :- diff(L, L2, R).
