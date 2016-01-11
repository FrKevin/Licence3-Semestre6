package fr.univ_lille1.fil.rsx.multicast.network;

import java.io.IOException;

import fr.univ_lille1.fil.rsx.multicast.network.MulticastConnection.Message;

public class MessagesManager {
	
	private MulticastConnection connection;
	
	private List<Message> messagesHistory;
	
	
	
	public MessagesManager(MulticastConnection co) {
		
		
	}
	
	
	
	
	public void send(String message) {
		try {
			connection.send(message);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	public void onReceiveMessage(Message m) {
		
	}
	
}
