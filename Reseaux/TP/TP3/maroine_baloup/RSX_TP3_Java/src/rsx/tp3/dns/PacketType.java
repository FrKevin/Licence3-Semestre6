package rsx.tp3.dns;

public enum PacketType {
	QUERY(false),
	RESPONSE(true);
	
	final boolean bitValue;
	
	private PacketType(boolean b) {
		bitValue = b;
	}
	
	static PacketType getFromBoolean(boolean b) {
		return b ? RESPONSE : QUERY;
	}
}