package Ex2;

public class MainOfSender {

	public static void main(String[] args) {
		System.out.println("rrr");
		Sender sender = new Sender(7654, "224.0.0.1");
		sender.send("Bonjour");
	}

}
