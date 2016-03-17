package logicline.modeleSemantique;

public class NotFNCException extends Exception 
{
    public NotFNCException() 
    {
		super("La formule n'est pas en FNC ");
    }
    
    public NotFNCException(Formule f) 
    {
		super("La formule n'est pas en FNC : " + f.toString());
    }
}