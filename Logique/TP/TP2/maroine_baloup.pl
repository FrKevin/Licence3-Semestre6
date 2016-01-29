% MAROINE
% BALOUP
% TP2 Logique - Prolog


% question 1
longueur([], 0).
longueur([_|L], Y) :- longueur(L, X), Y is X+1.

% question 2
somme([], 0).
somme([H|L], Y) :- somme(L,X), Y is X+H.


% question 3
membre(V, [V|_]).
membre(V, [_|L]) :- membre(V, L).

% question 4
ajoute_en_tete(E, T, [E|T]).

% question 5
ajoute_en_queue(E, [], [E]).
ajoute_en_queue(E, [X|XS], [X|Y]) :- ajoute_en_queue(E, XS, Y).

% question 6
extraire_tete(T, X, XS) :- ajoute_en_tete(X, XS, T).

% question 7
concatene(T, [], T).
concatene(T, [X|XS], Z) :- ajoute_en_queue(X, T, Y), concatene(Y, XS, Z).

% question 8
retourne([], L, L).
retourne([X|XS], L, A) :- ajoute_en_tete(X, L, P), retourne(XS, P, A).

% question 9
insert_trie(E, [], [E]) :- !.
insert_trie(E, [X|XS], R) :- E =< X, !, ajoute_en_tete(E, [X|XS], R).
insert_trie(E, [X|XS], [X|Y]) :- E > X, !, insert_trie(E, XS, Y).

% question 10
tri_insert([], []).
tri_insert([X|XS], R) :- tri_insert(XS, T), insert_trie(X, T, R).

% question 11
divise([], [], []).
divise([X], [X], []).
divise([X1,X2|XS], [X1|Y], [X2|Z]) :- divise(XS, Y, Z).

% question 12
fusion(X, [], X).
fusion(X, [Y|YS], R) :- insert_trie(Y, X, T), fusion(T, YS, R).

% question 13
tri_fusion([], []).
tri_fusion([X], [X]).
tri_fusion(X, R) :- divise(X, X1, X2), tri_fusion(X1, R1), tri_fusion(X2, R2), fusion(R1, R2, R).

% question 14
balance(_, [], [], []).
balance(E, [X|XS], [X|L1], L2) :- E>X, !, balance(E, XS, L1, L2).
balance(E, [X|XS], L1, [X|L2]) :- E=<X, !, balance(E, XS, L1, L2).

% question 15
tri_rapide([], []).
tri_rapide([X|XS], R) :- balance(X, XS, L1, L2), tri_rapide(L1, R1), tri_rapide(L2, R2), concatene(R1, [X], RT), concatene(RT, R2, R).

% question 16
est_vide([]).

% question 17
ajoute_ensemble(E, [], [E]).
ajoute_ensemble(X, [X|XS], [X|XS]).
ajoute_ensemble(E, [X|XS], [X|Y]) :- ajoute_ensemble(E, XS, Y).

% question 18
sous_ensemble([], _).
sous_ensemble([X|XS], L) :- membre(X, L), sous_ensemble(XS, L).

% question 19
union([], L2, L2).
union([X|XS], L2, R) :- ajoute_ensemble(X, L2, R1), union(XS, R1, R).

% question 20
intersect([], _, []).
intersect([X|XS], L2, [X|YS]) :- membre(X, L2), intersect(XS, L2, YS).
intersect([_|XS], L2, YS) :- intersect(XS, L2, YS).

% question 21
diff([], _, []).
diff([X|XS], L2, [X|YS]) :- not(membre(X, L2)), diff(XS, L2, YS).
diff([_|XS], L2, YS) :- diff(XS, L2, YS).

