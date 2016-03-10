package rsx.tp3.dns;

public enum DNSClass {
	IN(1),
	CS(2),
	CH(3),
	HS(4),
	UNDEFINED(null);
	
	final Integer value;
	
	private DNSClass(Integer v) {
		value = v;
	}
	
	static DNSClass getFromValue(int v) {
		for (DNSClass ev : values())
			if (ev.value != null && v == ev.value) return ev;
		return UNDEFINED;
	}
}