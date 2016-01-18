package Ex1;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;

public class Sender {
	
	protected int port;
	protected String adresse;
	
	public Sender( int port, String adresse){
		this.port = port;
		this.adresse = adresse;
	}
	
	public void send(String message){
		DatagramPacket p;
		DatagramSocket s;
		InetAddress dst;
		try {
			dst = InetAddress.getByName(this.adresse);
			byte array[] = message.getBytes();
			p = new DatagramPacket(array, array.length, dst, this.port);
			s = new DatagramSocket();
			s.send(p);
			s.close();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
