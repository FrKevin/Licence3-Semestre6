package fr.univ_lille1.fil.reseaux;

public class Main {

	public static void main(String[] args) {
		//Window frame = new Window();
		//frame.setVisible(true);
		
		//Receiver receiver = new Receiver("224.0.0.1", 7654);
		//receiver.joinGroup();
		//System.out.println("Begin receive");
		/*while(true){
			receiver.receive();
		}*/
		Application app = new Application("224.0.0.1", 7654);
	}

}
