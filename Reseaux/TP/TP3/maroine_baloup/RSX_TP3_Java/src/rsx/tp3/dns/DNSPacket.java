package rsx.tp3.dns;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import java.util.function.Function;

import rsx.tp3.BitArray;
import rsx.tp3.Main;

/**
 * Implémentation du protocole DNS basé sur la RFC1035.
 * 
 */
public class DNSPacket {
	
	private static final Random rnd = new Random();
	
	
	/**
	 * Construit un packet DNS déjà prêt pour la résolution d'un nom de domaine.
	 * @param hostName
	 * @return
	 */
	public static DNSPacket createSimpleQuery(String hostName) {
		DNSPacket packet = new DNSPacket();
		packet.addQuery(new Query(hostName, QType.A, DNSClass.IN));
		return packet;
	}
	
	
	
	
	
	
	
	
	/**
	 * Récupère l'adresse IP correspondant au nom de domaine passé en paramètre
	 * 
	 * @param hostName le nom de domaine à chercher
	 * @param dnsHost l'adresse du serveur DNS
	 * @return l'adresse IP récupérée, ou null si le serveur DNS n'a pas retourné d'adresse IP.
	 * @throws Exception si une erreur réseau ou de décodage survient.
	 */
	public static InetAddress getAddressFromHostName(String hostName, String dnsHost, boolean display) throws Exception {
		DNSPacket query = DNSPacket.createSimpleQuery(hostName);
		if (display)
			query.displayData();
		
		DatagramSocket socket = new DatagramSocket();
		query.send(socket, InetAddress.getByName(dnsHost), 53);
		
		DNSPacket response = query.waitForDNSResponse(socket);
		
		if (display) {
			System.out.println("\n\n\n\n");
			response.displayData();
		}
		
		for (ResourceRecord rr : response.answersRR) {
			if (rr.getDecodedData() instanceof InetAddress)
				return (InetAddress) rr.getDecodedData();
		}
		
		return null;
		
	}
	
	
	
	
	
	
	/* **********************************************
	 *                 Constructeurs
	 * **********************************************
	 */

	/**
	 * Construit un packet DNS de requête. Utilisez les accesseurs pour le compléter avant envoi.
	 */
	public DNSPacket() {
		rnd.nextBytes(transactionId);
		setPacketType(PacketType.QUERY);
		setOpCode(OpCode.QUERY);
		setTruncated(false);
		setRecursionDesired(true);
	}
	
	/**
	 * Construit un packet DNS en se basant sur les données d'un datagramme DNS
	 * @param initialData les données d'un packet DNS à partir duquel l'instance est construite
	 */
	public DNSPacket(byte[] initialData) {
		ByteBuffer buffer = ByteBuffer.wrap(initialData);
		
		buffer.get(transactionId);
		
		BitArray flags1 = new BitArray(buffer.get());
		BitArray flags2 = new BitArray(buffer.get());
		
		// n'utilise pas les setteurs car certains peuvent lancer des exception
		// alors que ici ça n'est pas ce qu'on veut
		
		packetType = PacketType.getFromBoolean(flags1.bits[0]);
		opCode = OpCode.getFromValue(new BitArray(false, false, false, false,
				flags1.bits[1], flags1.bits[2], flags1.bits[3], flags1.bits[4]).toByte());
		authoritative = flags1.bits[5];
		truncated = flags1.bits[6];
		recursionDesired = flags1.bits[7];
		
		recursionAvailable = flags2.bits[0];
		responseCode = ResponseCode.getFromValue(new BitArray(false, false, false, false,
				flags2.bits[4], flags2.bits[5], flags2.bits[6], flags2.bits[7]).toByte());
		
		int nbQueries = buffer.getShort() & 0xffff; // 1
		int nbAnswersRR = buffer.getShort() & 0xffff; // 2
		int nbAuthorityRR = buffer.getShort() & 0xffff; // 0
		int nbAdditionalRR = buffer.getShort() & 0xffff; // 0
		
		
		
		for (int i = 0; i<nbQueries; i++) {
			Query q = new Query();
			q.qName = readLabelSequenceFromDNSPacket(buffer);
			q.qType = QType.getFromValue(buffer.getShort() & 0xffff);
			q.qClass = DNSClass.getFromValue(buffer.getShort() & 0xffff);
			queries.add(q);
		}

		// c0 30 00 01 00 01 00 00 41 f8 00 04 c1 31 e1 ae  
		
		// cette fonction sera appelé peu importe le type de ResourceRecord
		Function<ByteBuffer, ResourceRecord> resourceRecordDecoding = (buff) -> {
			ResourceRecord rr = new ResourceRecord();
			rr.rName = readLabelSequenceFromDNSPacket(buff);
			rr.rType = QType.getFromValue(buff.getShort() & 0xffff);
			rr.rClass = DNSClass.getFromValue(buff.getShort() & 0xffff);
			rr.ttl = ((long)buff.getInt()) & 0xffffffffL;
			
			int dataSize = buff.getShort() & 0xffff;
			int posToSave = buff.position();
			
			try {
				rr.decodedData = rr.rType.decoder.decode(buff, dataSize);
			} catch (Exception e) {
				new RuntimeException("Erreur lors du décodage des données d'un ResourceRecord", e).printStackTrace();
			}
			
			buff.position(posToSave);
			
			rr.rData = new byte[dataSize];
			buff.get(rr.rData);
			if (rr.decodedData == null)
				rr.decodedData = rr.rData;
			return rr;
		};
		// grace à l'interface Function, on évite de recopier 3 fois le
		// contenu dans les 3 boucles 'for' ci-dessous
		for (int i = 0; i<nbAnswersRR; i++)
			answersRR.add(resourceRecordDecoding.apply(buffer));
		for (int i = 0; i<nbAuthorityRR; i++)
			authorityRR.add(resourceRecordDecoding.apply(buffer));
		for (int i = 0; i<nbAdditionalRR; i++)
			additionalRR.add(resourceRecordDecoding.apply(buffer));
		
		
		
		
	}
	
	
	
	
	

