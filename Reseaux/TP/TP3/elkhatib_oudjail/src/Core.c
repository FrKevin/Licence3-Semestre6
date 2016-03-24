#include "Core.h"

#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <stdint.h>


void assert_message(int cond, char* message) {
    if (cond == 0 ) {
      #ifdef WIN32
        fprintf(stdout, "%s\n", msg);
      #endif
      #ifdef UNIX
        perror(message);
      #endif
      exit(EXIT_FAILURE);
    }
}

int randint(int min, int max) {
    if(min <= max) {
      return rand() % (max - min) + min;
    }
    return rand() % (min - max) + max;
}


uint16_t generate_uint16() {
  return (uint16_t) randint(0, MAX_U16INT);
}

int MAX_VALUE(int nbit) {
  return pow(2, nbit) -1;
}

void insert_uint16(byte_t bytes[], size_t index, uint16_t n) {
  bytes[index]     = (byte_t) (n >> 8);
  bytes[index + 1] = (byte_t) (n & 0x00ff);
}

void insert_inf_uint8(byte_t bytes[], size_t index, byte_t n, int nshift) {
  bytes[index] |= n << nshift;
}
