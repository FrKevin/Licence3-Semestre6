#include <stdio.h>
#include <stdlib.h>

#include "common.h"

void assert_message(int cond, char* message){
    if(cond == 0 ){
        printf("%s\n", message);
        exit(EXIT_FAILURE);
    }
}
