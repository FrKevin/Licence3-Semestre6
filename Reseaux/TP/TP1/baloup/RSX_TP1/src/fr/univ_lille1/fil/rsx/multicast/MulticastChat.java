package fr.univ_lille1.fil.rsx.multicast;

import java.io.IOException;
import java.net.InetAddress;

import javax.swing.UIManager;

import fr.univ_lille1.fil.rsx.multicast.interfaces.console.ConsoleInterface;
import fr.univ_lille1.fil.rsx.multicast.interfaces.gui.GraphicalInterface;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager;
import fr.univ_lille1.fil.rsx.multicast.network.MulticastConnection;

public class MulticastChat {
	
	public static void main(String[] args) throws IOException {
		
		try {
			// donne à l'interface graphique le thème associé au système d'exploitation
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) { }

		InetAddress host = InetAddress.getByName("224.0.0.1");
		int port = 7654;
		
		MulticastConnection connection = new MulticastConnection(host, port);
		
		MessagesManager messagesManager = new MessagesManager(connection);
		
		connection.setMessageManager(messagesManager);
		
		if (System.console() != null) {
			// lancé via une console, ou en utilisant (pour Windows) l'exécutable java.exe au lieu de javaw.exe
			ConsoleInterface console = new ConsoleInterface(messagesManager);
			
			messagesManager.addInterface(console);
			
			console.loop();
		}
		else {
			GraphicalInterface ui = new GraphicalInterface(messagesManager);
			
			messagesManager.addInterface(ui);
			
			ui.waitForDispose();
		}
		
		
		
		connection.close();
	}

}
