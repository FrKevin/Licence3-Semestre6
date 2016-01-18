package fr.univ_lille1.fil.reseaux;

import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

public class Main {

	public static void main(String[] args) {
		   try {
               UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
           } catch (ClassNotFoundException ex) {
           } catch (InstantiationException ex) {
           } catch (IllegalAccessException ex) {
           } catch (UnsupportedLookAndFeelException ex) {
           }
		Application app = new Application("224.0.0.1", 7654);
	}

}
