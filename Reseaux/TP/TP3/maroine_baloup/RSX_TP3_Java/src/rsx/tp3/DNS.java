package rsx.tp3;

import java.net.DatagramSocket;
import java.net.InetAddress;

public class DNS {
	
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws Exception {
		DNSPacket query = DNSPacket.createSimpleQuery("www.univ-lille1.fr");

		DatagramSocket socket = new DatagramSocket();
		
		query.send(socket, InetAddress.getByName("8.8.8.8"), 53);
		
		DNSPacket response = query.waitForDNSResponse(socket);
		
		// TODO afficher la réponse
		System.out.println("Données en Hexa :");
		System.out.println(bytesToHexaString(response.toByte()));
		
	}
	
	
	
	
	
	
	
	
	
	
	
	public static String bytesToHexaString(byte[] bytes) {
		String rep = "";
		
		for (byte b : bytes) {
			if (b >= 0 && b <= 16)
				rep += "0";
			rep += Integer.toHexString(b&0xff)+" ";
		}
		
		
		return rep;
	}
	
	
}
