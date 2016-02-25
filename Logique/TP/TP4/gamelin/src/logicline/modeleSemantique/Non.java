package logicline.modeleSemantique;

import java.util.HashSet;
import java.util.Set;

public class Non extends Formule{
	protected Formule formule;
	
	public Non(Formule formule) {
		this.formule = formule;
	}

	@Override
	public String toString() {
		return "("+ formule + ")";
	}

	@Override
	public Set<String> variablesLibres() {
		HashSet<String> set = new HashSet<>();
		set.addAll(formule.variablesLibres());
		return set;
	}

	@Override
	public Formule substitue(Substitution s) {
		return null;
	}

	@Override
	public boolean valeur() throws VariableLibreException {
		// TODO Auto-generated method stub
		return false;
	}

}
