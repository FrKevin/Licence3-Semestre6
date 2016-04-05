#include <stdlib.h>
#include "DNSHeader.h"


int main(int argc, char const *argv[]) {

  header_a headp = DNSH_construct();
  DNSH_set_id(headp, 5212);
  DNSH_set_qr(headp, True);
  DNSH_set_opcode(headp, IQUERY);
  DNSH_set_aa(headp, False);
  DNSH_set_tc(headp, True);


  DNSH_display(headp);
  DNSH_destruct(headp);

  return 0;
}
