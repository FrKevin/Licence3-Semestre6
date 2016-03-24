#ifndef __DNS_QUESTION_H__
#define __DNS_QUESTION_H__
#include "DNSHeader.h"


typedef qtype_t uint16_t;
typedef qclass_t uint16_t;

typedef struct {
  header_t header;
  ArrayList *qname;
  qtype_t qtype;
  qclass_t qclass;
} question_t;



extern question_t *DNSQ_construct(const header_t header);
extern question_t *DNSQ_construct_with_bytes(const header_t header, const byte_t *bytes);

extern byte_t *DNSQ_toconstruct_bytes(const question_t *question, int *sizbuff);


extern void DNSQ_destruct(question_t *question);

extern char *DNSQ_get_question_at(const question_t *question, int at, char *buff);
extern qtype_t *DNSQ_get_qtype(const question_t *question);
extern qclass_t *DNSQ_get_qclass(const question_t *question);

extern void DNSQ_add_question(char *question, char *q);
extern void DNSQ_set_qtype(question_t *question, qtype_t qtype);
extern void DNSQ_set_qclass(question_t *question, qclass_t qclass);


extern void DNSQ_transform_question(const char *question, byte_t *buff, int lenq);

#endif
