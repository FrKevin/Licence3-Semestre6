package rsx.tp3.dns;

import java.net.InetAddress;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

import rsx.tp3.BitArray;

public enum QType {
	A(1, ResponseDataDecoder.binaryIPv4Decoder),
	NS(2, ResponseDataDecoder.domainNameDecoder),
	MD(3, ResponseDataDecoder.domainNameDecoder),
	MF(4, ResponseDataDecoder.domainNameDecoder),
	CNAME(5, ResponseDataDecoder.domainNameDecoder),
	SOA(6, (bb, l) -> new SOARData(ResponseDataDecoder.domainNameDecoder.decode(bb, l),
				ResponseDataDecoder.domainNameDecoder.decode(bb, l),
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff,
				bb.getInt() & 0xffffffff)),
	MB(7, ResponseDataDecoder.domainNameDecoder),
	MG(8, ResponseDataDecoder.domainNameDecoder),
	MR(9, ResponseDataDecoder.domainNameDecoder),
	NULL(10),
	WKS(11, (bb, l) -> new WKSRData(ResponseDataDecoder.binaryIPv4Decoder.decode(bb, l),
			(short) (ResponseDataDecoder.defaultDecoder.decode(bb, 1)[0] & 0xff),
			ResponseDataDecoder.defaultDecoder.decode(bb, l-5)
			)),
	PTR(12, ResponseDataDecoder.domainNameDecoder),
	HINFO(13, (bb, l) -> new HInfoRData(ResponseDataDecoder.characterStringDecoder.decode(bb, l),
				ResponseDataDecoder.characterStringDecoder.decode(bb, l))),
	MINFO(14, (bb, l) -> new HInfoRData(ResponseDataDecoder.domainNameDecoder.decode(bb, l),
			ResponseDataDecoder.domainNameDecoder.decode(bb, l))),
	MX(15, (bb, l) -> new MXRData(bb.getShort() & 0xffff,
				ResponseDataDecoder.domainNameDecoder.decode(bb, l-2))),
	TXT(16, (bb, l) -> {
		List<String> texts = new ArrayList<>();
		while (l > 0) {
			String t = ResponseDataDecoder.characterStringDecoder.decode(bb, l);
			l -= t.getBytes().length + 1;
			texts.add(t);
		}
		return texts;
	}),
	AXFR(252), // noly for query
	MAILB(253), // only for query
	MAILA(254), // only for query
	ALL(255), // only for query
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
	
	
	public static class WKSRData {
		public final InetAddress address;
		public final short protocol;
		public final byte[] bitmap;
		
		public WKSRData(InetAddress a, short p, byte[] b) {
			address = a; protocol = p; bitmap = b;
		}
		@Override
		public String toString() {
			String bitmapStr = "";
			for (byte b : bitmap)
				bitmapStr += new BitArray(b).toString() + " ";
			return "WKS{address="+address+",protocol="+protocol+",bitmap="+bitmapStr.trim()+"}";
		}
	}
	

	public static class MInfoRData {
		public final String rMailBX;
		public final String eMailBX;
		
		private MInfoRData(String r, String e) {
			rMailBX = r; eMailBX = e;
		}
		
		@Override
		public String toString() {
			return "HInfo{rMailBX="+rMailBX+",eMailBX="+eMailBX+"}";
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