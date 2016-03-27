package multicast_chat.interfaces.console;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import jline.console.ConsoleReader;
import multicast_chat.interfaces.UserInterface;
import multicast_chat.interfaces.gui.GraphicalInterface;
import multicast_chat.network.MessagesManager;
import multicast_chat.network.MessagesManager.ReadOnlyMessage;

public class ConsoleInterface implements UserInterface {
	
	
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
	
	
	
	
	private MessagesManager messagesManager;
	
	private ConsoleReader reader;
	private PrintWriter out;
	
	
	
	private GraphicalInterface launchedGUI = null;
	
	public ConsoleInterface(MessagesManager m) throws IOException {
		messagesManager = m;
		reader = new ConsoleReader();
		reader.setBellEnabled(false);
		reader.setPrompt("\r"+ANSI_LIGHT_PURPLE+">");
		out = new PrintWriter(reader.getOutput());
		

		println(ANSI_BOLD+"--------------- Chat en multicast ---------------"+ANSI_RESET
				+ "\nAdresse multicast : "+messagesManager.getConnection().host+":"+messagesManager.getConnection().port+""
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
						println("Déconnexion ...");
						return;
					}
					else if (command.toLowerCase().startsWith("name ")) {
						messagesManager.setDisplayName(command.substring(5), this);
						println("Nom défini à '"+messagesManager.getDisplayName()+"'.");
					}
					else if (command.equalsIgnoreCase("name")) {
						messagesManager.setDisplayName(null, this);
						println("Nom retiré.");
					}
					else if (command.toLowerCase().startsWith("alias ")) {
						String[] args = command.substring(6).split(" ", 2);
						messagesManager.setHostnameAlias(args[0], args[1], this);
						println("Alias '"+args[1]+"' défini pour '"+args[0]+"'.");
					}
					else if (command.toLowerCase().startsWith("clear")) {
						/* il s'agit d'un message surprise à l'attention des utilisateurs connectés.
						 * celui-ci contient des séquences ANSI équivalente au résultat de la
						 * combinaison de touche Ctrl + L dans un terminal.
						 * Le nom d'utilisateur est retiré avant l'envoi, puis rétabli après.
						 */
						String dispName = messagesManager.getDisplayName();
						messagesManager.setDisplayName(null, this);
						messagesManager.send(((command.length()>6)?command.substring(6):"")+getMegaClear(25));
						messagesManager.setDisplayName(dispName, this);
					}
					else if (command.equalsIgnoreCase("gui")) {
						if (launchedGUI != null && launchedGUI.hasDisposed()) {
							messagesManager.removeInterface(launchedGUI);
							launchedGUI = null;
						}
						
						if (launchedGUI == null) {
							println("Démarrage de l'interface graphique.");
							launchedGUI = new GraphicalInterface(messagesManager);
							messagesManager.addInterface(launchedGUI);
						}
						else {
							println("Arrêt de l'interface graphique.");
							messagesManager.removeInterface(launchedGUI);
							launchedGUI.dispose();
							launchedGUI = null;
						}
					}
					else {
						println("Aides pour les commandes");
						println(""+ANSI_BOLD+"/quit"+ANSI_RESET+" pour quitter.");
						println(""+ANSI_BOLD+"/name <Nom>"+ANSI_RESET+" pour vous donner un nom (qui sera visible pour tout le monde).");
						println(""+ANSI_BOLD+"/name"+ANSI_RESET+" sans paramètre pour retirer ce nom.");
						println(""+ANSI_BOLD+"/alias <HostName> <UserName>"+ANSI_RESET+" pour définir le nom d'une personne pour un nom de machine donné.");
						println(""+ANSI_BOLD+"/gui"+ANSI_RESET+" lance ou arrête l'interface graphique.");
					}
				}
				else {
					messagesManager.send(line);
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
	public void onReceiveMessage(ReadOnlyMessage m) {
		
		
		
		String disp = ANSI_BLUE + DATE_FORMAT.format(new Date()) + ANSI_RESET + " ";
		if (!m.isRemote()) {
			disp += ANSI_YELLOW
					+ "Cet ordi" + ANSI_RESET;
		}
		else {
			String host = m.getRemoteHostName();
			boolean hostReplaced = false;
			if (messagesManager.getHostnameAlias(host) != null) {
				host = messagesManager.getHostnameAlias(host);
				hostReplaced = true;
			}
			
			disp += (hostReplaced ? ANSI_GREEN : ANSI_DARK_GREEN)
					+ host + ANSI_RESET;
		}
		
		disp += ANSI_GOLD
				+ "> "
				+ ANSI_RESET
				+ m.getMessage().replace(ANSI_CLEAR_SCREEN, "")
				+ ANSI_RESET;
		
		
		
		println(disp);
		
		
	}

	@Override
	public void onMessagesHistoryUpdate(List<ReadOnlyMessage> messagesHistory) { }
	@Override
	public void onDisplayNameChange(String newName) { }
	@Override
	public void onAliasesChange(Map<String, String> newAliases) { }
	
	
	
	
	
	
	
	
	
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
