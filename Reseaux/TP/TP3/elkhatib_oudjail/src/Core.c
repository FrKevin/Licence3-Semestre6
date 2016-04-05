#include "Core.h"

#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <stdint.h>

#include <stdio.h>

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

char *Bool_to_string(bool_e b) {
  return b ? "True" : "False";
}

void insert_uint16(byte_p bytes[], size_t index, uint16_t n) {
  bytes[index]     = (byte_p) (n >> 8);
  bytes[index + 1] = (byte_p) (n & 0x00ff);
}

void insert_inf_uint8(byte_p bytes[], size_t index, byte_p n, int nshift) {
  printf("insert_inf_uint8 : param, n : %u, nshift %i\n", n, nshift);
  printf("insert_inf_uint8 : expr = n << nshift : %u\n", n << nshift);
  bytes[index] |= n << nshift;
  printf("insert_inf_uint8 : after expr : %u\n", bytes[index]);
}

uint16_t extract_uint16(byte_p bytes[], int index) {
  uint16_t result;
  result = (bytes[index] << 8);
  //printf("extract_uint16 : result after first expr : %u\n", result);
  result |= (bytes[index + 1]);
  //printf("extract_uint16 : result after second expr : %u\n", result);
  return result;
}

byte_p extract_uint8(byte_p bytes[], int index, uint8_t mask, int nshift) {
  return nshift >> (bytes[index] & mask);
}
