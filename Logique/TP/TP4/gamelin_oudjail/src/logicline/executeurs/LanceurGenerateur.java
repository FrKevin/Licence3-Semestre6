package logicline.executeurs;

import logicline.analyseurs.*;

import logicline.modeleSemantique.*;

import java.io.*; 
import java_cup.runtime.Symbol;
import java.util.List;

public class LanceurGenerateur {

    public static void main(String[] args) throws Exception 
    {
        if (args.length > 1)
            System.out.println("Attention: un seul fichier pris en compte");
        new LanceurGenerateur().run(args);
    }

    public void run(String[] args) throws Exception 
    {
        Reader flotLecture = obtenirFlotDepuisFichierOuEntreeStandard(args);
        ScannerLogic scanner = construireAnalyseurLexical(flotLecture);
        ParserLogic parser = new ParserLogic(scanner);
        Symbol symboleProgramme = parser.parse();
        this.genere(symboleProgramme);
    }

    private Reader obtenirFlotDepuisFichierOuEntreeStandard (String[] argsLigneCommande) 
    throws FileNotFoundException 
    {
        if (argsLigneCommande.length == 0)
            return new InputStreamReader(System.in);
        return new FileReader(argsLigneCommande[0]);
    }

    private ScannerLogic construireAnalyseurLexical(Reader flot) 
    {
        return new ScannerLogic(flot);            
    }    

    private void genere(Symbol symboleProgramme) 
    throws Exception 
    {
/*
        // Liste des differents plannings du fichier
        List<Planning> p = ((ListePlannings) symboleProgramme.value).getListePlannings();

        // Pour chaque planning, on cree un fichier, on imprime le contenu genere du planning et on ferme le fichier. 
        for (Planning planning : p)
        {
            PrintStream output = new PrintStream(new FileOutputStream(planning.getIntro()+".html"));
            output.print(planning.genere());
            output.close();
        }
        */
    }
}
