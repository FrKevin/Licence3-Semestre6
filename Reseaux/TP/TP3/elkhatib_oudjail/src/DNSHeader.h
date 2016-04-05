#ifndef __DNS_HEADER_H__
#define __DNS_HEADER_H__

#include <stdint.h>
#include "Core.h"

/* Define */
/* ----------- HEADER ------------------- */

#define HEADER_LENGTH 12

/* ----------- LENGTH EN BIT ------------ */
#define HEADER_NBIT_ID 16
#define HEADER_NBIT_QR 1
#define HEADER_NBIT_Opcode 4
#define HEADER_NBIT_AA 1
#define HEADER_NBIT_TC 1
#define HEADER_NBIT_RD 1
#define HEADER_NBIT_RA 1
#define HEADER_NBIT_QR 1


#define HEADER_NBIT_Z 3
#define HEADER_NBIT_RCODE 4
#define HEADER_NBIT_QDCOUNT 16
#define HEADER_NBIT_ANCOUNT 16
#define HEADER_NBIT_NSCOUNT 16
#define HEADER_NBIT_ARCOUNT 16

/* Define the structure */
typedef enum {
  QUERY,
  IQUERY,
  STATUS
} opcode_e;

extern char *OPCODE_to_string(opcode_e opcode);

typedef enum {
  NO_ERROR_CONDITION,
  FORMAT_ERROR,
  SERVER_FAILURE,
  NAME_ERROR,
  NOT_IMPLEMENTED,
  REFUSED
} rcode_e;

extern char *RCODE_to_string(rcode_e rcode);

typedef byte_p* header_a;

typedef uint16_t id_p;
typedef uint16_t qdcount_p;
typedef uint16_t ancount_p;
typedef uint16_t nscount_p;
typedef uint16_t arcount_p;

typedef uint8_t z_p;


extern header_a DNSH_construct();
extern header_a DNSH_construct_with_bytes(byte_p *bytes);
extern void DNSH_init(header_a headp);

extern void DNSH_destruct(header_a headp);

extern void DNSH_display(header_a headp);

/* Setteur */

extern void DNSH_set_id(header_a headp, id_p id);

extern void DNSH_set_qr(header_a headp, bool_e qr);
extern void DNSH_set_opcode(header_a headp, opcode_e opcode);
extern void DNSH_set_aa(header_a headp, bool_e aa);
extern void DNSH_set_tc(header_a headp, bool_e tc);
/*
extern void DNSH_set_rd(header_a headp, bool_e rd);
extern void DNSH_set_ra(header_a headp, bool_e ra);

extern void DNSH_set_z(header_a headp, z_p z);
extern void DNSH_set_rcode(header_a headp, rcode_e rcode);

extern void DNSH_set_qdcount(header_a headp, qdcount_p qdcount);
extern void DNSH_set_ancount(header_a headp, ancount_p ancount);
extern void DNSH_set_nscount(header_a headp, nscount_p nscount);
extern void DNSH_set_arcount(header_a headp, arcount_p arcount);
*/
/* Getteur */

extern id_p DNSH_get_id(header_a headp);

extern bool_e DNSH_get_qr(header_a headp);
extern opcode_e DNSH_get_opcode(header_a headp);
extern bool_e DNSH_get_aa(header_a headp);
extern bool_e DNSH_get_tc(header_a headp);
/*
extern bool DNSH_get_rd(header_t headp);
extern bool DNSH_get_ra(header_t headp);

extern byte_t DNSH_get_z(header_t headp);
extern rcode_t DNSH_get_rcode(header_t headp);

extern qdcount_t DNSH_get_qdcount(header_t headp);
extern ancount_t DNSH_get_ancount(header_t headp);
extern nscount_t DNSH_get_nscount(header_t headp);
extern arcount_t DNSH_get_arcount(header_t headp);
*/

#endif
