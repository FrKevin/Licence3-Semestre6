% Première salle
% Question 1
contenu(tigre).
contenu(princesse).

% Question 2
pancarte1(tigre, _).
pancarte1(_, princesse).
pancarte2(princesse, _).

% Question 3
salle1(X, Y) :- contenu(X), contenu(Y), pancarte1(X, Y), pancarte2(X, Y).
salle1(X, Y) :- contenu(X), contenu(Y), not(pancarte1(X, Y)), not(pancarte2(X, Y)).

% Question 4
/*
  Prolog result :
  ?- salle1(X, Y).
      X = Y, Y = princesse.
*/

% Question 5
/*
  Trace salle1 (pancarte1, pancarte2) :
   [debug] 5 ?- salle1(X, Y).
   T Call: (7) salle1(_G2513, _G2514)
   T Call: (8) pancarte1(_G2513, _G2514)
   T Exit: (8) pancarte1(tigre, _G2514)
   T Call: (8) pancarte2(tigre, _G2514)
   T Fail: (8) pancarte2(tigre, _G2514)
   T Redo: (8) pancarte1(_G2513, _G2514)
   T Exit: (8) pancarte1(_G2513, princesse)
   T Call: (8) pancarte2(_G2513, princesse)
   T Exit: (8) pancarte2(princesse, princesse)
   T Exit: (7) salle1(princesse, princesse)
*/

% Deuxième  salle
% Question 6
pancarte21(princesse, tigre).
pancarte22(princesse, tigre).
pancarte22(tigre, princesse).

salle2(X, Y) :- contenu(X), contenu(Y), pancarte21(X, Y), not(pancarte22(X, Y)).
salle2(X, Y) :- contenu(X), contenu(Y), pancarte22(X, Y), not(pancarte21(X, Y)).

% Question 7
/*
  Prolog result :
    ?- salle2(X, Y).
    X = tigre,
    Y = princesse.
*/

% Question 8
/*
  T Call: (7) salle2(_G2513, _G2514)
  T Call: (8) pancarte21(_G2513, _G2514)
  T Exit: (8) pancarte21(princesse, tigre)
  T Call: (9) pancarte22(princesse, tigre)
  T Exit: (9) pancarte22(princesse, tigre)
  T Redo: (7) salle2(_G2513, _G2514)
  T Call: (8) pancarte22(_G2513, _G2514)
  T Exit: (8) pancarte22(princesse, tigre)
  T Call: (9) pancarte21(princesse, tigre)
  T Exit: (9) pancarte21(princesse, tigre)
  T Redo: (8) pancarte22(_G2513, _G2514)
  T Exit: (8) pancarte22(tigre, princesse)
  T Call: (9) pancarte21(tigre, princesse)
  T Fail: (9) pancarte21(tigre, princesse)
  T Exit: (7) salle2(tigre, princesse)
*/

% Question 9
/*
  La pancarte numero 2 est la bonne.
  On peut l'expliquer par le fait quelle est plus general dans l'affirmation,
  on peut la definir comme une tautologie.
*/

% Question 10
affiche(X, Y) :- salle2(X, Y),
  write('Porte numero 1 : '),
  write(X),
  nl,
  write('Porte numero 2 : '),
  write(Y),
  nl.

% Troisième salle
% Question 11

contenu2(princesse).
contenu2(tigre).
contenu2(vide).


pancarte31(princesse, tigre, vide).
pancarte31(tigre, princesse, vide).
pancarte31(_, _, vide).


pancarte32(tigre, princesse, vide).
pancarte32(tigre, vide, princesse).

pancarte33(tigre, princesse, vide).
pancarte33(princesse, tigre, vide).



porte1(P1, P2, P3) :- pancarte31(P1, P2, P3), pancarte33(P1, P2, P3), not(pancarte32(P1, P2, P3)).
% porte1(P1, P2, P3) :- not(pancarte31(P1, P2, P3)), not(pancarte33(P1, P2, P3)), pancarte32(P1, P2, P3).

porte2(P1, P2, P3) :- pancarte32(P1, P2, P3), not(pancarte31(P1, P2, P3)), not(pancarte33(P1, P2, P3)).
% porte2(P1, P2, P3) :- not(pancarte32(P1, P2, P3)), pancarte31(P1, P2, P3), pancarte33(P1, P2, P3).

porte3(P1, P2, P3) :- pancarte33(P1, P2, P3), pancarte31(P1, P2, P3), not(pancarte32(P1, P2, P3)).
%porte3(P1, P2, P3) :- not(pancarte33(P1, P2, P3)), not(pancarte31(P1, P2, P3)), pancarte32(P1, P2, P3).

% Question 12
salle3(P1, P2, P3) :- contenu2(P1), contenu2(P2), contenu2(P3), not(porte1(P1, P2, P3)), porte2(P1, P2, P3), not(porte3(P1, P2, P3)).
salle3(P1, P2, P3) :- contenu2(P1), contenu2(P2), contenu2(P3), porte1(P1, P2, P3), not(porte2(P1, P2, P3)), porte3(P1, P2, P3).

% Question 13
/*
  12 ?- salle3(X, Y, Z).
  X = princesse,
  Y = tigre,
  Z = vide .
*/

% Question 14
/*
 T Call: (7) salle3(_G3190, _G3191, _G3192)
 T Call: (9) porte1(_G3190, _G3191, _G3192)
 T Call: (10) pancarte31(_G3190, _G3191, _G3192)
 T Exit: (10) pancarte31(princesse, tigre, vide)
 T Call: (10) pancarte33(princesse, tigre, vide)
 T Exit: (10) pancarte33(princesse, tigre, vide)
 T Call: (11) pancarte32(princesse, tigre, vide)
 T Fail: (11) pancarte32(princesse, tigre, vide)
 T Exit: (9) porte1(princesse, tigre, vide)
 T Redo: (7) salle3(_G3190, _G3191, _G3192)
 T Call: (8) porte1(_G3190, _G3191, _G3192)
 T Call: (9) pancarte31(_G3190, _G3191, _G3192)
 T Exit: (9) pancarte31(princesse, tigre, vide)
 T Call: (9) pancarte33(princesse, tigre, vide)
 T Exit: (9) pancarte33(princesse, tigre, vide)
 T Call: (10) pancarte32(princesse, tigre, vide)
 T Fail: (10) pancarte32(princesse, tigre, vide)
 T Exit: (8) porte1(princesse, tigre, vide)
 T Call: (9) porte2(princesse, tigre, vide)
 T Call: (10) pancarte32(princesse, tigre, vide)
 T Fail: (10) pancarte32(princesse, tigre, vide)
 T Fail: (9) porte2(princesse, tigre, vide)
 T Call: (8) porte3(princesse, tigre, vide)
 T Call: (9) pancarte33(princesse, tigre, vide)
 T Exit: (9) pancarte33(princesse, tigre, vide)
 T Call: (9) pancarte31(princesse, tigre, vide)
 T Exit: (9) pancarte31(princesse, tigre, vide)
 T Call: (10) pancarte32(princesse, tigre, vide)
 T Fail: (10) pancarte32(princesse, tigre, vide)
 T Exit: (8) porte3(princesse, tigre, vide)
 T Exit: (7) salle3(princesse, tigre, vide)
*/
