package fr.univ_lille1.fil.reseaux;

import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

import fr.univ_lille1.fil.reseaux.groupe.receiver.Receiver;
import fr.univ_lille1.fil.reseaux.groupe.sender.Sender;
import fr.univ_lille1.fil.reseaux.gui.Window;

public class Application extends KeyAdapter{
	
	protected Window window;
	protected Receiver receiver;
	protected Sender sender;
	
	public Application(String adresse, int port){
		sender = new Sender(adresse, port);
		
		window = new Window(this);
		receiver = new Receiver(adresse, port, window);
		
		run();
	}
	
	public void run(){
		receiver.joinGroup();
		sender.joinGroup();
		
		Thread thread = new Thread(receiver);
		thread.run();
	}
	
	
	@Override
	public void keyPressed(KeyEvent arg0) {
		if(arg0.getKeyCode() == 112){
			sender.send(window.getMessage().getText());
		}
	}

	public Receiver getReceiver() {
		return receiver;
	}

	public Sender getSender() {
		return sender;
	}	
}
