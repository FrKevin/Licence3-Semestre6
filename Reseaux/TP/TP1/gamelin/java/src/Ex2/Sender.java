package Ex2;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
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
		InetAddress group;
		MulticastSocket ms;
		DatagramPacket pack;
		try {
			group = InetAddress.getByName(this.adresse);
			ms = new MulticastSocket(7654);
			ms.joinGroup(group);
			byte array[] = message.getBytes();
			pack = new DatagramPacket(array, array.length, group, this.port);
			ms.send(pack);
			ms.close();
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
