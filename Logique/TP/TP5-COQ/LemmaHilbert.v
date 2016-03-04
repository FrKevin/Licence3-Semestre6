Lemma hilbertS (A B C : Prop) :
 (A -> B -> C ) -> (A -> B) -> A -> C.
Proof.
intros abc ab a.
apply abc.
- exact a.
- apply ab.
 exact a.
Qed.

Lemma exo1 (P Q : Prop) : 
  P -> (Q -> P).
Proof.
intros p.
intros pq.
exact p.
Qed.

Require Import Classical.



Lemma exo2 (P Q : Prop) :
  P -> (~P -> Q).
Proof.
intros p.
intros p'.
generalize (p' p).
destruct 1.
Qed.


Lemma exo3 (P Q R : Prop) : 
  (P -> Q) -> ((Q -> R) -> (P -> R)).
Proof.
intros pq.
intros qr.
intros q.
apply qr.
apply pq.
exact q.
Qed.

Lemma exo4 (P Q : Prop) : 
  (P -> Q) -> ( ~ Q -> ~ P).
Proof.
intros pq.
intros q'.
intros p'.
apply q'.
apply pq.
exact p'.
Qed.


Require Import Classical. 

Lemma bottom_c (A : Prop) : 
  ((~A) -> False) -> A.
Proof.
intros af.
apply NNPP.
Check NNPP.
intros na.
generalize (na).
exact af.
Qed.



Lemma exo5 (P Q : Prop) : 
  ( ~ Q -> ~ P) -> (P -> Q).
Proof.
intros qp''.
intros p.
apply bottom_c.
intros q'.
Set Printing Notations.
generalize (qp'' q').
intros np.
apply np.
exact p.
Qed.






