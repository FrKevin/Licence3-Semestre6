package fr.univ_lille1.fil.rsx.multicast;

import java.io.IOException;
import java.net.InetAddress;

import fr.univ_lille1.fil.rsx.multicast.interfaces.console.ConsoleInterface;
import fr.univ_lille1.fil.rsx.multicast.network.MulticastConnection;

public class MulticastChat {
	
	public static void main(String[] args) throws IOException {

		InetAddress host = InetAddress.getByName("224.0.0.1");
		int port = 7654;
		
		MulticastConnection connection = new MulticastConnection(host, port);
		
		
		ConsoleInterface interf = new ConsoleInterface(connection);
		
		
		
		
		connection.setListener(interf);
		
		
		interf.loop();
		
		
		connection.close();
	}

}
