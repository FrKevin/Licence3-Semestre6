#ifndef __DNS_H__
#define __DNS_H__

#include "Core.h"
#include "DNSHeader.h"
#include "DNSQuestion.h"

typedef struct {
  header_a header;
  question_s question;
  answer_s answer;

} dnspacket_s;


extern dnspacket_s *DNS_construct(); // On sens bas le couille

extern void DNS_construct_with_bytes(const byte_p *bytes);

extern byte_p *DNS_construct_bytes(const dnspacket_s *dnspacket);

extern void DNS_display(const dnspacket_s *dnspacket);





#endif
