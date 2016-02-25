package logicline.modeleSemantique;

import java.util.*;

public abstract class Formule {
	public Formule(){}

	//retourne une représentation ASCII de la formule logique
	public abstract String toString();

	//supprime toutes les implications de la formule
	protected Formule supprImplications() { return this; }

	//déplace les non à l'intérieur des formules
	protected Formule entrerNegations() { return this; }

	//Retourne la formule représentant la négation de this
	protected Formule negation() { return new Non(this); }

	//Retourne vrai si la formule contient un Et
	protected boolean contientEt() { return false; }

	//Retourne une formule équivalente à OU(this, d)
	protected Formule ougauche(Formule d) { return d.oudroite(this); }

	//Retourne une formule équivalente à OU(g, this), g ne contenant pas de ET
	protected Formule oudroite(Formule g) { return new Ou(g, this); }

	//déplace les non à l'intérieur des formules
	protected Formule entrerDisjonctions() { return this; }

	//transforme la formule en FNC
	public Formule fnc() 
	{ 
		Formule f = this.supprImplications();
		f = f.entrerNegations();
		f = f.entrerDisjonctions();
		return f; 
	}

	//retourne la liste des clauses d'une formule en FNC
	public ListeClauses clauses() throws NotFNCException, TrueClauseException, FalseClauseException, VariableClauseException { throw new NotFNCException(this); }

	//retourne la liste des noms des variables libres de la formule
	public abstract Set<String> variablesLibres();

	//effectue une substitution dans une formule
	public abstract Formule substitue(Substitution s);

	//retourne l'évaluation de la formule
	public abstract boolean valeur() throws VariableLibreException;

	//affiche la table de vérité de la formule
	public void tableVerite() 
	{
		//À compléter
	}
}
