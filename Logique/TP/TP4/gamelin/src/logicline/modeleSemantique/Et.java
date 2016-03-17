package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Et extends Formule{
	protected Formule fg;
	protected Formule fd;
	
	public Et(Formule fg, Formule fd){
		this.fg = fg;
		this.fd = fd;
	}
	
	@Override
	public String toString() {
		return "("+ fg +") ∧  ("+ fd +")";
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
		fd = this.fd.substitue(s);
		fg = this.fg.substitue(s);
		return this;
	}
	
	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	protected Formule supprImplications() {
		return this;
	}

	@Override
	protected Formule negation() {
		return new Ou(new Non(fg), new Non(fd));
	}

	@Override
	protected Formule entrerNegations() {
		return this;
	}

	@Override
	protected boolean contientEt() {
		return true;
	}

}
