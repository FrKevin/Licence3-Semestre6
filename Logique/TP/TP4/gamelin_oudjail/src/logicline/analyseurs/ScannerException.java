package logicline.analyseurs;

public class ScannerException extends Exception 
{
    public ScannerException() 
    {
		super("Probleme pendant l'analyse lexicale ");
    }
    
    public ScannerException(String message) 
    {
		super("Probleme pendant l'analyse lexicale : " + message);
    }
}