package udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

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
		DatagramSocket s;
		InetAddress dst = InetAddress.getByName(adresse);
		int port = 1024 ;
		p = new DatagramPacket(message, message.length, dst, port);
		s = new DatagramSocket();
		s.send(p);
		s.close(); 
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
