longueur([], 0).
longueur([_ | L], R) :- longueur(L, T), R is T + 1.

somme([], 0).
somme([X | L], R) :- somme(L, T), R is T + X.

membre(E, [E | _]).
membre(E, [_ | L]) :- membre(E, L).

ajoute_en_tete(T, Q, [T | Q]).

ajoute_en_queue(E, [], [E]).
ajoute_en_queue(E, [X | TL], [X | L]) :- ajoute_en_queue(E, TL, L).

extraire_tete(L, T, Q) :- ajoute_en_queue(T, Q, L).

concatene(L, [], L).
concatene(L1, [X2 | L2], R) :- ajoute_en_queue(X2, L1, L), concatene(L, L2, R).

retourne([], A, A).
retourne([X | L], A, R) :- retourne(L, [X | A], R).

insert_trie(E, [], [E]) :- !.
insert_trie(E, [X | L1], R) :- E =< X, !, ajoute_en_tete(E, [X | L1], R).
insert_trie(E, [X | L1], [X | L2]) :- E > X, !, insert_trie(E, L1, L2).

% Marche pas :(
tri_insert([], []).
tri_insert([X | L1], [Y | L1]) :- insert_trie(X, L1, T), tri_insert(L1, T).
