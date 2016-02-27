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
		return "("+ fg +") ⇔ ("+ fd +")";
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

}
