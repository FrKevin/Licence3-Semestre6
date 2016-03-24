#ifndef __DNS_HEADER_H__
#define __DNS_HEADER_H__

#include <stdint.h>

/* Define */
/* ----------- HEADER ------------------- */
#define HEADER_LENGTH 96

#define HEADER_LENGTH_ID 16
#define HEADER_LENGTH_QR 1
#define HEADER_LENGTH_Opcode 4
#define HEADER_LENGTH_AA 1
#define HEADER_LENGTH_TC 1
#define HEADER_LENGTH_RD 1
#define HEADER_LENGTH_RA 1
#define HEADER_LENGTH_QR 1


#define HEADER_LENGTH_Z 3
#define HEADER_LENGTH_RCODE 4
#define HEADER_LENGTH_QDCOUNT 16
#define HEADER_LENGTH_ANCOUNT 16
#define HEADER_LENGTH_NSCOUNT 16
#define HEADER_LENGTH_ARCOUNT 16


/* Define the structure */
typedef enum {
  QUERY,
  IQUERY,
  STATUS
} opcode_t;

typedef enum {
  NO_ERROR_CONDITION,
  FORMAT_ERROR,
  SERVER_FAILURE,
  NAME_ERROR,
  NOT_IMPLEMENTED,
  REFUSED
} rcode_t;



typedef byte_t header_t[HEADER_LENGTH];

extern header_t DNSH_construct();
extern header_t DNSH_construct_with_bytes(byte_t bytes);
extern header_t DNSH_init(header_t headp);

/* Setteur */
/*
extern void DNSH_set_id(header_t headp, id_t id);

extern void DNSH_set_qr(header_t headp, bool qr);
extern void DNSH_set_opcode(header_t headp, opcode_t opcode);
extern void DNSH_set_aa(header_t headp, bool aa);
extern void DNSH_set_tc(header_t headp, bool tc);
extern void DNSH_set_rd(header_t headp, bool rd);
extern void DNSH_set_ra(header_t headp, bool ra);

extern void DNSH_set_z(header_t headp, byte_t z);
extern void DNSH_set_rcode(header_t headp, rcode_t rcode);

extern void DNSH_set_qdcount(header_t headp, qdcount_t qdcount);
extern void DNSH_set_ancount(header_t headp, ancount_t ancount);
extern void DNSH_set_nscount(header_t headp, nscount_t nscount);
extern void DNSH_set_arcount(header_t headp, arcount_t arcount);
*/
/* Getteur */
/*
extern id_t DNSH_get_id(header_t headp);

extern bool DNSH_get_qr(header_t headp);
extern opcode_t DNSH_get_opcode(header_t headp);
extern bool DNSH_get_aa(header_t headp);
extern bool DNSH_get_tc(header_t headp);
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
