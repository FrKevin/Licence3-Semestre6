package fil.lille1.exo2.main;

import java.io.IOException;
import java.util.Scanner;

import fil.lille1.exo2.udp.Sender;

public class MainSender {
	public static void main(String[] args) {
		// Sender ---------------------- Adresse de ma machine : 192.168.43.46, 172.19.172.240
		String adresse = "224.0.0.1";
		String message = "";
		Sender send = new Sender(adresse);
		String quit = "Q";
		Scanner sc = new Scanner(System.in);
		try {
			while (!message.equals(quit)) {
				System.out.print("Mr Trouchaud : ");
				message = sc.next();
				if(!message.equals(quit)) {
					send.send(message.getBytes());
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sc.close();
		System.out.println("Fin de l'emmission");
	}
}
