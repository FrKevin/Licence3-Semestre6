#ifndef __DNS_MAKE_H__
#define __DNS_MAKE_H__

#include "DNS.h"

/* Header */
extern void set_id(id_t id);

extern void set_qr(bool qr);
extern void set_opcode(opcode_t opcode);
extern void set_aa(bool aa);
extern void set_tc(bool tc);
extern void set_rd(bool rd);
extern void set_ra(bool ra);

extern void set_z(byte_t z);
extern void set_rcode(rcode_t rcode);

extern void set_qdcount(qdcount_t qdcount);
extern void set_ancount(ancount_t ancount);
extern void set_nscount(nscount_t nscount);
extern void set_arcount(arcount_t arcount);


#endif
