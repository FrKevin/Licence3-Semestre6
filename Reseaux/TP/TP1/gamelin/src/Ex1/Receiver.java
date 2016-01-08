package Ex1;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;

public class Receiver {
	
	protected int port;
	protected final int MAX_LENGTH = 1024;
	
	public Receiver(int port){
		this.port = port;
	}
	
	public void receive(){
		System.out.println("--- Receive ---");
		DatagramSocket sock;
		DatagramPacket p;
		try {
			sock = new DatagramSocket(this.port);
			p = new DatagramPacket(new byte[MAX_LENGTH],MAX_LENGTH);
			sock.receive(p);
			System.out.println("paquet reçu de :"+ p.getAddress()+
			 "port "+ p.getPort()+
			 "taille" + p.getLength());
			byte[] array = p.getData();
			for(int i=0; i<p.getLength(); i++){
				System.out.print((char)array[i]);
			}
			sock.close();
			System.out.println();
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
