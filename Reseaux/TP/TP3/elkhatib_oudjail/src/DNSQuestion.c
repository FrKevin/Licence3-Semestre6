#include "DNSQuestion.h"
#include "lib/ArrayList.h"
#include "Core.h"


extern question_t *DNSQ_construct(const header_t header) {
  question_t *construct;
  construct = (question_t*) malloc(sizeof(question_t));
  construct->header = header;
  construct->qname = ArrayList_construct();
  construct->qtype = 0;
  construct->qclass = 0;
  return construct;
}

extern question_t *DNSQ_construct_with_bytes(const header_t header, const byte_t *bytes, size_t begin, size_t nbytes) {
  size_t i = begin, nquestion = 0;
  qdcount_t qdcount = DNSH_get_qdcount(header);
  question_t construct = DNSQ_construct(header);
  while (nquestion < qdcount && i < nbytes) {
    ArrayList_add_elm(construct->qname, bytes[i]);
    nquestion = bytes[i] == 0 ? nquestion + 1 : nquestion;
    ++i;
  }
  assert_message(nquestion == qdcount, "Le nombre de question ajouté n'est pas conforme au champs qdcount");
  return construct;
}

extern void DNSQ_destruct(question_t *question) {
  question->header = NULL;
  ArrayList_destruct(question->qname);
  free(question);
}

extern void DNSQ_transform_question(const char *question, byte_t *buff, int lenq) {
  byte_t noctet = 0;
  size_t pos_noctet = 0;
  size_t i;

  for (i = 0; i <= lenq; ++i) { /* Comptait le caractere /0 */
    if (question[i] == '.' || question[i] == 0) {
      buff[pos_noctet] = noctet;
      noctet = 0;
      pos_noctet = i+1;
    } else {
      buff[i+1] = question[i];
      noctet++;
    }
  }
  buff[lenq+1] = question[lenq];
}

extern void DNSQ_add_question(question_t *question, char *q, int lenq) {
  byte_t qname_elm[lenq+1];
  size_t i;
  DNSQ_transform_question(q, qname_elm, lenq);
  for (i = 0; i <= lenq; i++) {
    ArrayList_add_elm(&(question->qname), qname_elm[i]);
  }
}

extern void DNSQ_set_qtype(question_t *question, qtype_t qtype) {
  question->qtype = qtype;
}

extern void DNSQ_set_qclass(question_t *question, qclass_t qclass) {
  question->qclass = qclass;
}

/* Utilisation statique */
extern void DNSQ_begin_and_len_question_at(const question_t *question, size_t at, size_t *begin, size_t *len) {
  int noctet;
  size_t i = 0;
  size_t qcpt = 0;
  qdcount_t qdcount = DNSH_get_qdcount(question->header);

  if (at >= qdcount) {
    fprintf(stderr, "%s\n", "Out of bound !");
    return;
  }

  while (qcpt < at) {
    noctet = ArrayList_get_elm(question->qname, i);
    i += noctet + 1;
    qcpt++;
  }
  *begin = i + 1;
  *len = ArrayList_get_elm(question->qname, i);
}


/* Refactor */
extern char *DNSQ_get_question_at(const question_t *question, size_t at) { /* Optimiser */
  int noctet;
  size_t i = 0;
  size_t ibuff = 0;
  size_t qcpt = 0;
  size_t len;
  qdcount_t qdcount = DNSH_get_qdcount(question->header);

  if (at >= qdcount) {
    fprintf(stderr, "%s\n", "Out of bound !");
    return NULL;
  }

  while (qcpt < at) {
    noctet = ArrayList_get_elm(question->qname, i);
    i += noctet + 1;
    qcpt++;
  }

  len = ArrayList_get_elm(question->qname, i);
  buff = malloc(sizeof(char) * len + 1);

  for (i++; i < (i + len); ++i) {
    buff[ibuff] = ArrayList_get_elm(question->qname, i);
    ibuff++;
  }

  buff[len] = '\0';
  return buff;
}

extern qtype_t *DNSQ_get_qtype(const question_t *question) {
  return question->qtype;
}


extern qclass_t *DNSQ_get_qclass(const question_t *question) {
  return question->qclass;
}

extern byte_t *DNSQ_construct_bytes(const question_t *question) {
  int len = (question->qname)->size;
  byte_t *result = (byte_t*) malloc(len * sizeof(byte_t));
  for (int i=0; i < len; ++i) {
    result[i] = ArrayList_get_elm(question->qname, i);
  }
  return result;
}
