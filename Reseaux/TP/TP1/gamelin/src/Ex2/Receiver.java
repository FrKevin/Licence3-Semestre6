package Ex2;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.net.SocketException;

public class Receiver {
	
	protected int port;
	protected final int MAX_LENGTH = 1024;
	
	public Receiver(int port){
		this.port = port;
	}
	
	public void receive(){
		System.out.println("--- Receive ---");
		MulticastSocket ms;
		try {
			ms = new MulticastSocket(this.port);
			ms.joinGroup(InetAddress.getByName("224.0.0.1"));
			DatagramPacket pack = new DatagramPacket(new byte[MAX_LENGTH],MAX_LENGTH);
			ms.receive(pack);
			System.out.println("paquet reçu de : "+ pack.getAddress()+
			 "port "+ pack.getPort()+
			 "taille" + pack.getLength());
			byte[] array = pack.getData();
			for(int i=0; i<pack.getLength(); i++){
				System.out.print((char)array[i]);
			}
			ms.leaveGroup(InetAddress.getByName("224.0.0.1"));
			ms.close();
			System.out.println();
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
