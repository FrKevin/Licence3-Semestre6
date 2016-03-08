#include "core.h"

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
