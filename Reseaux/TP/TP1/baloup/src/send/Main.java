package send;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class Main {
	public static void main(String[] args) {
		DatagramPacket p;
		DatagramSocket s;
		
		//args[0] message
		//args[1] host
		//args[2] port
		
		byte[] b = args[0].getBytes();
		
		try {
			p = new DatagramPacket(b, b.length, InetAddress.getByName(args[1]), Integer.parseInt(args[2]));
			s = new DatagramSocket();
				s.send(p);
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
}
