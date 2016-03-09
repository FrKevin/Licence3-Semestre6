#include "Core.h"

#include <stdlib.h>
#include <time.h>
#include <math.h>

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

int randint(int min, int max){
    if(min <= max) {
      return rand() % (max - min) + min;
    }
    return rand() % (min - max) + max;
}


id_t generate_id() {
  return (id_t) randint(0, MAX_U16INT);
}

int MAX_VALUE(int nbit) {
  return pow(2, nbit) -1;
}
