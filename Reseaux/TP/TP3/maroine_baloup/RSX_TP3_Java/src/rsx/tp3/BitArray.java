package rsx.tp3;

public class BitArray {
	
	/**
	 * bits[0] est le bit de poids fort<br/>
	 * bits[7] est le bit de poids faible
	 */
	public boolean[] bits = new boolean[8];
	
	public BitArray() { }
	public BitArray(Byte b) {
		if (b == null) return;
		for (int i=7; i>=0; i--) {
			bits[i] = (b & 1) == 1;
			b = (byte) (b >> 1);
		}
	}
	public BitArray(boolean a, boolean b, boolean c, boolean d,
			boolean e, boolean f, boolean g, boolean h) {
		bits = new boolean[] {a, b, c, d, e, f, g, h};
	}
	
	
	
	
	public byte toByte() {
		byte b = 0;
		for (int i=0; i<8; i++) {
			b = (byte) ((b << 1) + ((bits[i]) ? 1 : 0));
		}
		return b;
	}
	
	@Override
	public String toString() {
		String ret = "";
		for (int i=0; i<8; i++) {
			ret += (bits[i]) ? '1' : '0';
		}
		return ret;
	}
	
	
}