	/* **********************************************
	 *        Données d'un packet DNS (rfc1035)
	 * **********************************************
	 */
	private byte[] transactionId = new byte[2];
	private PacketType packetType;
	private OpCode opCode;
	private boolean authoritative = false; // pour les réponses seulement
	private boolean truncated;
	private boolean recursionDesired;
	private boolean recursionAvailable = false; // pour les réponses, seulement
	private ResponseCode responseCode = ResponseCode.UNDEFINED; /* réponses seulement */
	private List<Query> queries = new ArrayList<>();
	private List<ResourceRecord> answersRR = new ArrayList<>();
	private List<ResourceRecord> authorityRR = new ArrayList<>();
	private List<ResourceRecord> additionalRR = new ArrayList<>();
	
	
	
	// les getteurs
	public byte[] getTransactionId() { return Arrays.copyOf(transactionId, 2); }
	public PacketType getPacketType() { return packetType; }
	public OpCode getOpCode() { return opCode; }
	public boolean isAuthoritative() { return authoritative; }
	public boolean isTruncated() { return truncated; }
	public boolean isRecursionDesired() { return recursionDesired; }
	public boolean isRecursionAvailable() { return recursionAvailable; }
	public ResponseCode getResponseCode() { return responseCode; }
	public List<Query> getQueries() { return Collections.unmodifiableList(queries); }
	public List<ResourceRecord> getAnswersResponse() { return Collections.unmodifiableList(answersRR); }
	public List<ResourceRecord> getAuthorityResponse() { return Collections.unmodifiableList(authorityRR); }
	public List<ResourceRecord> getAdditionalResponse() { return Collections.unmodifiableList(additionalRR); }
	
	// les setteurs
	public void setTransactionId(byte b1, byte b2) { transactionId = new byte[] {b1, b2}; }
	public void setPacketType(PacketType pt) {
		if (pt == null) throw new IllegalArgumentException("packetType ne peut être null");
		packetType = pt;
	}
	public void setOpCode(OpCode oc) {
		if (oc == null) throw new IllegalArgumentException("opCode ne peut être null");
		if (oc == OpCode.UNDEFINED) throw new IllegalArgumentException("opCode ne peut être UNDEFINED");
		opCode = oc;
	}
	public void setAuthoritative(boolean a) {
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir définir ce flag");
		authoritative = a;
	}
	public void setTruncated(boolean t) { truncated = t; }
	public void setRecursionDesired(boolean r) { recursionDesired = r; }
	public void setRecursionAvailable(boolean r) {
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir définir ce flag");
		recursionAvailable = r;
	}
	public void setResponseCode(ResponseCode c) {
		if (c == null) throw new IllegalArgumentException("ResponseCode ne peut être null");
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir définir ce flag");
		if (c == ResponseCode.UNDEFINED) throw new IllegalArgumentException("ResponseCode ne peut être UNDEFINED");
	}
	public void addQuery(Query q) {
		if (q == null) throw new IllegalArgumentException("Query ne peut être null");
		queries.add(q);
	}
	public void addAnswerResponse(ResourceRecord rr) {
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir ajouter des ResourceRecord");
		if (rr == null) throw new IllegalArgumentException("ResourceRecord ne peut être null");
		answersRR.add(rr);
	}
	public void addAuthorityResponse(ResourceRecord rr) {
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir ajouter des ResourceRecord");
		if (rr == null) throw new IllegalArgumentException("ResourceRecord ne peut être null");
		authorityRR.add(rr);
	}
	public void addAdditionalResponse(ResourceRecord rr) {
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir ajouter des ResourceRecord");
		if (rr == null) throw new IllegalArgumentException("ResourceRecord ne peut être null");
		additionalRR.add(rr);
	}
	
	
	
