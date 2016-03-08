#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "packet.h"
#include "common.h"
  int main(int argc, char **argv) {
    int i=0;
  unsigned char buffer_byte[8];

  int_to_byte(3, buffer_byte);
  for(i=0; i<8; i++){
        printf("bits[%i] = %i \n",i, buffer_byte[i]);
  }

    exit(EXIT_SUCCESS);
}
