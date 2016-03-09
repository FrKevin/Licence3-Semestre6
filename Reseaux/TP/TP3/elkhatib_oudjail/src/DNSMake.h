#ifndef __DNS_MAKE_H__
#define __DNS_MAKE_H__

extern void set_id(id_t id);
extern void set_recursion(bool rd);

extern void set_opcode(byte_t opcode); /* Inf HEADER_MAX_VAL_Opcode */

extern void set_aa(bool aa);
extern void set_tc(bool tc);
extern void set_rd(bool rd);
extern void set_ra(bool ra);

extern void set_z(byte_t z);

extern void set_rcode(byte_t rcode);


#endif