	/*
	 * 
	 */
	public byte[] toByte() {
		ByteBuffer buffer = ByteBuffer.allocate(16384);
		
		// transaction Id : 2 octets
		buffer.put(getTransactionId());
		
		// flags : 2 octets
		BitArray opCode = new BitArray(getOpCode().fourBitsValue);
		BitArray flags1 = new BitArray(
				getPacketType().bitValue,
				opCode.bits[4],
				opCode.bits[5],
				opCode.bits[6],
				opCode.bits[7],
				isAuthoritative(),
				isTruncated(),
				isRecursionDesired());
		buffer.put(flags1.toByte());
		BitArray rCode = new BitArray(getResponseCode().fourBitsValue);
		BitArray flags2 = new BitArray(
				isRecursionAvailable(),
				false,
				false,
				false,
				rCode.bits[4],
				rCode.bits[5],
				rCode.bits[6],
				rCode.bits[7]);
		buffer.put(flags2.toByte());
		
		// nombre de question (2 octets)
		buffer.putShort((short)(queries.size() & 0xffff));
		// nombre de resource record qui répond aux questions (2 octets)
		buffer.putShort((short)(answersRR.size() & 0xffff));
		// nombre de resource record d'authorité (2 octets)
		buffer.putShort((short)(authorityRR.size() & 0xffff));
		// nombre de resource record additionels (2 octets)
		buffer.putShort((short)(additionalRR.size() & 0xffff));
		
		// les questions
		for (Query query : queries) {
			buffer.put(convertDomainNameToLabelSequence(query.getName()));
			buffer.putShort((short)(query.getType().value & 0xffff));
			buffer.putShort((short)(query.getDNSClass().value & 0xffff));
		}
		
		if (getPacketType() == PacketType.RESPONSE) {
			// toutes les resource record sont au même format, donc elles sont parcouru par la même boucle
			List<ResourceRecord> rrs = new ArrayList<>();
			rrs.addAll(answersRR);
			rrs.addAll(authorityRR);
			rrs.addAll(additionalRR);
			
			// les resource record (seulement en cas de PacketType.RESPONSE)
			for (ResourceRecord rr : rrs) {
				buffer.put(convertDomainNameToLabelSequence(rr.getName()));
				buffer.putShort((short)(rr.getType().value & 0xffff));
				buffer.putShort((short)(rr.getDNSClass().value & 0xffff));
				buffer.putInt((int)(rr.getTTL() & 0xffffffff));
				byte[] rData = rr.getData();
				buffer.putShort((short)(rData.length & 0xffff));
				buffer.put(rData);
			}
		}
		
		return Arrays.copyOf(buffer.array(), buffer.position());
		
	}
	
	
	
	public void displayData() {
		System.out.println("DNS packet details :");
		System.out.println(" Transaction Id : "+Main.bytesToHexaString(transactionId));
		System.out.println(" PacketType : "+packetType);
		System.out.println(" OpCode : "+opCode);
		if (packetType == PacketType.RESPONSE)
			System.out.println(" Is authoritative : "+authoritative);
		System.out.println(" Is truncated : "+truncated);
		System.out.println(" Is recursion desired : "+recursionDesired);
		if (packetType == PacketType.RESPONSE)
			System.out.println(" Is recursion available : "+recursionAvailable);
		if (packetType == PacketType.RESPONSE)
			System.out.println(" Response code : "+responseCode);
		
		System.out.println(" Nb of query : "+queries.size());
		if (packetType == PacketType.RESPONSE) {
			System.out.println(" Nb of answers resource record : "+answersRR.size());
			System.out.println(" Nb of authority resource record : "+authorityRR.size());
			System.out.println(" Nb of additional resource record : "+additionalRR.size());
		}
		
		int i = 1;
		// les questions
		for (Query query : queries) {
			System.out.println("  Query "+(i++)+" :");
			System.out.println("     Name : "+query.qName);
			System.out.println("     Type : "+query.qType);
			System.out.println("     Class : "+query.qClass);
		}
		

		if (packetType == PacketType.RESPONSE) {
			i = 1;
			
			List<ResourceRecord> rrs = new ArrayList<>();
			rrs.addAll(answersRR);
			rrs.addAll(authorityRR);
			rrs.addAll(additionalRR);
			
			// les resource record (seulement en cas de PacketType.RESPONSE)
			for (ResourceRecord rr : rrs) {
				System.out.println("  Resource record "+(i++));
				System.out.println("     Name : "+rr.rName);
				System.out.println("     Type : "+rr.rType);
				System.out.println("     Class : "+rr.rClass);
				System.out.println("     TTL (sec) : "+rr.ttl);
				System.out.println("     Data length : "+rr.rData.length);
				System.out.println("     Raw Data : "+Main.bytesToHexaString(rr.rData));
				if (!byte[].class.equals(rr.decodedData.getClass()))
					System.out.println("     Decoded data : "+rr.decodedData);
			}
		}
	}
	
	
	
	
	
	
	public void send(DatagramSocket socket, InetAddress addr, int port) throws IOException {
		byte[] buff = toByte();
		socket.send(new DatagramPacket(buff, buff.length, addr, port));
	}
	

