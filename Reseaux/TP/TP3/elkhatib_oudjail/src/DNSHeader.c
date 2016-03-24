#include "DNSHeader.h"
#include "DNS.h"


/* Explain the reasonnement */
#define SHIFT_QR 8 - HEADER_LENGTH_QR  /* 7 */
#define SHIFT_Opcode SHIFT_QR - HEADER_LENGTH_Opcode /* 3 */
#define SHIFT_AA SHIFT_Opcode - HEADER_LENGTH_AA /* 2 */
#define SHIFT_TC SHIFT_AA - HEADER_LENGTH_TC /* 1 */

#define SHIFT_RA 8 - HEADER_LENGTH_RA  /* 7 */
#define SHIFT_Z SHIFT_QR - HEADER_LENGTH_Z /* 4 */


static void insert_uint16(header_t headp, size_t index, uint16_t n) {
  headp[index]     = (byte_t) (n >> 8);
  headp[index + 1] = (byte_t) (n & 0x00ff);
}

static void insert_inf_uint8(header_t headp, size_t index, byte_t n, int nshift) {
  headp[index] |= n << nshift;
}

extern header_t DNSH_construct() {
  header_t construct;
}

extern header_t DNSH_construct_with_bytes(byte_t bytes) {

}

extern header_t DNSH_construct() {
  header_t construct;
  DNSH_init(construct);
  return construct;
}
/* --------------------------------- Setteur -----------------------------------------------*/
/* To facilitate reading, the numbers are written in hexadecimal form */
extern void DNSH_init(header_t headp) {
  int i;
  for (i = 0; i < HEADER_LENGTH; ++i) {
    headp[i] = 0;
  }
}


/*
extern void DNSH_set_id(header_t headp, id_t id) {
  insert_uint16(headp, 0, id);
}

extern void DNSH_set_qr(header_t headp, bool qr) {
  insert_inf_uint8(headp, 2, qr, SHIFT_QR);
}

extern void DNSH_set_opcode(header_t headp, opcode_t opcode) {
  insert_inf_uint8(headp, 2, opcode, SHIFT_Opcode);
}

extern void DNSH_set_aa(header_t headp, bool aa) {
  insert_inf_uint8(headp, 2, aa, SHIFT_AA);
}

extern void DNSH_set_tc(header_t headp, bool tc) {
  insert_inf_uint8(headp, 2, tc, SHIFT_TC);

}

*/
/* A tester si peut etre remplacer par la methode avec 0 en shift */

/*
extern void DNSH_set_rd(header_t headp, bool rd) {
  // packet_header[2] |= (byte_t) rd;
  insert_inf_uint8(headp, 2, rd, 0);
}

extern void DNSH_set_ra(header_t headp, bool ra) {
  insert_inf_uint8(headp, 3, ra, SHIFT_RA);
}

extern void DNSH_set_z(header_t headp, byte_t z) {
  insert_inf_uint8(headp, 3, z, SHIFT_Z);
}

extern void DNSH_set_rcode(header_t headp, byte_t rcode) {
  packet_header[3] |= (rcode & 0x0f);
}

extern void DNSH_set_qdcount(header_t headp, qdcount_t qdcount) {
  insert_uint16(headp, 4, qdcount);
}

extern void DNSH_set_ancount(header_t headp, ancount_t ancount) {
  insert_uint16(headp, 6, ancount);
}

extern void DNSH_set_nscount(header_t headp, nscount_t nscount) {
  insert_uint16(headp, 8, nscount);
}

extern void DNSH_set_arcount(header_t headp, arcount_t arcount) {
  insert_uint16(headp, 10, arcount);
}
*/
/* --------------------------------- Getteur -----------------------------------------------*/
/*
static uint16_t extract_uint16(header_t headp, int index) {
  uint16_t result = 0xffff;
  result &= headp[index] << 8;
  result &= headp[index];
  return result;
}

static byte_t extract_uint8(header_t headp, int index, uint8_t mask) {
  return headp[index] & mask;
}

#define MASK_QR 128
#define MASK_OPCODE 120
#define MASK_AA 4
#define MASK_TC 2
#define MASK_RD 1

#define MASK_RA 128
#define MASK_Z 112
#define MASK_RCODE 15

extern id_t DNSH_get_id(header_t headp) {
  return extract_uint16(headp, 0);
}

extern bool DNSH_get_qr(header_t headp) {
  return extract_uint8(headp, 2, MASK_QR);
}

extern opcode_t DNSH_get_opcode(header_t headp) {
  return extract_uint8(headp, 2, MASK_OPCODE)
}

extern bool DNSH_get_aa(header_t headp) {
  return extract_uint8(headp, 2, MASK_AA)
}

extern bool DNSH_get_tc(header_t headp) {
  return extract_uint8(headp, 2, MASK_TC)
}

extern bool DNSH_get_rd(header_t headp) {
  return extract_uint8(headp, 2, MASK_RD)
}

extern bool DNSH_get_ra(header_t headp) {
  return extract_uint8(headp, 3, MASK_RA)
}

extern byte_t DNSH_get_z(header_t headp) {
  return extract_uint8(headp, 3, MASK_Z)
}

extern rcode_t DNSH_get_rcode(header_t headp) {
  return extract_uint8(headp, 3, MASK_RCODE)
}

extern qdcount_t DNSH_get_qdcount(header_t headp) {
  return extract_uint16(headp, 4);
}

extern ancount_t DNSH_get_ancount(header_t headp) {
  return extract_uint16(headp, 6);
}

extern nscount_t DNSH_get_nscount(header_t headp) {
  return extract_uint16(headp, 8);
}

extern arcount_t DNSH_get_arcount(header_t headp) {
  return extract_uint16(headp, 10);
}
*/
