package fr.univ_lille1.fil.rsx.multicast.interfaces.gui;

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;

import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;

import fr.univ_lille1.fil.rsx.multicast.interfaces.UserInterface;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager;
import fr.univ_lille1.fil.rsx.multicast.network.MessagesManager.ReadOnlyMessage;
import javax.swing.JTabbedPane;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.ScrollPaneConstants;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class GraphicalInterface extends JFrame implements UserInterface {
	private static final long serialVersionUID = 1L;
	
	
	
	private JPanel contentPane;
	
	private AtomicBoolean hasDisposed = new AtomicBoolean(false);
	
	
	
	private JTextField messageField;
	private JEditorPane chatContent;
	private JTextField nameField;
	private JTable aliasesTable;
	JScrollPane chatScrollPane;
	
	
	private MessagesManager messagesManager;
	
	private AtomicReference<List<ReadOnlyMessage>> messagesHistoryCache = new AtomicReference<List<ReadOnlyMessage>>(new ArrayList<ReadOnlyMessage>());

	

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
		
		chatScrollPane = new JScrollPane();
		chatScrollPane.setViewportBorder(null);
		chatScrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		chatScrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		chatSubPanel.add(chatScrollPane);
		
		chatContent = new JEditorPane();
		chatContent.setContentType("text/html");
		chatContent.setEditable(false);
		chatContent.setText("<html><b>En attente d'un premier message ...</b></html>");
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
		messageField.addActionListener(new ActionListener() {
			@Override public synchronized void actionPerformed(ActionEvent e) {
				sendMessage();
			}
		});
		
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
		nameField.addActionListener(new ActionListener() {
			@Override public synchronized void actionPerformed(ActionEvent e) {
				changeName();
			}
		});
		
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
						{"(vide)", null},
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
		aliasesTable.getModel().addTableModelListener(new TableModelListener() {
			@Override public void tableChanged(TableModelEvent e) {
				if (e.getColumn() != 1)
					return;
				if (e.getFirstRow() != e.getLastRow() || e.getFirstRow() < 0)
					return; // modif via la mise à jour depuis le gesionnaire de message
				
				String hostname = (String)aliasesTable.getValueAt(e.getFirstRow(), 0);
				
				if (hostname.equals("(vide)"))
					return;
				
				String alias = (String)aliasesTable.getValueAt(e.getFirstRow(), 1);
				
				messagesManager.setHostnameAlias(hostname, alias, GraphicalInterface.this);
			}
		});
		
		aliasesTable.getColumnModel().getColumn(0).setPreferredWidth(150);
		aliasesTable.getColumnModel().getColumn(0).setMinWidth(100);
		aliasesTable.getColumnModel().getColumn(1).setPreferredWidth(300);
		aliasesScrollPane.setViewportView(aliasesTable);
		
		setVisible(true);
		
		new Thread(new Runnable() {
			@Override public void run() {
				List<ReadOnlyMessage> oldList = null;
				while(!hasDisposed()) {
					
					while(messagesHistoryCache.get() == oldList)
						try { Thread.sleep(100); } catch (InterruptedException e) { }
					
					
					List<ReadOnlyMessage> current = messagesHistoryCache.get();
					
					List<ReadOnlyMessage> safeCopy;
					synchronized (messagesManager.messagesHistoryLocker) {
						safeCopy = new ArrayList<ReadOnlyMessage>(current);
					}
					updateChatDisplay(safeCopy);
					
					oldList = current;
					
					
					try { Thread.sleep(Math.max(200,10*current.size())); } catch (InterruptedException e) { }
				}
			}
		}).start();
		
		
	}
	
	
	
	
	

	
	

	@Override
	public synchronized void dispose() {
		super.dispose();
		hasDisposed.set(true);
		notify();
	}
	
	public synchronized void waitForDispose() {
		try {
			wait();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	public synchronized boolean hasDisposed() { return hasDisposed.get(); }
	
	
	
	
	
	private synchronized void sendMessage() {
		messageField.setEnabled(false);
		String mess = messageField.getText();
		if (!mess.trim().equals(""))
			messagesManager.send(mess);
		messageField.setText("");
		messageField.setEnabled(true);
		messageField.requestFocusInWindow();
	}
	
	
	private synchronized void changeName() {
		nameField.setEnabled(false);
		String name = nameField.getText();
		if (name.trim().equals(""))
			name = null;
		messagesManager.setDisplayName(name, this);
		JOptionPane.showMessageDialog(this, (name == null)?"Le nom a été retiré":"Le nom a été défini en '"+name+"'", "Changement de nom", JOptionPane.INFORMATION_MESSAGE);
		nameField.setEnabled(true);
		nameField.requestFocusInWindow();
	}
	
	
	
	private void updateChatDisplay(List<ReadOnlyMessage> current) {
		String htmlOutput = "<html>";
		
		for (ReadOnlyMessage m : current) {
			
			String disp = "<span style='color: blue; font-weight: bold;'>" + DATE_FORMAT.format(m.getDate()) + "</span> ";
			if (!m.isRemote()) {
				disp += "<span style='color: orange;'>Cet ordi</span>";
			}
			else {
				String host = m.getRemoteHostName();
				boolean hostReplaced = false;
				if (messagesManager.getHostnameAlias(host) != null) {
					host = messagesManager.getHostnameAlias(host);
					hostReplaced = true;
				}
				if (hostReplaced)
					disp += "<span style='color: green; font-weight: bold;'>"+host+"</span>";
				else
					disp += "<span style='color: green;'>"+host+"</span>";
				
			}
			
			disp += "<span style='color: orange; font-weight: bold;'>&gt;</span> "
					+ m.getMessage().replaceAll("[\\x00-\\x1F\\x7F]", "?").replace("<", "&lt;").replace(">", "&gt;");
			
			if (m.getCount() > 1) {
				disp += " <span style='background-color: red; color: black;'>&times; "+m.getCount()+"</span>";
			}
			
			
			
			htmlOutput += disp + "<br/>";
			
		}
		
		htmlOutput += "</html>";
		
		EventQueue.invokeLater(new Runnable() {
			String s;
			public Runnable init(String S) { s = S; return this; }
			
			@Override
			public void run() {
				chatContent.setText(s);
				chatContent.setCaretPosition(chatContent.getDocument().getLength());
			}
		}.init(htmlOutput));
		
	}
	
	
	
	
	
	
	
	
	
	
	
	@Override
	public void onReceiveMessage(ReadOnlyMessage m) { }

	@Override
	public void onMessagesHistoryUpdate(List<ReadOnlyMessage> messagesHistory) {
		messagesHistoryCache.set(messagesHistory);
	}
	
	@Override
	public void onDisplayNameChange(String newName) {
		nameField.setText(newName);
	}
	
	@Override
	public void onAliasesChange(Map<String, String> newAliases) {
		DefaultTableModel model = (DefaultTableModel) aliasesTable.getModel();
		
		String[] headers = new String[] {"Nom d'hôte", "Alias attribué"};
		
		String[][] content = new String[newAliases.size()][2];
		
		int i=0;
		for(String key : newAliases.keySet()) {
			String value = newAliases.get(key);
			content[i][0] = key;
			content[i][1] = value;
			i++;
		}
		
		model.setDataVector(content, headers);
		
		model.fireTableDataChanged();
		
	}
	
	
	
}
