/* Import */
:- use_module(library(clpfd)).

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
printline([X|R]) :- integer(X), !, write(' | '),  write(X), printline(R).
printline([_|R]) :- !, write(' '), printline(R).

print([]) :- !.
print([X|R]) :- !,printline(X), print(R).

bonnelongueur([], 0) :- !.
bonnelongueur( [_|R], Taille) :- bonnelongueur(R, Tmp), tmp is Taille + 1.

bonnetaille([], _) :- !.
bonnetaille([X|R], Taille) :- !, bonnelongueur(X, Taille), bonnetaille(R, Taille).

/*
  1er verssion
  verifier([]).
  verifier([X | L]) :- X>= 1, X =< 9, verifier(L).
*/

/* 2e verssion */
verifie([]) :- !.
verifie([X|L]) :- !, X ins 1..9, all_distinct(X), verifie(L).

eclate([], L, L) :- !. 
