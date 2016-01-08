package fil.lille1.exo1.udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;


public class Sender {
	
	private int port;
	private String adresse;
	
	public static final int DEFAULT_PORT = 1024;
	
	public Sender(int port, String adresse) {
		this.setPort(port);
		this.setAdresse(adresse);
	}
	
	public Sender(String adresse) {
		this(DEFAULT_PORT, adresse);
	}
	public void send(byte[] message) throws IOException {
		DatagramPacket p;
		MulticastSocket ms;
		ms = new MulticastSocket(port);
		InetAddress group = InetAddress.getByName(adresse);
		ms.joinGroup(group);
		p = new DatagramPacket(message, message.length, group, port);
		ms.send(p);
		ms.leaveGroup(group);
		ms.close(); 
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
