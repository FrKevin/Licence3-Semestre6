import java.io.IOException;
import java.util.Enumeration;

import com.strangegizmo.cdb.Cdb;
import com.strangegizmo.cdb.CdbElement;

public class Main {

	public static void main(String[] args) {
		/* try{
        CdbMake maker = new CdbMake();
        maker.start("ressources/basefile.cdb");
        maker.add("one".getBytes(), "Hello".getBytes());
        maker.add("two".getBytes(), "Goodbye".getBytes());
        maker.finish();
    }catch (Exception e) {e.printStackTrace();}*/
    
	/*try{
        Enumeration em = Cdb.elements("ressources/basefile.cdb");
        while(em.hasMoreElements())
        {
            CdbElement cdbElt = (CdbElement) em.nextElement();
            
            System.out.println("Loop elements : Value :" + new String(cdbElt.getData()) + " Key : " + new String(cdbElt.getKey()));
        }
    }catch (Exception e) { e.printStackTrace(); }
	
	
	}
	*/
		Cdb cdb;
		/*try {
			cdb = new Cdb("ressources/basefile.cdb");
			System.out.println(new String( cdb.find("one".getBytes()) ));
		} catch (IOException e) {
			e.printStackTrace();
		}*/
		byte[] b1 = {(byte)0,(byte)128,(byte)255};
		byte[] b2 = {(byte)0,(byte)0,(byte)0};
		byte[] b3 = {(byte)15,(byte)33,(byte)57};
		byte[] b4 = {(byte)255,(byte)255,(byte)255, (byte)255, (byte)255, (byte)255};
		System.out.println(Cdb.hash(b1));
		System.out.println(Cdb.hash(b2));
		System.out.println(Cdb.hash(b3));
		System.out.println(Cdb.hash(b4));
	}
}