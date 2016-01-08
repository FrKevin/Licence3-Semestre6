package fil.lille1.exo2.main;

import java.io.IOException;

import fil.lille1.exo2.udp.Receiver;

public class MainReceiver {
	
	public static void main(String[] args) {
		Receiver receiver = new Receiver("224.0.0.1");
		byte[] array = null;
		System.out.println("Begin");
		try {
			while (true) {
				array = receiver.receiver(1024);
				System.out.println(new String(array));
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
