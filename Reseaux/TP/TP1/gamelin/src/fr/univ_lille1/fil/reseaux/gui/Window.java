package fr.univ_lille1.fil.reseaux.gui;

import java.awt.Point;
import java.awt.TextArea;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.ScrollPaneConstants;

import com.jgoodies.forms.layout.ColumnSpec;
import com.jgoodies.forms.layout.FormLayout;
import com.jgoodies.forms.layout.FormSpecs;
import com.jgoodies.forms.layout.RowSpec;

import fr.univ_lille1.fil.reseaux.Application;

@SuppressWarnings("serial")
public class Window extends JFrame {
	
	protected Application app;

	protected JPanel contentPane;
	protected JTextArea textArea;
	protected JScrollPane scrollPane;
	private TextArea message;


	/**
	 * Create the frame.
	 */
	public Window(Application app) {
		this.app = app;
		
		addWindowListener(new WindowAdapter() {
			@Override
			public void windowClosing(WindowEvent arg0) {
				app.getReceiver().leaveGroupe();
				app.getSender().leaveGroupe();
			}
		});
		
		setTitle("Chat");
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 610, 683);
		contentPane = new JPanel();
		setContentPane(contentPane);
		
		scrollPane = new JScrollPane();
		scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
		
		textArea = new JTextArea();
		textArea.setEditable(false);
		textArea.setText("Welcome");
		textArea.setTabSize(4);
		
		scrollPane.setViewportView(textArea);
		
		message = new TextArea();
		message.addKeyListener(this.app);
		contentPane.setLayout(new FormLayout(new ColumnSpec[] {
				FormSpecs.RELATED_GAP_COLSPEC,
				ColumnSpec.decode("max(577px;min):grow"),},
			new RowSpec[] {
				FormSpecs.RELATED_GAP_ROWSPEC,
				RowSpec.decode("fill:max(554px;default):grow(11)"),
				FormSpecs.UNRELATED_GAP_ROWSPEC,
				RowSpec.decode("fill:59px"),
				FormSpecs.RELATED_GAP_ROWSPEC,
				FormSpecs.DEFAULT_ROWSPEC,}));
		contentPane.add(message, "2, 4, fill, fill");
		contentPane.add(scrollPane, "2, 2, fill, fill");
		
		setVisible(true);
	}

	public void seText(String msg){
		textArea.setText(textArea.getText() + "\n" + msg);
		message.setText("");
		//scrollPane.getViewport().setViewPosition(new Point(0,textArea.getDocument().getLength()));
	}
	
	public TextArea getMessage(){
		return message;
	}
}
