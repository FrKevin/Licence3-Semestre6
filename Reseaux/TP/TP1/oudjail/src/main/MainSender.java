package main;

import java.io.IOException;

import udp.Sender;

public class MainSender {
	public static void main(String[] args) {
		// Sender ---------------------- Adresse de ma machine : 192.168.43.46, 172.19.172.240
		String adresse = "172.19.172.240";
		String message = "Toto";
		Sender send = new Sender(adresse);
		
		try {
			send.send(message.getBytes());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		System.out.println("Fin de l'emmission");
	}
}
