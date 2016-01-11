package fr.univ_lille1.fil.rsx.multicast.network;

import java.io.Closeable;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MulticastSocket;
import java.net.SocketException;
import java.util.Arrays;
import java.util.Date;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

public class MulticastConnection implements Closeable {
	
	public final InetAddress host;
	public final int port;
	private AtomicReference<MessagesManager> listener = new AtomicReference<MessagesManager>(null);
	
	private MulticastSocket socket;
	
	private Thread receiveThread;
	
	private AtomicBoolean stop = new AtomicBoolean(false);
	
	
	public MulticastConnection(InetAddress h, int p) {
		
		port = p;
		
		host = h;
		
		try {
			socket = new MulticastSocket(port);
			socket.setLoopbackMode(false);
			socket.joinGroup(host);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		
		
		
		receiveThread = new Thread(new Runnable() {
			@Override public void run() {
				try {
					while(!stop.get()) {
						DatagramPacket p = new DatagramPacket(new byte[1024], 1024);
						
						socket.receive(p);
						
						byte[] data = Arrays.copyOf(p.getData(), p.getLength());
						String mess;
						try {
							mess = new String(data);
						} catch(Exception e) {
							mess = e.toString();
						}
						passMessageToListener(new Message(mess, p.getAddress()));
					}
				} catch (SocketException e) {
				} catch (IOException e) {
					e.printStackTrace();
				}
				stop.set(true);
			}
		});
		
		receiveThread.start();
		
	}
	
	
	
	
	public synchronized void send(String data) throws IOException {
		if (stop.get())
			return;
		
		
		DatagramPacket p = new DatagramPacket(data.getBytes(), data.getBytes().length, host, port);
		
		
		socket.send(p);
		
	}
	
	
	
	
	private void passMessageToListener(Message m) {
		try {
			if (listener.get() != null)
				listener.get().onReceiveMessage(m);
			else
				System.out.println("Skipped message : "+m+" because there is no registered listener");
		} catch (Throwable t) {
			t.printStackTrace();
		}
	}
	
	
	
	
	
	public void setListener(MessagesManager l) {
		listener.set(l);
	}
	
	
	
	
	public synchronized void close() {
		stop.set(true);
		
		try {
			socket.leaveGroup(host);
			socket.close();
		} catch (IOException e1) { }
		
		try { receiveThread.join(); } catch (InterruptedException e) { }
	}
	
	
	
	
	
	
	
	
	
	public static class Message {
		public final Date date;
		public final String data;
		public final InetAddress address;
		private int count = 1;
		
		public Message(String d, InetAddress a) {
			if (d == null) throw new IllegalArgumentException("d can't be null.");
			data = d;
			address = a;
			date = new Date();
		}
		
		@Override
		public String toString() {
			return "Message[address="+address+";data="+data+"]";
		}
		
		
		public boolean canBeMergedWith(Message m, long maxTimeDiff) {
			if (!data.equals(m.data))
				return false;
			if (address == null && m.address != null)
				return false;
			if (address != null && !address.equals(m.address))
				return false;
			return (date.getTime() + maxTimeDiff > m.date.getTime());
		}
		
	}
	

}
