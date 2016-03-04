import com.strangegizmo.cdb.Cdb;

public class Main {

	public static void main(String[] args) {
		byte[] b = new byte[4];
		b[0] = 0;
		b[1] = 0;
		b[2] = 0;
		b[3] = 0;
		System.out.println(Cdb.hash(b));
	}

}
