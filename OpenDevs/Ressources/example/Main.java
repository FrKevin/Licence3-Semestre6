import com.strangegizmo.cdb.Cdb;
import com.strangegizmo.cdb.CdbElement;
import com.strangegizmo.cdb.CdbMake;

import java.io.IOException;
import java.util.Enumeration;

class Main
{ 
    public static void main(String args[])
    {
        /*try{
            CdbMake maker = new CdbMake();
            maker.start("ressources/basefile.cdb");
            maker.add("one".getBytes(), "Hello".getBytes());
            maker.add("two".getBytes(), "Goodbye".getBytes());
            maker.finish();
        }catch (Exception e) {e.printStackTrace();}
        */
    	try
        {
            Enumeration em = Cdb.elements("ressources/basefile.cdb");
            while(em.hasMoreElements())
            {
                CdbElement cdbElt = (CdbElement) em.nextElement();
                
                System.out.println("Loop elements : Value :" + new String(cdbElt.getData()) + " Key : " + new String(cdbElt.getKey()));
            }
        }catch (Exception e) { e.printStackTrace(); }
    	
    	try {
			Cdb cdb = new Cdb("ressources/basefile.cdb");
			System.out.println(new String(cdb.find("one".getBytes())));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}