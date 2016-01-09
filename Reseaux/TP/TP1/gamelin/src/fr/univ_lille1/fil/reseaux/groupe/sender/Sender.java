package fr.univ_lille1.fil.reseaux.groupe.sender;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.net.SocketException;
import java.net.UnknownHostException;

public class Sender {
	
	protected String adresse;
	protected int port;
	protected MulticastSocket multicastSocket;
	
	public Sender(String adresse, int port){
		this.adresse = adresse;
		this.port = port;
		try {
			multicastSocket = new MulticastSocket(this.port);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void joinGroup(){
		try {
			multicastSocket.joinGroup(InetAddress.getByName("224.0.0.1"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void leaveGroupe(){
		try {
			multicastSocket.leaveGroup(InetAddress.getByName("224.0.0.1"));
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		multicastSocket.close();
	}
	
	public void send(String message){
		try {
			byte array[] = message.getBytes();
			DatagramPacket pack = new DatagramPacket(array, array.length, InetAddress.getByName(this.adresse), this.port);
			multicastSocket.send(pack);
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
