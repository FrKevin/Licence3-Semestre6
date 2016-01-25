mylength([],0).
mylength([_|Q],L) :- mylength(Q,L2),L is L2 + 1.

somme([], 0).
somme([E|Q], S) :-  somme(Q, S2),S is S2 + E.

membre(_, []) :- false.
membre(N, [N|_]) :- true.
membre(N, [_|Q]) :- membre(N, Q).

/* Avec la fonction append */
ajoute_en_tete_app( N, Old_Liste, New_Liste) :- append([N], Old_Liste, New_Liste).

ajoute_en_tete( N, Old_Liste, [N|Old_Liste]).

/* Avec la fonction append */
ajoute_en_queue_app(N, Old_Liste, New_Liste) :- append(Old_Liste, [N], New_Liste).

ajoute_en_queue(N, Old_Liste, [Old_Liste|N]).

/* Fonction de base qui n'utilise pas ajoute en tete */
extraire_en_tete([E|Q], E, Q).

/* Avec la fonction append */
concatene(L1, L2, L) :- append(L1, L2, L).

concatene2(L1, L2) :- concatene2(L1, L2, []).
concatene2( [], L2, L2).
concatene2(L1, [], L1).
concatene2(L1, [E2|Q2], L) :- concatene2(L1, Q2, [E2|L]).

retourne(Liste_initial,Liste_inverse):- retourne(Liste_initial, [], Liste_inverse).
retourne([] , Accumulateur , Accumulateur).
retourne([E|Q], Accumulateur, Liste_inverse) :- retourne(Q, [E|Accumulateur], Liste_inverse).
