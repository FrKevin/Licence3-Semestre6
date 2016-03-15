#ifndef __DNS_MAKE_H__
#define __DNS_MAKE_H__

#include "DNS.h"

/* Header */
extern void set_id(header_t *pheader, id_t id);

extern void set_qr(header_t *pheader, bool qr);
extern void set_opcode(header_t *pheader, opcode_t opcode);
extern void set_aa(header_t *pheader, bool aa);
extern void set_tc(header_t *pheader, bool tc);
extern void set_rd(header_t *pheader, bool rd);
extern void set_ra(header_t *pheader, bool ra);

extern void set_z(header_t *pheader, byte_t z);
extern void set_rcode(header_t *pheader, rcode_t rcode);

extern void set_qdcount(header_t *pheader, qdcount_t qdcount);
extern void set_ancount(header_t *pheader, ancount_t ancount);
extern void set_nscount(header_t *pheader, nscount_t nscount);
extern void set_arcount(header_t *pheader, arcount_t arcount);

extern void add_question(header_t *pheader, const char * question);


extern id_t get_id(header_t *pheader);

extern bool get_qr(header_t *pheader);
extern opcode_t get_opcode(header_t *pheader);
extern bool get_aa(header_t *pheader);
extern bool get_tc(header_t *pheader);
extern bool get_rd(header_t *pheader);
extern bool get_ra(header_t *pheader);

extern byte_t get_z(header_t *pheader);
extern rcode_t get_rcode(header_t *pheader);

extern qdcount_t get_qdcount(header_t *pheader);
extern ancount_t get_ancount(header_t *pheader);
extern nscount_t get_nscount(header_t *pheader);
extern arcount_t get_arcount(header_t *pheader);

#endif
