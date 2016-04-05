#include "DNSHeader.h"
#include "Core.h"
#include <stdlib.h>
#include <stdio.h>

/* -- Enum fct */
char *OPCODE_to_string(opcode_e opcode) {
  switch (opcode) {
    case QUERY : return "QUERY";
    case IQUERY : return "IQUERY";
    default : return "STATUS";
  }
}

char *RCODE_to_string(rcode_e rcode) {
  switch (rcode) {
    case NO_ERROR_CONDITION : return "NO_ERROR_CONDITION";
    case FORMAT_ERROR : return "FORMAT_ERROR";
    case SERVER_FAILURE : return "SERVER_FAILURE";
    case NAME_ERROR : return "NAME_ERROR";
    case NOT_IMPLEMENTED : return "NOT_IMPLEMENTED";
    default : return "REFUSED";
  }
}

/* Explain the reasonnement */
#define SHIFT_QR 8 - HEADER_NBIT_QR  /* 7 */
#define SHIFT_Opcode SHIFT_QR - HEADER_NBIT_Opcode /* 3 */
#define SHIFT_AA SHIFT_Opcode - HEADER_NBIT_AA /* 2 */
#define SHIFT_TC SHIFT_AA - HEADER_NBIT_TC /* 1 */

#define SHIFT_RA 8 - HEADER_NBIT_RA  /* 7 */
#define SHIFT_Z SHIFT_QR - HEADER_NBIT_Z /* 4 */

/* Construct */
header_a DNSH_construct() {
  header_a construct = (header_a) malloc(sizeof(byte_p) * HEADER_LENGTH);
  DNSH_init(construct);
  return construct;
}

header_a DNSH_construct_with_bytes(byte_p *bytes) {
  size_t i;
  header_a construct = (header_a) malloc(sizeof(byte_p) * HEADER_LENGTH);
  for (i = 0; i < HEADER_LENGTH; i++) { construct[i] = bytes[i]; }
  return construct;
}

void DNSH_destruct(header_a headp) {
  free(headp);
}

extern void DNSH_display(header_a headp) {
  size_t i;
  printf("Entete DNS :\n");
  printf("\tID : %u\n", DNSH_get_id(headp));
  printf("\tQR : %s\n", Bool_to_string(DNSH_get_qr(headp)));
  printf("\tOpCode : %u\n", OPCODE_to_string(DNSH_get_opcode(headp)));
  printf("\tAA : %s\n", Bool_to_string(DNSH_get_aa(headp)));
  printf("\tTC : %s\n", Bool_to_string(DNSH_get_tc(headp)));

  printf("\nTableau d'octets :\n");
  for (i = 0; i < HEADER_LENGTH; i++) {
    printf("Octet numero %i : %u\n", (int)i, headp[i]);
  }
}

/* --------------------------------- Setteur -----------------------------------------------*/
/* To facilitate reading, the numbers are written in hexadecimal form */
void DNSH_init(header_a headp) {
  int i;
  for (i = 0; i < 12; ++i) {
    headp[i] = 0;
  }
}

void DNSH_set_id(header_a headp, id_p id) {
  insert_uint16(headp, 0, id);
}

void DNSH_set_qr(header_a headp, bool_e qr) {
  insert_inf_uint8(headp, 2, qr, SHIFT_QR);
}

void DNSH_set_opcode(header_a headp, opcode_e opcode) {
  insert_inf_uint8(headp, 2, opcode, SHIFT_Opcode);
}

void DNSH_set_aa(header_a headp, bool_e aa) {
  insert_inf_uint8(headp, 2, aa, SHIFT_AA);
}

void DNSH_set_tc(header_a headp, bool_e tc) {
  insert_inf_uint8(headp, 2, tc, SHIFT_TC);

}

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

#define MASK_QR 128
#define MASK_OPCODE 120
#define MASK_AA 4
#define MASK_TC 2
#define MASK_RD 1

#define MASK_RA 128
#define MASK_Z 112
#define MASK_RCODE 15

id_p DNSH_get_id(header_a headp) {
  return extract_uint16(headp, 0);
}

bool_e DNSH_get_qr(header_a headp) {
  return extract_uint8(headp, 2, MASK_QR, SHIFT_QR);
}

opcode_e DNSH_get_opcode(header_a headp) {
  //printf("DNSH_get_opcode, return for extract_uint8 : %u\n", extract_uint8(headp, 2, MASK_OPCODE));
  return extract_uint8(headp, 2, MASK_OPCODE, SHIFT_Opcode);
}

bool_e DNSH_get_aa(header_a headp) {
  return extract_uint8(headp, 2, MASK_AA? SHIFT_AA);
}

bool_e DNSH_get_tc(header_a headp) {
  return extract_uint8(headp, 2, MASK_TC, SHIFT_TC);
}
/*
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
