package rsx.tp3.dns;

public enum ResponseCode {
	NO_ERROR((byte)0x0),
	FORMAT_ERROR((byte)0x1),
	SERVER_FAILURE((byte)0x2),
	NAME_ERROR((byte)0x3),
	NOT_IMPLEMENTED((byte)0x4),
	REFUSED((byte)0x5),
	UNDEFINED(null);
	
	final Byte fourBitsValue;
	
	private ResponseCode(Byte b) {
		fourBitsValue = b;
	}
	
	static ResponseCode getFromValue(byte v) {
		for (ResponseCode ev : values())
			if (ev.fourBitsValue != null && v == ev.fourBitsValue) return ev;
		return UNDEFINED;
	}
}