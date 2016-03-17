package logicline.analyseurs;       

import java_cup.runtime.Symbol;

/** Un Symbole qui possède une représentation textuelle.
 * @version 12/12/04 revu 09/09
 * @author M. Nebut
 */
public class Symbole extends Symbol 
{
    
    private String representationTextuelle;

    public Symbole(String representationTextuelle, int type) 
    {
	   super(type);
	   this.representationTextuelle = representationTextuelle;
    }

    public Symbole(String representationTextuelle, int type, Object valeur) 
    {
	   super(type,valeur);
	   this.representationTextuelle = representationTextuelle;
    }

    public Symbole(String representationTextuelle, int type, int line, int column) 
    {
	   super(type,line,column);
	   this.representationTextuelle = representationTextuelle;
    }

    public Symbole(String representationTextuelle, int type, Object valeur, int line, int column) 
    {
	   super(type,line,column,valeur);
	   this.representationTextuelle = representationTextuelle;
    }

    public Symbole(int type, Object valeur) 
    {
	   super(type,valeur);
    }

    public Symbole(int type) 
    {
	   super(type);
    }

    public String toString() 
    {
	   return this.sym + " : " + this.representationTextuelle + " , attribut = [" + this.value +"]";
    }

    public String getRepresentationTextuelle() 
    {
	   return this.representationTextuelle;
    }

    public int getType() 
    {
	   return super.sym;
    }
}