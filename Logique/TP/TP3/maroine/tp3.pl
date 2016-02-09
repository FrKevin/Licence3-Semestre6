% BALOUP MAROINE TP3

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


%Question 1
printline([]) :- writeln('|'), !.
printline([X|L]) :- integer(X), !, write(' | '), write(X), printline(L).
printline([_|L]) :- !, write(' | '), write('_'), printline(L).

%Question 2
print([]) :- !.
print([X|L]) :- !, printline(X), print(L).

%Question 3
bonneLongueur([],0):- !.
bonneLongueur([_|L], N) :- !, bonneLongueur(L,R), N is R+1.

%Question 4
bonneTaille([],_) :- !.
bonneTaille([X|XS], N) :- !, bonneLongueur(X, N), bonneTaille(XS,N).

%Question 5
verifie([]) :- !.
verifie([X|L]) :- !, all_distinct(X), X ins 1..9, verifie(L).

%Question 6
eclate([], X, X) :- !.
eclate([X|XS], [Y|YS], [[X|Y],ZS]) :- !, eclate(XS, YS, ZS).

%Question 7
transp([[X],[Y],[Z]], [X,Y,Z]) :- !.
transp([[X|XS], [Y|YS], [Z|ZS]], [[X,Y,Z],RS]) :- !, transp([XS,YS,ZS],RS).

%Question 8
decoupe([X1,X2,X3],[Y1,Y2,Y3],[Z1,Z2,Z3], [X1,X2,X3,Y1,Y2,Y3,Z1,Z2,Z3]) :- !.
decoupe([X1,X2,X3|XS],[Y1,Y2,Y3|YS],[Z1,Z2,Z3|ZS], [[X1,X2,X3,Y1,Y2,Y3,Z1,Z2,Z3],RS]) :- !, decoupe(XS,YS,ZS,RS).

%question 9
carres([],_) :- !.
carres([X,Y,Z], L) :- decoupe(X,Y,Z, L).

%question 10
