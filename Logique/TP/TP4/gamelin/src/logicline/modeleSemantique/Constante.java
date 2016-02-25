package logicline.modeleSemantique;

import java.util.Set;

public class Constante extends Formule{
	public boolean b;
	
	public Constante(boolean b){
		this.b = b;
	}
	
	@Override
	public String toString() {
		if(b){
			return "T";
		}
		else{
			return "⊥";
		}
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
