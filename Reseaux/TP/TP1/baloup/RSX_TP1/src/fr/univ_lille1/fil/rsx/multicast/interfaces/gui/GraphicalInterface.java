package fr.univ_lille1.fil.rsx.multicast.interfaces.gui;

import java.awt.BorderLayout;
import java.util.List;
import java.util.Map;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import fr.univ_lille1.fil.rsx.multicast.interfaces.UserInterface;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager.ReadOnlyMessage;
import javax.swing.JTabbedPane;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.SwingConstants;
import javax.swing.UIManager;
import javax.swing.ScrollPaneConstants;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class GraphicalInterface extends JFrame implements UserInterface {
	private static final long serialVersionUID = 1L;
	
	
	
	private JPanel contentPane;
	
	
	
	private JTextField messageField;
	private JLabel chatContent;
	private JTextField nameField;
	private JTable aliasesTable;
	
	
	private MessagesManager messagesManager;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			// donne à l'interface graphique le thème associé au système d'exploitation
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (Exception e) { }
		GraphicalInterface frame = new GraphicalInterface(null);
		frame.setVisible(true);
		frame.waitForDispose();
	}

	/**
	 * Create the frame.
	 */
	public GraphicalInterface(MessagesManager m) {
		messagesManager = m;
		
		setTitle("Multicast Chat");
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setBounds(100, 100, 640, 360);
		contentPane = new JPanel();
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		contentPane.add(tabbedPane, BorderLayout.CENTER);
		
		JPanel chatPanel = new JPanel();
		tabbedPane.addTab("Chat", null, chatPanel, null);
		chatPanel.setLayout(new BorderLayout(0, 0));
		
		JPanel chatSubPanel = new JPanel();
		chatPanel.add(chatSubPanel, BorderLayout.CENTER);
		chatSubPanel.setBorder(new EmptyBorder(2, 2, 2, 2));
		chatSubPanel.setLayout(new BorderLayout(0, 0));
		
		JScrollPane chatScrollPane = new JScrollPane();
		chatScrollPane.setViewportBorder(null);
		chatScrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		chatScrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		chatSubPanel.add(chatScrollPane);
		
		chatContent = new JLabel("<html><b>Ferme-moi cette fenêtre !</b><br/>L'interface graphique n'est pas fonctionnelle.</html>");
		chatContent.setHorizontalAlignment(SwingConstants.LEFT);
		chatContent.setVerticalAlignment(SwingConstants.TOP);
		chatScrollPane.setViewportView(chatContent);
		
		JPanel messagePanel = new JPanel();
		messagePanel.setBorder(new EmptyBorder(2, 2, 2, 2));
		chatPanel.add(messagePanel, BorderLayout.SOUTH);
		messagePanel.setLayout(new BorderLayout(0, 0));
		
		JLabel messageLabel = new JLabel("Message : ");
		messagePanel.add(messageLabel, BorderLayout.WEST);
		
		messageField = new JTextField();
		messagePanel.add(messageField, BorderLayout.CENTER);
		messageField.setColumns(10);
		
		JPanel configPanel = new JPanel();
		tabbedPane.addTab("Configuration", null, configPanel, null);
		configPanel.setLayout(new BorderLayout(0, 0));
		
		JPanel namePanel = new JPanel();
		namePanel.setBorder(new EmptyBorder(2, 2, 2, 2));
		configPanel.add(namePanel, BorderLayout.NORTH);
		namePanel.setLayout(new BorderLayout(0, 0));
		
		JLabel nameLabel = new JLabel("Nom d'affichage : ");
		namePanel.add(nameLabel, BorderLayout.WEST);
		
		nameField = new JTextField();
		namePanel.add(nameField, BorderLayout.CENTER);
		nameField.setColumns(10);
		
		JPanel aliasesPanel = new JPanel();
		aliasesPanel.setBorder(new EmptyBorder(2, 2, 2, 2));
		configPanel.add(aliasesPanel, BorderLayout.CENTER);
		aliasesPanel.setLayout(new BorderLayout(0, 0));
		
		JScrollPane aliasesScrollPane = new JScrollPane();
		aliasesScrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		aliasesScrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		aliasesPanel.add(aliasesScrollPane);
		
		aliasesTable = new JTable();
		aliasesTable.setModel(new DefaultTableModel(
					new Object[][] {
						{null, null},
					},
					new String[] {
						"Nom d'hôte", "Alias attribué"
					}) {
			private static final long serialVersionUID = 1L;
			Class<?>[] columnTypes = new Class[] {
				String.class, String.class
			};
			public Class<?> getColumnClass(int columnIndex) {
				return columnTypes[columnIndex];
			}
			boolean[] columnEditables = new boolean[] {
				false, true
			};
			public boolean isCellEditable(int row, int column) {
				return columnEditables[column];
			}
		});
		aliasesTable.getColumnModel().getColumn(0).setPreferredWidth(150);
		aliasesTable.getColumnModel().getColumn(0).setMinWidth(100);
		aliasesTable.getColumnModel().getColumn(1).setPreferredWidth(300);
		aliasesScrollPane.setViewportView(aliasesTable);
	}
	
	
	
	
	

	
	
	@Override
	public synchronized void dispose() {
		super.dispose();
		notify();
	}
	
	public synchronized void waitForDispose() {
		try {
			wait();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	
	
	
	@Override
	public void onReceiveMessage(ReadOnlyMessage m) { }

	@Override
	public void onMessagesHistoryUpdate(List<ReadOnlyMessage> messagesHistory) {
		// TODO
		
		/*
		 * Traitement de chaque message : message = message.replaceAll("[\\x00-\\x1F\\x7F]", "?");
		 */
	}
	
	@Override
	public void onDisplayNameChange(String newName) {
		nameField.setText(newName);
	}
	
	@Override
	public void onAliasesChange(Map<String, String> newAliases) {
		// TODO
	}
	
	
	

}
