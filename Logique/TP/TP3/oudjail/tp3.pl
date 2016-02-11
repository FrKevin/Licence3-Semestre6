% Import
:- use_module(library(clpfd)).

% ----------------------------
grille([[_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,3,_,8,5],
        [_,_,1,_,2,_,_,_,_],
        [_,_,_,5,_,7,_,_,_],
        [_,_,4,_,_,_,1,_,_],
        [_,9,_,_,_,_,_,_,_],
        [5,_,_,_,_,_,_,7,3],
        [_,_,2,_,1,_,_,_,_],
        [_,_,_,_,4,_,_,_,9]]).

printline([]) :- writeln('|'), !.
printline([X | L]) :- integer(X) ,!, write('|'), write(X) , printline(L).
printline([_ | L]) :- !, write('|'), write(' '), printline(L).


print([]) :- !.
print([X | L]) :- !, printline(X), print(L).

bonnelongueur([], 0) :- !.
bonnelongueur([_ | L], R) :- bonnelongueur(L, TMP), R is TMP + 1.

bonnetaille([], _) :- !.
bonnetaille([L | G], R) :- !, bonnelongueur(L, R), bonnetaille(G, R).

verifie([]) :- !.
verifie([X | L]) :- !, X ins 1..9, all_distinct(X), verifie(L).

eclate([], R, R) :- !.
eclate([X1 | L], [X2 | L2], [X3 | R]) :- !, eclate(L, L2, R), X3 = [X1 | X2].

% Question 6
transp(X, Y) :- transpose(X, Y).

decoupe([], [], [], []) :- !.
decoupe([Xa], [Ya], [Za], [[Xa,Ya,Za]]) :- !. % Optionnel
decoupe([Xa,Xb], [Ya,Yb], [Za,Zb], [[Xa,Xb,Ya,Yb,Za,Zb]]) :- !. % Optionnel
decoupe([Xa,Xb,Xc|XS], [Ya,Yb,Yc|YS], [Za,Zb,Zc|ZS], [[Xa,Xb,Xc,Ya,Yb,Yc,Za,Zb,Zc]|RS]) :- !, decoupe(XS,YS,ZS,RS).

% question 9
carres([], []) :- !.
carres([X1,X2,X3|XS], [R1,R2|RS]) :- !, decoupe(X1, X2, X3, [R1,R2]), carres(XS, RS).

% question 10
% verifie(X): Toutes les lignes sont de longueur 9.
% transp(X,Y), verifie(Y): Toutes les colonnes sont de longueur 9.
% Chaque ligne contient des valeurs de 1 à 9 différentes.
% Chaque colonne contient des valeurs de 1 à 9 différentes.
% carres(Y, Z), verifie(Z): chaque carré contient des valeurs de 1 à 9 différentes.
solution(X) :- verifie(X), transp(X,Y), verifie(Y), carres(Y, Z), verifie(Z).
