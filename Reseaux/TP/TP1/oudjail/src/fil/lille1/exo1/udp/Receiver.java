package fil.lille1.exo1.udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;

public class Receiver {
	
	private int port;
	
	public static final int DEFAULT_PORT = 1024;


	public Receiver(int port) {
		this.setPort(port);
	}
	
	public Receiver() {
		this(DEFAULT_PORT);
	}
	public byte[] receiver(int length) throws IOException {
		DatagramSocket s;
		DatagramPacket p;
		s = new DatagramSocket(getPort());
		p = new DatagramPacket(new byte[length],length);
		s.receive(p);
		System.out.println("paquet reçu de :"+ p.getAddress()+
		 "port "+ p.getPort()+
		 "taille" + p.getLength());
		byte array[] = p.getData();
		s.close(); 
		return array;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}
}
