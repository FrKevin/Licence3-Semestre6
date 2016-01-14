% Première salle
% Question 1
contenu(tigre).
contenu(princesse).
contenu(vide).

% Question 2
pancarte1(tigre, _).
pancarte1(_, princesse).
pancarte2(princesse, _).

% Question 3
salle1(X, Y) :- pancarte1(X, Y), pancarte2(X, Y).
salle1(X, Y) :- not(pancarte1(X, Y)), not(pancarte2(X, Y)).

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

salle2(X, Y) :- pancarte21(X, Y), not(pancarte22(X, Y)).
salle2(X, Y) :- pancarte22(X, Y), not(pancarte21(X, Y)).

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
  write("Porte numero 1 : "),
  write(X),
  nl,
  write("Porte numero 2 : "),
  write(Y),
  nl.

% Troisième salle
% Question 11
porte().
porte().
porte().
