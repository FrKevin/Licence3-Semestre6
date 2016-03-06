#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "packet.h"

int main(int argc, char **argv) {
    char buffer[8] ={ 0,0,0,0,0,0,0,0};

    init();
    set_op_code(IQUERY);
    printf("op_code= %u\n", op_code);
    itoa(1,buffer,2);
    printf("buffer = %s\n", buffer);
    printf("buffer 0e: %c\n", buffer[0]);
    if( buffer[1] == 0){
        printf("asaa \n");
    }
    printf("buffer 11e: %u\n", buffer[1]);
    printf("buffer 2e: %c\n", buffer[2]);
    printf("buffer 22e: %u\n", buffer[2]);
    printf("buffer 3e: %c\n", buffer[3]);

    printf("buffer 4e: %cssss\n", buffer[4]);
    printf("buffer 5e: %c\n", buffer[5]);
    printf("buffer 6e: %c\n", buffer[6]);
    printf("buffer 7e: %c\n", buffer[7]);

    exit(EXIT_SUCCESS);
}
