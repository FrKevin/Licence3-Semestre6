(* partie 1 *)

Fixpoint tminus (n m : nat) : nat :=
  match n with
  | O => O
  | S n' => match m with
            | O => n
            | S m' => tminus n' m'
            end
  end.

Compute tminus 5 3.
Compute tminus 5 6.

Require Import Arith.

Fixpoint pminus (n m : nat) : m <= n -> nat.
Abort.

Lemma O_le_5 : 3 <= 5.
Proof.
auto.
Qed.

Fail Compute pminus 5 3 O_le_5.

Fixpoint iminus (n m : nat) : m <= n -> { k : nat | k + m = n }.
Abort.

Fail Compute (proj1_sig (iminus 5 3 O_le_5)).

Fixpoint sminus (n m : nat) : m <= n -> { k : nat | k + m = n }.
Abort.

(* partie 2 *)

Definition var := nat.

Inductive exp :=
| exp_var : var -> exp
| cst : nat -> exp
| mul : exp -> exp -> exp
| sub : exp -> exp -> exp.

Inductive bexp :=
| equa : exp -> exp -> bexp
| neg : bexp -> bexp.

Inductive cmd : Type :=
| assign : var -> exp -> cmd
| seq : cmd -> cmd -> cmd
| while : bexp -> cmd -> cmd.

Definition state := var -> nat.

Definition sample_state : state :=
  fun x =>
    match x with
    | O => 4
    | 1 => 5
    | _ => O
    end.

Require Import Arith.

Definition upd (v : var) (a : nat) (s : state) : state :=
  fun x => match Nat.eq_dec x v with
           | left _ (* x = y *) => a
           | right _ => s x
           end.

Fixpoint eval e s :=
  match e with
  | exp_var v => s v
  | cst n => n
  | mul v1 v2 => eval v1 s * eval v2 s
  | sub v1 v2 => eval v1 s - eval v2 s
  end.

Fixpoint beval b s :=
  match b with
    | equa e1 e2 => eval e1 s = eval e2 s
    | neg b => ~ beval b s
  end.

Definition ret : var := O.
Definition x : var := 1.

Compute eval (mul (exp_var ret) (exp_var x)) sample_state.

Lemma eval_upd_same str v s : eval (exp_var str) (upd str v s) = v.
Proof.
simpl.
unfold upd.
destruct Nat.eq_dec.
apply eq_refl.
tauto.
Qed.

Lemma eval_upd_diff str str' v s : str <> str' -> eval (exp_var str) (upd str' v s) = eval (exp_var str) s.
Proof.
intros H.
simpl.
unfold upd.
destruct Nat.eq_dec.
  tauto.
apply eq_refl.
Qed.

Definition assert := state -> Prop.

Definition imp (P Q : assert) := forall s, P s -> Q s.

Inductive hoare : assert -> cmd -> assert -> Prop :=
| hoare_assign : forall (Q : assert) v e,
  hoare (fun s => Q (upd v (eval e s) s)) (assign v e) Q
| hoare_seq : forall Q P R c d,
  hoare P c Q -> hoare Q d R ->
  hoare P (seq c d) R
| hoare_conseq : forall (P' Q' P Q : assert) c,
  imp P P' -> imp Q' Q -> hoare P' c Q' ->
  hoare P c Q
| hoare_while : forall P b c,
  hoare (fun s => P s /\ beval b s) c P ->
  hoare P (while b c) (fun s => P s /\ ~ (beval b s)).

Lemma hoare_stren : forall (P' P Q : assert) c,
  imp P P' -> hoare P' c Q -> hoare P c Q.
Proof.
intros P' P Q c PP' H.
apply (hoare_conseq P' Q).
auto.
unfold imp.
auto.
auto.
Qed.

Definition facto (x ret : var) :=
  while (neg (equa (exp_var x) (cst O)))
    (seq
       (assign ret (mul (exp_var ret) (exp_var x)))
       (assign x (sub (exp_var x) (cst 1)))).

Require Import Omega.
Require Import Factorial.

Lemma fact_fact n : 1 <= n -> fact (n - 1) * n = fact n.
Proof.
destruct n as [|n].
omega.
intros _.
simpl.
rewrite Nat.sub_0_r.
rewrite Nat.mul_succ_r.
rewrite Nat.mul_comm.
omega.
Qed.

Require Import Omega.
Require Import Factorial.

Lemma facto_fact x X ret : x <> ret ->
  hoare
    (fun s => eval (exp_var x) s = X /\
              eval (exp_var ret) s = 1)
    (facto x ret)
    (fun s => eval (exp_var ret) s = fact X).
Proof.
intros xret.
set (P' := fun s : state => eval (exp_var ret) s *
  fact (eval (exp_var x) s) = fact X).
set (Q' := fun s : state => eval (exp_var ret) s *
  fact (eval (exp_var x) s) = fact X /\
   ~ (beval (neg (equa (exp_var x) (cst O))) s)).
apply (hoare_conseq P' Q').
Abort.