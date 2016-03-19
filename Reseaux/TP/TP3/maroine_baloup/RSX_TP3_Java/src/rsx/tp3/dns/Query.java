package rsx.tp3.dns;

public class Query {
	String qName;
	QType qType;
	DNSClass qClass;
	
	public Query(String n, QType t, DNSClass c) {
		setName(n);
		setType(t);
		setDNSClass(c);
	}
	
	Query() { };
	
	public String getName() { return qName; }
	public QType getType() { return qType; }
	public DNSClass getDNSClass() { return qClass; }
	
	public void setName(String n) {
		if (n == null) throw new IllegalArgumentException("name ne peut être null ou vide");
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