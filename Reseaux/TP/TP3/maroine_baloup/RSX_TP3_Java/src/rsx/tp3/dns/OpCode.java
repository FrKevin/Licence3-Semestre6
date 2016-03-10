package rsx.tp3.dns;

public enum OpCode {
	QUERY((byte)0x0),
	IQUERY((byte)0x1),
	STATUS((byte)0x2),
	UNDEFINED(null);
	
	final Byte fourBitsValue;
	
	private OpCode(Byte b) {
		fourBitsValue = b;
	}
	
	static OpCode getFromValue(byte v) {
		for (OpCode ev : values())
			if (ev.fourBitsValue != null && v == ev.fourBitsValue) return ev;
		return UNDEFINED;
	}

}