#ifndef __DNS_H__
#define __DNS_H__

#include "Core.h"
#include "DNSHeader.h"
#include "DNSQuestion.h"

typedef struct {
  header_t header;
  question_t question;
} dnspacket_t;


extern byte_t DNS_to_bytes(const dnspacket_t *dnspacket);

extern void DNS_display(const dnspacket_t *dnspacket);

#endif
