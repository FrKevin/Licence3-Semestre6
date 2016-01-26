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
retourne() 
