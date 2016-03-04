(* Voir l'enonce a la page suivante: https://staff.aist.go.jp/reynald.affeldt/coq/.
   Il s'agit essentiellement de remplacer les "Abort" par les scripts
   "Proof. [tactiques] Qed." adequats. *)

(* partie 1 *)

Lemma hilbertS (A B C : Prop) :
  (A -> B -> C) -> (A -> B) -> A -> C.
Abort.

(* partie 2.1 *)

Lemma exo1 (P Q : Prop) : P -> (Q -> P).
Abort.

Lemma exo2 (P Q : Prop) : P -> ( ~ P -> Q).
Abort.

Lemma exo3 (P Q R : Prop) : (P -> Q) -> ((Q -> R) -> (P -> R)).
Abort.

Lemma exo4 (P Q : Prop) : (P -> Q) -> ( ~ Q -> ~ P).
Abort.

Require Import Classical.

Lemma bottom_c (A : Prop) : ((~A) -> False) -> A.
Abort.

Lemma exo5 (P Q : Prop) : ( ~ Q -> ~ P) -> (P -> Q).
Abort.

Lemma exo6 (P : Prop) : ~ ~ P -> P.
Abort.

Lemma exo7 (P : Prop) : P -> ~ ~ P.
Abort.

Lemma exo8 (P Q R : Prop) : (P -> (Q -> R)) -> (P /\ Q -> R).
Abort.

Lemma exo9 (P Q R : Prop) : (P /\ Q -> R) -> (P -> (Q -> R)).
Abort.

Lemma exo10 (P : Prop) : P /\ ~ P -> False.
Abort.

Lemma exo11 (P : Prop) : False -> P /\ ~ P.
Abort.

(* partie 2.2 *)

Lemma exo12 (P Q : Prop) : P \/ Q <-> ~ ( ~ P /\ ~ Q).
Abort.

Lemma exo13 (P : Prop) : ~ P <-> (P -> False).
Abort.

Lemma exo14 (P Q : Prop) : (P <-> Q) <-> (P -> Q) /\ (Q -> P).
Abort.

(* partie 3 *)

Lemma exemple134 (A B C : Prop) : (A /\ B -> C) <-> (A -> B -> C).
Abort.

Lemma exemple135 (A B C : Prop) : (C -> A) \/ (C -> B) -> (C -> A \/ B).
Abort.

Lemma exemple_136 (X : Type) (A B : X -> Prop) :
  ((forall x, A x) \/ (forall x, B x)) -> forall x, A x \/ B x.
Abort.

Lemma exemple_137 (X : Type) (A B : X -> Prop) :
  (exists x, A x /\ B x) -> ((exists x, A x) /\ (exists x, B x)).
Abort.

Lemma exemple_138 (A B : Prop) : ~ (A /\ B) -> ( ~ A \/ ~ B).
Abort.

Lemma exemple_138' (A B : Prop) : ~ (A /\ B) -> ( ~ A \/ ~ B).
Abort.

Lemma exemple_139 (X : Type) : forall (x1 x2 : X), x1 = x2 -> x2 = x1.
Abort.

Lemma exemple_140 (X : Type) : forall (x1 x2 x3 : X), x1 = x2 /\ x2 = x3 -> x1 = x3.
Abort.

(* partie 4 *)

Definition FALSE : Prop := forall (P : Prop), P.

Lemma FALSE_False : FALSE <-> False.
Abort.

Definition AND (A B : Prop) := forall (P : Prop), (A -> B -> P) -> P.

Definition OR (A B : Prop) := forall (P : Prop), ((A -> P) -> (B -> P) -> P).

Definition EX (A : Type) (P : A -> Prop) := forall (Q : Prop), (forall a, P a -> Q) -> Q.

Definition EQ (A : Type) (a a' : A) := forall (P : A -> Prop), P a -> P a'.

Lemma SPLIT (A B : Prop) : A -> B -> AND A B.
Abort.

Lemma PROJ1 (A B : Prop) : AND A B -> A.
Abort.

Lemma PROJ2 (A B : Prop) : AND A B -> B.
Abort.

Lemma ORINTROL (A B : Prop) : A -> OR A B.
Abort.

Lemma ORINTROR (A B : Prop) : B -> OR A B.
Abort.

Lemma AND_and (A B : Prop) : AND A B <-> A /\ B.
Abort.

Lemma OR_or (A B : Prop) : OR A B <-> A \/ B.
Abort.

Lemma EX_exists (A : Type) (P : A -> Prop) : EX A P <-> exists a, P a.
Abort.

Lemma EQ_eq (A : Type) (a a' : A) : EQ _ a a' <-> a = a'.
Abort.
