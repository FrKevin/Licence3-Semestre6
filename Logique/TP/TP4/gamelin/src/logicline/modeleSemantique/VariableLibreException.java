package logicline.modeleSemantique;

public class VariableLibreException extends Exception 
{
    public VariableLibreException(String v) 
    {
		super("Variable libre non instanciée " + v + " ");
    }
}