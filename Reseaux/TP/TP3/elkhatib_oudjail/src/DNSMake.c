#include "DNSMake.h"
#include "DNS.h"

/* Explain the reasonnement */
#define SHIFT_QR 8 - HEADER_LENGTH_QR  /* 7 */
#define SHIFT_Opcode SHIFT_QR - HEADER_LENGTH_Opcode /* 3 */
#define SHIFT_AA SHIFT_Opcode - HEADER_LENGTH_AA /* 2 */
#define SHIFT_TC SHIFT_AA - HEADER_LENGTH_TC /* 1 */

#define SHIFT_RA 8 - HEADER_LENGTH_RA  /* 7 */
#define SHIFT_Z SHIFT_QR - HEADER_LENGTH_Z /* 4 */


static void insert_uint16(header_t *pheader, size_t index, uint16_t n) {
  pheader[index]     = (byte_t) (n >> 8);
  pheader[index + 1] = (byte_t) (n & 0x00ff);
}

static void insert_inf_uint8(header_t *pheader, size_t index, byte_t n, int nshift) {
  pheader[index] |= n << nshift;
}

/* --------------------------------- Setteur -----------------------------------------------*/

/* To facilitate reading, the numbers are written in hexadecimal form */
extern void set_blank_header(header_t *pheader) {
  int i;
  for (i = 0; i < HEADER_LENGTH; ++i) {
    pheader[i] = 0;
  }
}

extern void set_id(header_t *pheader, id_t id) {
  insert_uint16(pheader, 0, id);
}

extern void set_qr(header_t *pheader, bool qr) {
  insert_inf_uint8(pheader, 2, qr, SHIFT_QR);
}

extern void set_opcode(header_t *pheader, opcode_t opcode) {
  insert_inf_uint8(pheader, 2, opcode, SHIFT_Opcode);
}

extern void set_aa(header_t *pheader, bool aa) {
  insert_inf_uint8(pheader, 2, aa, SHIFT_AA);
}

extern void set_tc(header_t *pheader, bool tc) {
  insert_inf_uint8(pheader, 2, tc, SHIFT_TC);

}
/* A tester si peut etre remplacer par la methode avec 0 en shift */
extern void set_rd(header_t *pheader, bool rd) {
  /* packet_header[2] |= (byte_t) rd; */
  insert_inf_uint8(pheader, 2, rd, 0);
}

extern void set_ra(header_t *pheader, bool ra) {
  insert_inf_uint8(pheader, 3, ra, SHIFT_RA);
}

extern void set_z(header_t *pheader, byte_t z) {
  insert_inf_uint8(pheader, 3, z, SHIFT_Z);
}

extern void set_rcode(header_t *pheader, byte_t rcode) {
  packet_header[3] |= (rcode & 0x0f);
}

extern void set_qdcount(header_t *pheader, qdcount_t qdcount) {
  insert_uint16(pheader, 4, qdcount);
}

extern void set_ancount(header_t *pheader, ancount_t ancount) {
  insert_uint16(pheader, 6, ancount);
}

extern void set_nscount(header_t *pheader, nscount_t nscount) {
  insert_uint16(pheader, 8, nscount);
}

extern void set_arcount(header_t *pheader, arcount_t arcount) {
  insert_uint16(pheader, 10, arcount);
}

extern void add_question(header_t *pheader, char* question) {

}

/* --------------------------------- Getteur -----------------------------------------------*/
static uint16_t extract_uint16(header_t *pheader) {
  uint16_t result;
  return result;
}

static byte_t extract_uint8(header_t *pheader) {
  byte_t result;
  return result;
}

extern id_t get_id(header_t *pheader) {

}


extern bool get_qr(header_t *pheader) {

}

extern opcode_t get_opcode(header_t *pheader) {

}

extern bool get_aa(header_t *pheader) {

}

extern bool get_tc(header_t *pheader) {

}

extern bool get_rd(header_t *pheader) {

}

extern bool get_ra(header_t *pheader) {

}


extern byte_t get_z(header_t *pheader) {

}

extern rcode_t get_rcode(header_t *pheader) {

}

extern qdcount_t get_qdcount(header_t *pheader) {

}

extern ancount_t get_ancount(header_t *pheader) {

}

extern nscount_t get_nscount(header_t *pheader) {

}

extern arcount_t get_arcount(header_t *pheader) {

}
