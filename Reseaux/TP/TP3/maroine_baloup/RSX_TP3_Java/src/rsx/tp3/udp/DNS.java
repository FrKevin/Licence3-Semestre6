package rsx.tp3.udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.util.Arrays;

public class DNS {
	
	
	public static String sendDNSRequest(DNSRequest rq) {
		
		DatagramPacket p;
		DatagramSocket s = null;
		
		byte[] packet = rq.toByte();
		try {
			s = new DatagramSocket();
			p = new DatagramPacket(packet, packet.length, InetAddress.getByName("8.8.8.8"), 53);
			s.send(p);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		p = new DatagramPacket(new byte[1024], 1024);
		try {
			s.receive(p);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		packet = Arrays.copyOfRange(p.getData(), 0, p.getLength());
		
		String rep = "";
		
		for (byte b : packet) {
			if (b >= 0 && b <= 16)
				rep += "0";
			rep += Integer.toHexString(b&0xff)+" ";
		}
		
		
		return rep;
	}
	
	
	
	
	
	public static void main(String[] args) {
		System.out.println(sendDNSRequest(new DNSRequest("www.univ-lille1.fr")));
	}
	
	
}
