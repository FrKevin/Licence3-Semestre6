import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.*;


/*
* envoi/reception rapide d'un packet DNS
*/
public class DNSsimple {

  public static void main(String[] args) {
    byte[] message = {
      (byte) 0x08, (byte) 0xbb,  (byte) 0x01, (byte) 0x00,/* a) 12 octets d'entete : identifiant de requete/parametres */
      (byte) 0x00, (byte) 0x01,  (byte) 0x00, (byte) 0x00,
      (byte) 0x00, (byte) 0x00,  (byte) 0x00, (byte) 0x00,
      (byte) 0x03, (byte) 0x77,  (byte) 0x77, (byte) 0x77,/* b) question : "3www4lifl2fr" */
      (byte) 0x04, (byte) 0x6c,  (byte) 0x69, (byte) 0x66,
      (byte) 0x6c, (byte) 0x02,  (byte) 0x66, (byte) 0x72,
      (byte) 0x00,                                        /* c) */
      (byte) 0x00, (byte) 0x01,
      (byte) 0x00, (byte) 0x01
    };

    /* 1) InetAddress */
    System.err.print(" get inetaddress by name ... ");
    InetAddress destination;
    try {
      destination = InetAddress.getByName("193.49.225.15"/* ou 8.8.8.8 ou celui dans /etc/resolv.conf ... */);
    } catch (Exception e) {
      System.err.println("[error] :" +  e.getMessage());
      return;
    }
    System.err.println("[ok]");

    /* 2) creation d'un DatagramPacket pour la reception */
    System.err.println(" preparing  datagrampacket, message size : "+message.length  );
    DatagramPacket dp = new DatagramPacket(message,message.length,destination,53);

    /* 3) creation d'un DatragramSocket sur l'adresse locale */
    System.err.print(" create datagram socket  ... ");
    DatagramSocket ds ;
    try {
      ds = new DatagramSocket() ;
    } catch (Exception e) {
      System.err.println("[error] :" +  e.getMessage());
      return;
    }
    System.err.println("[ok]");

    /* 4) et envoi du packet */
    System.err.print(" send datagram ... ");
    try {
      ds.send(dp);
    } catch (Exception e) {
      System.err.println("[error] :" +  e.getMessage());
      return;
    }
    System.err.println("[ok]");

    /* 5) reception du packet */
    dp = new DatagramPacket(new byte[512],512);
    System.err.print(" receive datagram ... ");
    try {
      ds.receive(dp);
    } catch (Exception e) {
      System.err.println("[error] :" +  e.getMessage());
      return;
    }
    System.err.println("[ok]");

    /* affichage complet du packet recu */
    byte[] rec = dp.getData();
    System.out.println("- message length : " + dp.getLength());
    System.out.println("- message : \n" + new String(rec, 0, dp.getLength(), StandardCharsets.UTF_8));

    /* affichage des bytes */
    for(int i=0;i<dp.getLength();i++){
      System.out.print(","+Integer.toHexString((rec[i])&0xff));
      if ((i+1)%16 == 0)
    	  System.out.println("");
    }
    System.out.println("");
    /* affichage complet */

  }

}
