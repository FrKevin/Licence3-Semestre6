package rsx.tp3;

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

public class DNSPacket {
	
	private static final Random rnd = new Random();
	
	
	/**
	 * Construit un packet DNS déjà prêt pour la résolution d'un nom de domaine.
	 * @param hostName
	 * @return
	 */
	public static DNSPacket createSimpleQuery(String hostName) {
		DNSPacket packet = new DNSPacket();
		packet.addQuestion(new Question(hostName, QType.A, DNSClass.IN));
		return packet;
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
		// TODO décoder les données
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
	private List<Question> questions = new ArrayList<>();
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
	public List<Question> getQuestions() { return Collections.unmodifiableList(questions); }
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
	public void setRecussionAvailable(boolean r) {
		if (packetType == PacketType.QUERY) throw new IllegalStateException("le packet doit être de type RESPONSE pour pouvoir définir ce flag");
		recursionAvailable = r;
	}
	public void addQuestion(Question q) {
		if (q == null) throw new IllegalArgumentException("Question ne peut être null");
		questions.add(q);
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
		buffer.putShort((short)(questions.size() & 0xffff));
		buffer.putShort((short)(answersRR.size() & 0xffff));
		buffer.putShort((short)(authorityRR.size() & 0xffff));
		buffer.putShort((short)(additionalRR.size() & 0xffff));

		for (Question question : questions) {
			buffer.put(convertDomainNameToLabelSequence(question.getName()));
			buffer.putShort((short)(question.getType().value & 0xffff));
			buffer.putShort((short)(question.getDNSClass().value & 0xffff));
		}
		
		List<ResourceRecord> rrs = new ArrayList<>();
		rrs.addAll(answersRR);
		rrs.addAll(authorityRR);
		rrs.addAll(additionalRR);
		
		for (ResourceRecord rr : rrs) {
			buffer.put(convertDomainNameToLabelSequence(rr.getName()));
			buffer.putShort((short)(rr.getType().value & 0xffff));
			buffer.putShort((short)(rr.getDNSClass().value & 0xffff));
			buffer.putShort((short)(rr.getTTL() & 0xffff));
			byte[] rData = rr.getData();
			buffer.putShort((short)(rData.length & 0xffff));
			buffer.put(rData);
		}
		
		return Arrays.copyOf(buffer.array(), buffer.position());
		
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static enum PacketType {
		QUERY(false),
		RESPONSE(true);
		
		private final boolean bitValue;
		
		private PacketType(boolean b) {
			bitValue = b;
		}
	}
	
	public static enum OpCode {
		QUERY((byte)0x0),
		IQUERY((byte)0x1),
		STATUS((byte)0x2),
		UNDEFINED(null);
		
		private final Byte fourBitsValue;
		
		private OpCode(Byte b) {
			fourBitsValue = b;
		}
	
	}
	
	public static enum ResponseCode {
		NO_ERROR((byte)0x0),
		FORMAT_ERROR((byte)0x1),
		SERVER_FAILURE((byte)0x2),
		NAME_ERROR((byte)0x3),
		NOT_IMPLEMENTED((byte)0x4),
		REFUSED((byte)0x5),
		UNDEFINED(null);
		
		private final Byte fourBitsValue;
		
		private ResponseCode(Byte b) {
			fourBitsValue = b;
		}
	}
	
	public static enum QType {
		A(1),
		NS(2),
		MD(3),
		MF(4),
		CNAME(5),
		SOA(6),
		MB(7),
		MG(8),
		MR(9),
		NULL(10),
		WSK(11),
		PTR(12),
		HINFO(13),
		MX(14),
		TXT(15),
		AXFR(252),
		MAILB(253),
		MAILA(254),
		ALL(255),
		UNDEFINED(null);
		
		private final Integer value;
		
		private QType(Integer v) {
			value = v;
		}
		
	}
	
	public static enum DNSClass {
		IN(1),
		CS(2),
		CH(3),
		HS(4),
		UNDEFINED(null);
		
		private final Integer value;
		
		private DNSClass(Integer v) {
			value = v;
		}
	}
	
	
	
	
	
	
	public static class Question {
		private String qName;
		private QType qType;
		private DNSClass qClass;
		
		public Question(String n, QType t, DNSClass c) {
			setName(n);
			setType(t);
			setDNSClass(c);
		}
		
		public String getName() { return qName; }
		public QType getType() { return qType; }
		public DNSClass getDNSClass() { return qClass; }
		
		public void setName(String n) {
			if (n == null || n.trim().isEmpty()) throw new IllegalArgumentException("name ne peut être null ou vide");
			qName = n;
		}
		
		public void setType(QType t) {
			if (t == null) throw new IllegalArgumentException("QType ne peut être null");
			if (t == QType.UNDEFINED) throw new IllegalArgumentException("QType ne peut être UNDEFINED");
			qType = t;
		}
		
		public void setDNSClass(DNSClass c) {
			if (c == null) throw new IllegalArgumentException("DNSClass ne peut être null");
			if (c == DNSClass.UNDEFINED) throw new IllegalArgumentException("DNSClass ne peut être UNDEFINED");
			qClass = c;
		}
	}
	
	
	
	
	
	public static class ResourceRecord {
		private String rName;
		private QType rType;
		private DNSClass rClass;
		private int ttl;
		private byte[] rData;
		
		public ResourceRecord(String n, QType t, DNSClass c, int ttl, byte[] rData) {
			
		}
		
		public String getName() { return rName; }
		public QType getType() { return rType; }
		public DNSClass getDNSClass() { return rClass; }
		public int getTTL() { return ttl; }
		public byte[] getData() { return Arrays.copyOf(rData, rData.length); }
		
		public void setName(String n) {
			if (n == null || n.trim().isEmpty()) throw new IllegalArgumentException("name ne peut être null ou vide");
			rName = n.trim();
		}
		
		public void setType(QType t) {
			if (t == null) throw new IllegalArgumentException("QType ne peut être null");
			if (t == QType.UNDEFINED) throw new IllegalArgumentException("QType ne peut être UNDEFINED");
			rType = t;
		}
		
		public void setDNSClass(DNSClass c) {
			if (c == null) throw new IllegalArgumentException("DNSClass ne peut être null");
			if (c == DNSClass.UNDEFINED) throw new IllegalArgumentException("DNSClass ne peut être UNDEFINED");
			rClass = c;
		}
		
		public void setTTL(int t) {
			if (t < 0 || t > 0xffff) throw new IllegalArgumentException("TTL doit être entre 0 et 65535 inclus.");
			ttl = t;
		}
		
		public void setData(byte[] d) {
			rData = Arrays.copyOf(d, d.length);
		}
		
	}
	
	
	
	
	
	public class BadDNSResponseException extends Exception {
		private static final long serialVersionUID = 1L;
		private BadDNSResponseException(String message) {
			super("La réponse DNS reçu n'est pas valide : "+message);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	public static byte[] convertDomainNameToLabelSequence(String domainName) {
		if (domainName == null) throw new IllegalArgumentException("domainName ne peut être null");
		String[] labels = domainName.split(".");
		ByteBuffer bb = ByteBuffer.allocate(512);
		for (String label : labels) {
			byte[] chars = label.getBytes();
			if (chars.length == 0) throw new IllegalArgumentException("un des label de domainName est vide");
			if (chars.length > 63) throw new IllegalArgumentException("un des label de domainName est trop grand (> 63 octet)");
			bb.put((byte)(chars.length & 0x3f));
			for (byte c : chars)
				bb.put(c);
		}
		bb.put((byte)0);
		
		return Arrays.copyOf(bb.array(), bb.position());
	}
	
	
	
	
}