	/**
	 * Attends sur la socket passé en paramètre, une réponse du serveur DNS précédemment contacté avec le packet spécifié
	 * @throws Exception
	 */
	public DNSPacket waitForDNSResponse(DatagramSocket socket) throws Exception {
		DatagramPacket p = new DatagramPacket(new byte[2048], 2048);
		socket.receive(p);
		byte[] packetData = Arrays.copyOfRange(p.getData(), 0, p.getLength());
		
		DNSPacket response = new DNSPacket(packetData);
		if (!Arrays.equals(response.getTransactionId(), getTransactionId()))
			throw new BadDNSResponseException("transactionId du packet reçu est différent du packet envoyé");
		
		return response;
	}
	
	
	
	
	
	
	
	public class BadDNSResponseException extends Exception {
		private static final long serialVersionUID = 1L;
		private BadDNSResponseException(String message) {
			super("La réponse DNS reçu n'est pas valide : "+message);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	public static byte[] convertDomainNameToLabelSequence(String domainName) {
		if (domainName == null) throw new IllegalArgumentException("domainName ne peut être null");
		String[] labels = domainName.split("\\.");
		ByteBuffer bb = ByteBuffer.allocate(512);
		for (String label : labels) {
			byte[] chars = label.getBytes();
			if (chars.length == 0) continue;
			if (chars.length > 63) throw new IllegalArgumentException("un des label de domainName est trop grand (> 63 octet)");
			bb.put((byte)(chars.length & 0x3f));
			for (byte c : chars)
				bb.put(c);
		}
		bb.put((byte)0);
		
		return Arrays.copyOf(bb.array(), bb.position());
	}
	
	
	
	
	/**
	 * Lis une séquence de domaine depuis le buffer passé en paramètre.
	 * Prend en charge la compression par pointeur.<br/>
	 * À la fin de l'exécution de cette méthode, le buffer pointe sur l'octet
	 * qui suit la fin de la séquence de domaine duquel est parti l'analyse.
	 * @param buffer
	 * @return
	 */
	public static String readLabelSequenceFromDNSPacket(ByteBuffer buffer) {
		String ret = "";
		int finalPosition = 0; // là où se positionnera le pointeur du buffer à la fin de cette méthode.
		
		do {
			byte initLabel = buffer.get();
			if ((initLabel & 0xff) >= 0xc0) {
				// il s'agit d'un pointeur
				byte p0 = (byte)(initLabel & 0x3f);
				int nextPosition = (p0 << 8) | buffer.get();
				if (finalPosition == 0) finalPosition = buffer.position();
				buffer.position(nextPosition);
				continue;
			}
			else if(initLabel == 0) {
				break; // octet nul = fin du nom de domaine
			}
			else {
				// capture du label
				byte[] labelBytes = new byte[initLabel & 0xff];
				for (int i = 0; i<initLabel; i++)
					labelBytes[i] = buffer.get();
				ret += new String(labelBytes) + ".";
			}
		} while(true);
		
		if (finalPosition != 0)
			buffer.position(finalPosition);
		
		return ret.substring(0, Math.max(ret.length()-1, 0));
	}
	
	
	
	
	public static String readCharacterStringFromDNSPacket(ByteBuffer buffer) {
		byte[] bytes = new byte[buffer.get() & 0xff];
		buffer.get(bytes);
		return new String(bytes);
	}
	
	
	
	
}
