package rsx.tp3.udp;

import java.util.Arrays;

public class DNSRequest {
	
	private String address;
	
	
	public DNSRequest(String addr) {
		address = addr;
	}
	
	
	
	
	
	
	
	public byte[] toByte() {
		byte[] buffer = new byte[1024];
		buffer[0] = (byte) 0x08; buffer[1] = (byte) 0xbb;
		buffer[2] = (byte) 0x01; buffer[3] = (byte) 0x00;
		buffer[4] = (byte) 0x00; buffer[5] = (byte) 0x01;
		buffer[6] = (byte) 0x00; buffer[7] = (byte) 0x00;
		buffer[8] = (byte) 0x00; buffer[9] = (byte) 0x00;
		buffer[10] = (byte) 0x00; buffer[11] = (byte) 0x00;
		
		int i = 12;
		
		// séparation des parties de l'adresse
		String[] parts = address.split(".");
		
		for (String part : parts) {
			byte[] chars = part.getBytes();
			
			buffer[i++] = (byte) chars.length;
			
			for (int j=0; j<chars.length; j++)
				buffer[i++] = chars[j];
			
		}
		
		buffer[i++] = (byte) 0;
		buffer[i++] = (byte) 0x00; buffer[i++] = (byte) 0x01;
		buffer[i++] = (byte) 0x00; buffer[i++] = (byte) 0x01;
		
		
		return Arrays.copyOfRange(buffer, 0, i);
		
	}

}
