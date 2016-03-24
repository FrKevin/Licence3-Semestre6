#include <stdio.h>
#include <string.h>


#include "answer.h"


void display_answer(answer* a){
    int i;

    printf("\tAnswer:\n");
    printf("\t\tName: %s\n", a->name);
    printf("\t\tType: %i\n", a->type);
    printf("\t\tClass: %i\n", a->class);
    printf("\t\tTTL: %u\n", a->ttl);
    printf("\t\trd_length: %i\n", a->rd_length);
    printf("\t\tip address: ");
    for(i =0; i<a->rd_length; i++){
        printf("%i.", a->rdata[i]);
    }
    printf("\n");
}
