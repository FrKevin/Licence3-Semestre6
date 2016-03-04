package Ex1;

public class MainOfSender {

	public static void main(String[] args) {
		System.out.println("rrr");
		Sender sender = new Sender(1024, "www.univ-lille1.fr");
		sender.send("Bonjour");
	}

}
