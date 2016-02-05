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

eclate([], R, R).
eclate([X1 | L], [X2 | L2], [X3 | R]) :- eclate(L, L2, R), X3 = [X1 | X2].

% TODO
transp([], []) :- !.
transp([L | G], R) :- eclate(L, T, R), transp(G, T).
