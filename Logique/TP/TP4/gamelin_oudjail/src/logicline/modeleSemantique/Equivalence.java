package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Equivalence extends Formule{
	protected Formule fg;
	protected Formule fd;
	
	public Equivalence(Formule fg, Formule fd){
		this.fg = fg;
		this.fd = fd;
	}
	
	@Override
	public String toString() {
		return "("+ fg +") ⇔  ("+ fd +")";
	}

	@Override
	public Set<String> variablesLibres() {
		HashSet<String> set = new HashSet<>();
		set.addAll(this.fg.variablesLibres());
		set.addAll(this.fd.variablesLibres());
		return set;
	}

	@Override
	public Formule substitue(Substitution s) {	
		fg = fg.substitue(s);
		fd = fd.substitue(s);
		return this;
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	protected Formule supprImplications() {
		return new Et(new Ou(new Non(fg), fd), new Ou(fg, new Non(fd)));
	}

	@Override
	protected Formule negation() {
		return new Non(supprImplications());
	}
	
	@Override
	protected Formule entrerNegations() {
		return this;
	}

	@Override
	protected boolean contientEt() {
		return fg.contientEt() || fd.contientEt();
	}
}
