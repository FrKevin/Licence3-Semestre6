package fr.univ_lille1.fil.rsx.multicast.interfaces;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager.ReadOnlyMessage;

public interface UserInterface {
	
	
	public static final DateFormat DATE_FORMAT = new SimpleDateFormat("HH:mm:ss");
	
	/**
	 * Appelé lorsque un message individuel a été reçu depuis le réseau
	 * @param m
	 */
	public void onReceiveMessage(ReadOnlyMessage m);
	
	/**
	 * Appelé après qu'un message reçu depuis le réseau a convenablement été ajouté dans l'historique des messages
	 * @param messagesHistory
	 */
	public void onMessagesHistoryUpdate(List<ReadOnlyMessage> messagesHistory);

	/**
	 * Appelé lorsque l'utilisateur change son nom d'affiche (permet que toutes les interfaces soient mise à jours).
	 * Lorsque la méthode {@link MessagesManager#setDisplayName(String, UserInterface)} est appelée,
	 * le deuxième paramètre précise l'interface utilisateur qui ne recevra pas la notification de changement de
	 * nom d'affichage (en général, il s'agit de l'interface qui a effectué la modification)
	 * @param newName
	 */
	public void onDisplayNameChange(String newName);
	
	/**
	 * Appelé lorsque l'utilisateur change un alias de nom d'hôte (permet que toutes les interfaces soient mise à jours).
	 * Lorsque la méthode {@link MessagesManager#setHostnameAlias(String, String, UserInterface)} est appelée,
	 * le troisième paramètre précise l'interface utilisateur qui ne recevra pas la notification de changement
	 * d'alias (en général, il s'agit de l'interface qui a effectué la modification)
	 * @param newName
	 */
	public void onAliasesChange(Map<String, String> newAliases);

}
