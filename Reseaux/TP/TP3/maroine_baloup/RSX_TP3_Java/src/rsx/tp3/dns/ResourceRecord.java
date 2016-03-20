package rsx.tp3.dns;

import java.util.Arrays;

public class ResourceRecord {
	String rName;
	QType rType;
	DNSClass rClass;
	long ttl; // unsigned int
	byte[] rData;
	Object decodedData;
	
	public ResourceRecord(String n, QType t, DNSClass c, long ttl, byte[] d) {
		setName(n);
		setType(t);
		setDNSClass(c);
		setTTL(ttl);
		setData(d);
	}
	
	ResourceRecord() { }
	
	public String getName() { return rName; }
	public QType getType() { return rType; }
	public DNSClass getDNSClass() { return rClass; }
	public long getTTL() { return ttl; }
	public byte[] getData() { return Arrays.copyOf(rData, rData.length); }
	public Object getDecodedData() { return decodedData; }
	
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
	
	public void setTTL(long t) {
		if (t < 0 || t > 0xffffffff) throw new IllegalArgumentException("TTL doit être entre 0 et (2^32)-1 inclus.");
		ttl = t;
	}
	
	public void setData(byte[] d) {
		rData = Arrays.copyOf(d, d.length);
	}
	
}