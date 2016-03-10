#include "DNSMake.h"
#include "DNS.h"

/* Explain the reasonnement */
#define SHIFT_QR 8 - HEADER_LENGTH_QR  /* 7 */
#define SHIFT_Opcode SHIFT_QR - HEADER_LENGTH_Opcode /* 3 */
#define SHIFT_AA SHIFT_Opcode - HEADER_LENGTH_AA /* 2 */
#define SHIFT_TC SHIFT_AA - HEADER_LENGTH_TC /* 1 */

#define SHIFT_RA 8 - HEADER_LENGTH_RA  /* 7 */
#define SHIFT_Z SHIFT_QR - HEADER_LENGTH_Z /* 4 */


static void insert_uint16(size_t index, uint16_t n) {
  packet_header[index]     = (byte_t) (n >> 8);
  packet_header[index + 1] = (byte_t) (n & 0x00ff);
}

static void insert_inf_uint8(size_t index, byte_t n, int nshift) {
  packet_header[index] |= n << nshift;
}

/* To facilitate reading, the numbers are written in hexadecimal form */
extern void set_blank_header() {
  int i;
  for (i = 0; i < HEADER_LENGHT; ++i) {
    packet_header[i] = 0;
  }
}

extern void set_id(id_t id) {
  insert_uint16(0, id);
}

extern void set_qr(bool qr) {
  insert_inf_uint8(2, qr, SHIFT_QR);
}

extern void set_opcode(opcode_t opcode) {
  insert_inf_uint8(2, opcode, SHIFT_Opcode);
}

extern void set_aa(bool aa) {
  insert_inf_uint8(2, aa, SHIFT_AA);
}

extern void set_tc(bool tc) {
  insert_inf_uint8(2, tc, SHIFT_TC);

}
/* A tester si peut etre remplacer par la methode avec 0 en shift */
extern void set_rd(bool rd) {
  packet_header[2] |= (byte_t) rd;
}

extern void set_ra(bool ra) {
  insert_inf_uint8(3, ra, SHIFT_RA);
}

extern void set_z(byte_t z) {
  insert_inf_uint8(3, z, SHIFT_Z);
}

extern void set_rcode(byte_t rcode) {
  packet_header[3] |= (rcode & 0x0f);
}

extern void set_qdcount(qdcount_t qdcount) {
  insert_uint16(4, qdcount);
}

extern void set_ancount(ancount_t ancount) {
  insert_uint16(6, ancount);
}

extern void set_nscount(nscount_t nscount) {
  insert_uint16(8, nscount);
}

extern void set_arcount(arcount_t arcount) {
  insert_uint16(10, arcount);
}
