package cdb;

public class Main {

	public static void main(String[] args) {
		for (int i = 0; i < 30000; i++) {
			if(i >>> 8 != i >> 8)
				System.out.println("false: "+ (i >>> 8) +" et "+ (i >> 8));
		}
	}

}
