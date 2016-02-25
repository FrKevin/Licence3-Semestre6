package logicline.analyseurs;

public class ParserException extends Exception 
{
    public ParserException() 
    {
		super("Probleme pendant l'analyse syntaxique ");
    }
    
    public ParserException(String message) 
    {
		super("Probleme pendant l'analyse syntaxique : " + message);
    }
}