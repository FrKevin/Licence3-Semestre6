package main;

import java.io.IOException;

import udp.Receiver;

public class MainReceiver {
	public static void main(String[] args) {
		Receiver receiver = new Receiver();
		byte[] array = null;
		try {
			array = receiver.receiver(1024);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(new String(array));
	}
}
