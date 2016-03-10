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

Lemma exo6 (P : Prop) : 
  ~ ~ P -> P.
Proof.
intros p.
apply bottom_c.
intros pf.
apply p.
exact pf.
Qed.

Lemma exo7 (P : Prop) : 
  P -> ~ ~ P.
Proof.
intros p.
apply bottom_c.
intros p'''.
apply p'''.
intro p''.
apply p''.
exact p.
Qed.

Lemma exo8 (P Q R : Prop) : 
  (P -> (Q -> R)) -> (P /\ Q -> R).
Proof.
intros pqr.
intros p_qr.
apply pqr.
- apply p_qr.
- apply p_qr.
Qed.

Lemma exo9 (P Q R : Prop) : 
  (P /\ Q -> R) -> (P -> (Q -> R)).
Proof.
intros pqr.
intros p.
intros q.
apply pqr.
split.
- exact p.
- exact q.
Qed.

Lemma exo10 (P : Prop) : 
  P /\ ~ P -> False.
Proof.
intros pp'.
destruct pp' as [p p'].
destruct p'.
exact p.
Qed.

Lemma exo11 (P : Prop) : 
  False -> P /\ ~ P.
Proof.
intros f.
split.
- destruct f.
- destruct f.
Qed.


Lemma exo12 (P Q : Prop) : 
  P \/ Q <-> ~ ( ~ P /\ ~ Q).
Proof.
split.
- intros p0q.
  intros p'_q'.
  destruct p'_q' as [p' q'].
  destruct p'.
  destruct p0q.
  exact H.
  destruct q'.
  exact H.
- intros p'_q''.
  apply bottom_c.
  intro p0q.
  apply p'_q''.
  split.
  + intros p.
    apply p0q.
    left.
    exact p.
  + intros q.
    apply p0q.
    right.
    exact q.
Qed.
  
Lemma exemple134 (A B C : Prop) : (A /\ B -> C) <-> (A -> B -> C).
Proof.
split.
  intros ab.
  intros ab'.
  intros ab''.
  apply ab.
  split.
  exact ab'.
  exact ab''.
  intros abc.
  intros abc'.
  apply abc.
  destruct abc'.
  exact H.
  destruct abc'.
  exact H0.
Qed.


Lemma exemple135 (A B C : Prop) : (C -> A) \/ (C -> B) -> (C -> A \/ B).
Proof.
intros ab.
  
