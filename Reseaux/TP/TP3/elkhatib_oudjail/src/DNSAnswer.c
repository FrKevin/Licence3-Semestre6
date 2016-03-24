#include "DNSAnswer.h"
#include "stdlib.h"
#include "lib/ArrayList.h"


extern answer_t *DNSA_construct(const header_t header) {
  answer_t *result;
  result = (answer_t*) malloc(sizeof(answer_t));

  result->header = header;
  result->name = ArrayList_construct();
  result->type = 0;
  result->class = 0;
  result->ttl = 0;
  result->rdlength = 0;
  result->rdata = ArrayList_construct();
}

extern answer_t *DNSA_construct_with_bytes(const byte_t *bytes, size_t nbytes) {
  
}
extern byte_t *DNSA_toconstruct_bytes(const answer_t *answer, size_t *sizbuf) {

}

extern void DNSA_destruct(answer_t *answer) {
  ArrayList_destruct(answer->name);
  ArrayList_destruct(answer->rdata);
  free(answer);
}

extern void DNSA_set_type(answer_t *answer, type_t type) {
  answer->type = type;
}
extern void DNSA_set_class(answer_t *answer, class_t class) {
  answer->class = class;
}
extern void DNSA_set_ttl(answer_t *answer, ttl_t ttl) {
  answer->ttl = ttl;
}
extern void DNSA_set_rdlength(answer_t *answer, rdlength_t rdlength) {
  answer->rdlength = rdlength;
}

extern type_t DNSA_get_type(const answer_t *answer) {
  return answer->type;
}
extern class_t DNSA_get_class(const answer_t *answer) {
  return answer->class;
}
extern ttl_t DNSA_get_ttl(const answer_t *answer) {
  return answer->ttl;
}
extern rdlength_t DNSA_get_rdlength(const rdlength_t rdlength) {
  return answer->rdlength;
}
