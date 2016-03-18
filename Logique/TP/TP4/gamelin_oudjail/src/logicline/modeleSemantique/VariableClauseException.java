package logicline.modeleSemantique;

public class VariableClauseException extends Exception 
{
    public VariableClauseException(String n) 
    {
        nom = n;
    }
    public String nom;
}