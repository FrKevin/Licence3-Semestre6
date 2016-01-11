package fr.univ_lille1.fil.rsx.multicast.interfaces.console;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.NetworkInterface;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import fr.univ_lille1.fil.rsx.multicast.network.MulticastConnection;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager;
import fr.univ_lille1.fil.rsx.multicast.network.MulticastConnection.Message;
import jline.console.ConsoleReader;

public class ConsoleInterface {
	
	
	public static final String ANSI_RESET = "\u001B[0m";
	
	public static final String ANSI_BLACK = "\u001B[30m";
	public static final String ANSI_DARK_RED = "\u001B[31m";
	public static final String ANSI_DARK_GREEN = "\u001B[32m";
	public static final String ANSI_GOLD = "\u001B[33m";
	public static final String ANSI_DARK_BLUE = "\u001B[34m";
	public static final String ANSI_DARK_PURPLE = "\u001B[35m";
	public static final String ANSI_DARK_AQUA = "\u001B[36m";
	public static final String ANSI_GRAY = "\u001B[37m";
	
	public static final String ANSI_DARK_GRAY = "\u001B[30;1m";
	public static final String ANSI_RED = "\u001B[31;1m";
	public static final String ANSI_GREEN = "\u001B[32;1m";
	public static final String ANSI_YELLOW = "\u001B[33;1m";
	public static final String ANSI_BLUE = "\u001B[34;1m";
	public static final String ANSI_LIGHT_PURPLE = "\u001B[35;1m";
	public static final String ANSI_AQUA = "\u001B[36;1m";
	public static final String ANSI_WHITE = "\u001B[37;1m";
	
	public static final String ANSI_BOLD = "\u001B[1m";
	
	public static final String ANSI_CLEAR_SCREEN = "\u001B[2J\u001B[1;1H";
	
	
	public static final DateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
	
	
	
	
	private MulticastConnection connection;
	
	private ConsoleReader reader;
	private PrintWriter out;
	
	private String name = null;
	
	private Map<String, String> aliases = new HashMap<String, String>();
	
	public ConsoleInterface(MulticastConnection co) throws IOException {
		connection = co;
		reader = new ConsoleReader();
		reader.setBellEnabled(false);
		reader.setPrompt("\r"+ANSI_LIGHT_PURPLE+">");
		out = new PrintWriter(reader.getOutput());
		

		println(ANSI_BOLD+"--------------- Chat en multicast ---------------"+ANSI_RESET
				+ "\nAdresse multicast : "+connection.host+":"+connection.port+""
				+ "\n"
				+ "\nPour envoyer un message, écrivez-le et appuyez sur entrée."
				+ "\nPour une commande spécifique, faites-la précéder de '"+ANSI_BOLD+"/"+ANSI_RESET+"'."
				+ "\nFaites juste '"+ANSI_BOLD+"/"+ANSI_RESET+"' pour afficher les commandes."
				+ "\n");
		
	}
	
	
	
	
	
	public void loop() {
		
		String line;
		try {
			while((line = reader.readLine()) != null) {
				if (line.trim().equals(""))
					continue;
				
				if (line.startsWith("/")) {
					String command = line.substring(1);
					
					if (command.equalsIgnoreCase("exit")
							|| command.equalsIgnoreCase("stop")
							|| command.equalsIgnoreCase("end")
							|| command.equalsIgnoreCase("quit")) {
						connection.close();
						System.exit(0);
					}
					else if (command.toLowerCase().startsWith("name ")) {
						name = command.substring(5);
						println("Nom défini à '"+name+"'.");
					}
					else if (command.equalsIgnoreCase("name")) {
						name = null;
						println("Nom retiré.");
					}
					else if (command.toLowerCase().startsWith("alias ")) {
						String[] args = command.substring(6).split(" ", 2);
						aliases.put(args[0], args[1]);
						println("Alias '"+args[1]+"' défini pour '"+args[0]+"'.");
					}
					else if (command.toLowerCase().startsWith("clear")) {
						connection.send(((command.length()>6)?command.substring(6):"")+getMegaClear(25));
					}
					else {
						println("Aides pour les commandes");
						println(""+ANSI_BOLD+"/quit"+ANSI_RESET+" pour quitter.");
						println(""+ANSI_BOLD+"/name <Nom>"+ANSI_RESET+" pour vous donner un nom (qui sera visible pour tout le monde).");
						println(""+ANSI_BOLD+"/name"+ANSI_RESET+" sans paramètre pour retirer ce nom.");
						println(""+ANSI_BOLD+"/alias <HostName> <UserName>"+ANSI_RESET+" pour définir le nom d'une personne pour un nom de machine donné.");
					}
				}
				else {
					try {
						connection.send(((name != null)?(name+" : "):"")+line);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				
				
				
				
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		
		
		
		
	}
	
	
	
	private String getMegaClear(int nb) {
		return nb > 0 ? ANSI_CLEAR_SCREEN + getMegaClear(nb-1) : "";
	}
	
	
	

	@Override
	public void onReceiveMessage(Message m) {
		
		boolean isOwn = false;
		try {
			isOwn = m.address == null || NetworkInterface.getByInetAddress(m.address) != null;
		} catch(Exception e) { }
		
		
		String disp = ANSI_BLUE + dateFormat.format(new Date()) + ANSI_RESET + " ";
		if (isOwn) {
			disp += ANSI_YELLOW
					+ "Cet ordi" + ANSI_RESET;
		}
		else {
			String host = m.address.getHostName();
			host = host.replace(".univ-lille1.fr", "");
			boolean hostReplaced = false;
			if (aliases.get(host) != null) {
				host = aliases.get(host);
				hostReplaced = true;
			}
			
			disp += (hostReplaced ? ANSI_GREEN : ANSI_DARK_GREEN)
					+ host + ANSI_RESET;
		}
		
		disp += ANSI_GOLD
				+ "> "
				+ ANSI_RESET
				+ m.data.replace(ANSI_CLEAR_SCREEN, "")
				+ ANSI_RESET;
		
		
		
		println(disp);
		
		
	}
	
	
	
	private synchronized void println(String str) {
		try {
			out.println('\r'+ANSI_RESET+str);
			out.flush();
			reader.drawLine();
			reader.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
