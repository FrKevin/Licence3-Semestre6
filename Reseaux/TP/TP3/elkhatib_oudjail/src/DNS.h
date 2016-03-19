#ifndef __DNS_H__
#define __DNS_H__

#include "Core.h"
#include "DNSHeader.h"
#include "DNSQuestion.h"

typedef struct {
  header_t header;
  question_t question;
  answer_t answer;

} dnspacket_t;


extern dnspacket_t *DNS_construct(); // On sens bas le couille

extern void DNS_construct_with_bytes(const byte_t *bytes);

extern byte_t *DNS_construct_bytes(const dnspacket_t *dnspacket);

extern void DNS_display(const dnspacket_t *dnspacket);





#endif
