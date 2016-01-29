package receive;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class Main {
	public static void main(String[] args) {
		DatagramPacket p;
		DatagramSocket s;
		
		//args[0] port
		byte[] b = new byte[1024];
		
		try {
			p = new DatagramPacket(b, b.length);
			s = new DatagramSocket(Integer.parseInt(args[0]));
			while(true) {
				s.receive(p);
				System.out.println("From " + p.getAddress());
				System.out.println((new String(p.getData())));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
}