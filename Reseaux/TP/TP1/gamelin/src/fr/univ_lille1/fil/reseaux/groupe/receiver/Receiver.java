package fr.univ_lille1.fil.reseaux.groupe.receiver;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;

import fr.univ_lille1.fil.reseaux.gui.Window;

public class Receiver implements Runnable {
	
	protected String adresse;
	protected int port;
	protected final int MAX_LENGTH = 1024;
	protected MulticastSocket multicastSocket;
	protected Window window;
	
	public Receiver(String adresse, int port, Window window){
		this.adresse = adresse;
		this.port = port;
		this.window = window;
		try {
			this.multicastSocket = new MulticastSocket(this.port);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void joinGroup(){
		try {
			multicastSocket.joinGroup(InetAddress.getByName(adresse));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void leaveGroupe(){
		try {
			multicastSocket.leaveGroup(InetAddress.getByName(adresse));
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		multicastSocket.close();
	}
	
	public void receive(){
		try {
			
			DatagramPacket pack = new DatagramPacket(new byte[MAX_LENGTH],MAX_LENGTH);
			multicastSocket.receive(pack);
			String msg = "paquet reçu de : "+ pack.getAddress() + " port "+ pack.getPort() + " taille" + pack.getLength() + " hostname " + pack.getAddress().getHostName() + ": ";
			msg += new String(pack.getData(), StandardCharsets.UTF_8).toString();
			window.seText(msg);
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void run() {
		while(true) {
			receive();
		}
	}
}
