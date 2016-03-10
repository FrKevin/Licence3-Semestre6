package rsx.tp3.dns;

import java.net.InetAddress;
import java.nio.ByteBuffer;

public enum QType {
	A(1, ResponseDataDecoder.binaryIPv4Decoder),
	NS(2, ResponseDataDecoder.domainNameDecoder),
	MD(3, ResponseDataDecoder.domainNameDecoder),
	MF(4, ResponseDataDecoder.domainNameDecoder),
	CNAME(5, ResponseDataDecoder.domainNameDecoder),
	SOA(6, (bb, l) -> {
		return new SOARData(ResponseDataDecoder.domainNameDecoder.decode(bb, l),
				ResponseDataDecoder.domainNameDecoder.decode(bb, l),
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff);
	}),
	MB(7, ResponseDataDecoder.domainNameDecoder),
	MG(8, ResponseDataDecoder.domainNameDecoder),
	MR(9, ResponseDataDecoder.domainNameDecoder),
	NULL(10),
	WSK(11),
	PTR(12, ResponseDataDecoder.domainNameDecoder),
	HINFO(13, (bb, l) -> {
		return new HInfoRData(ResponseDataDecoder.characterStringDecoder.decode(bb, l),
				ResponseDataDecoder.characterStringDecoder.decode(bb, l));
	}),
	MX(14, (bb, l) -> {
		return new MXRData(bb.getShort() & 0xffff,
				ResponseDataDecoder.domainNameDecoder.decode(bb, l-2));
	}),
	TXT(15),
	AXFR(252),
	MAILB(253),
	MAILA(254),
	ALL(255),
	UNDEFINED(null);
	
	final Integer value;
	final ResponseDataDecoder<?> decoder;

	private QType(Integer v, ResponseDataDecoder<?> d) {
		value = v;
		decoder = d;
	}
	private QType(Integer v) {
		this(v, ResponseDataDecoder.defaultDecoder);
	}
	
	static QType getFromValue(int v) {
		for (QType ev : values())
			if (ev.value != null && v == ev.value) return ev;
			
		return UNDEFINED;
	}
	
	
	

	
	
	public static class HInfoRData {
		public final String cpu;
		public final String os;
		
		private HInfoRData(String c, String o) {
			cpu = c; os = o;
		}
		
		@Override
		public String toString() {
			return "HInfo{cpu="+cpu+",os="+os+"}";
		}
	}
	
	
	public static class MXRData {
		public final long preference;
		public final String exchange;
		
		private MXRData(long p, String e) {
			preference = p; exchange = e;
		}
		@Override
		public String toString() {
			return "MX{preference="+preference+",exchange="+exchange+"}";
		}
	}
	
	
	public static class SOARData {
		public final String mName;
		public final String rName;
		public final long serial;
		public final long refresh;
		public final long retry;
		public final long expire;
		public final long minimum;
		
		private SOARData(String mn, String rn, long s, long ref, long ret, long e, long m) {
			mName = mn; rName = rn; serial = s; refresh = ref;
			retry = ret; expire = e; minimum = m;
		}
		@Override
		public String toString() {
			return "SOA{mName="+mName+",rName="+rName+",serial="+serial+",refresh="+refresh+",retry="+retry+",expire="+expire+",minimum="+minimum+"}";
		}
	}
	
	

	
	/**
	 * Permet d'implémenter une façon de décoder les données dans un ResourceRecord
	 * selon le type de donnée qu'il contient
	 * @param <T>
	 */
	@FunctionalInterface
	interface ResponseDataDecoder<T> {
		T decode(ByteBuffer buffer, int dataLength) throws Exception;

		static final QType.ResponseDataDecoder<byte[]> defaultDecoder = (bb, l) -> {
			byte[] data = new byte[l];
			bb.get(data);
			return data;
		};
		
		static final QType.ResponseDataDecoder<String> domainNameDecoder = (bb, l) -> {
			return DNSPacket.readLabelSequenceFromDNSPacket(bb);
		};
		
		static final QType.ResponseDataDecoder<InetAddress> binaryIPv4Decoder = (bb, l) -> {
			return InetAddress.getByAddress(ResponseDataDecoder.defaultDecoder.decode(bb, 4));
		};
		
		static final QType.ResponseDataDecoder<String> characterStringDecoder = (bb, l) -> {
			return DNSPacket.readCharacterStringFromDNSPacket(bb);
		};
	}
	
	
}