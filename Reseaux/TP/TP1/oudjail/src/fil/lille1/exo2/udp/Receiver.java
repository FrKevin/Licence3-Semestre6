package fil.lille1.exo2.udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;

public class Receiver {
	
	private int port;
	private String adresse;
	
	public static final int DEFAULT_PORT = 7654;


	public Receiver(int port, String adresse) {
		this.setPort(port);
		this.setAdresse(adresse);
	}
	
	public Receiver(String adresse) {
		this(DEFAULT_PORT, adresse);
	}
	public byte[] receiver(int length) throws IOException {
		MulticastSocket ms;
		DatagramPacket p;
		ms = new MulticastSocket(getPort());
		ms.joinGroup(InetAddress.getByName(adresse));
		p = new DatagramPacket(new byte[length],length);
		ms.receive(p);
		System.out.println("Paquet reçu de : " + p.getAddress().getHostName() + " adresse : " + p.getAddress().getHostAddress()+
		 " port : "+ p.getPort()+
		 " taille : " + p.getLength());
		byte array[] = p.getData();
		ms.leaveGroup(InetAddress.getByName(adresse));
		ms.close(); 
		return array;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getAdresse() {
		return adresse;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
}
