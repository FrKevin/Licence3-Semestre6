package rsx.tp3;

import java.net.InetAddress;

import rsx.tp3.dns.DNSPacket;

public class Main {
	
	
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws Exception {
		System.out.println("InetAddress.getByName() (résolution DNS de Java)");
		System.out.println(InetAddress.getByName("www.lifl.fr"));
		
		System.out.println("DNSPacket.getAddressFromHostName() (notre résolution DNS, il se peut que la connexion vers le serveur DNS ne se fasse pas)");
		System.out.println(DNSPacket.getAddressFromHostName("www.lifl.fr", "8.8.8.8", true));
		
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
	public static String bytesToBinaryString(byte[] bytes) {
		String rep = "";
		
		for (byte b : bytes) {
			if (b >= 0 && b < 16)
				rep += "0";
			rep += Integer.toBinaryString(b&0xff)+" ";
		}
		
		
		return rep;
	}
	
	
}
