package Ex1;

public class MainOfReceiver {

	public static void main(String[] args) {
		Receiver receiver = new Receiver(1024);
		while(true){
			receiver.receive();
		}
	}

}
