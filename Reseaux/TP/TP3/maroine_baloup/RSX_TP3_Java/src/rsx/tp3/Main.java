package rsx.tp3;

import java.net.DatagramSocket;
import java.net.InetAddress;

public class Main {
	
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws Exception {
		System.out.println("---------- Requête : ----------");
		DNSPacket query = DNSPacket.createSimpleQuery("www.google.fr");
		
		query.displayData();
		
		DatagramSocket socket = new DatagramSocket();
		query.send(socket, InetAddress.getByName("8.8.8.8"), 53);
		
		DNSPacket response = query.waitForDNSResponse(socket);
		
		System.out.println("\n\n\n---------- Réponse : ----------\n");
		
		response.displayData();
		
	}
	
	
	
	
	
	
	
	
	
	
	
	public static String bytesToHexaString(byte[] bytes) {
		String rep = "";
		
		for (byte b : bytes) {
			if (b >= 0 && b < 16)
				rep += "0";
			rep += Integer.toHexString(b&0xff)+" ";
		}
		
		
		return rep;
	}
	
	
}
