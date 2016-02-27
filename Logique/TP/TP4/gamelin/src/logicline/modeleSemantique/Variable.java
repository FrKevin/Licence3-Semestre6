package logicline.modeleSemantique;

import java.util.Set;

public class Variable extends Formule{
	protected String name;
	
	public Variable(String name){
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "id";
	}

	@Override
	public Set<String> variablesLibres() {
		// TODO Auto-generated method stub
		return null;
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
