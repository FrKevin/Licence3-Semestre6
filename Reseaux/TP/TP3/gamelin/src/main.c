#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "common.h"
#include "packet.h"

int main(int argc, char **argv) {
    unsigned char byts[512];
    char * label;
    int len;
    int index = 0;
    int i = 0;

    char message[] ="wwww.google.fr";
    label = strtok (message, ".");


    while (label != NULL) {
        printf("index= %i\n", index);
        len = strlen(label);
        printf("len = %d\n", len);
        assert_message( len != 0 , "The label of domaine name is empty.");
        assert_message( len < 63, "The label of domaine name is bigger than 63 octets.");
        byts[index++] = len & 0x3f;

        printf("index= %i\n", index);
        for(i =0; i< len; i++){
            printf("char = %c\n", label[i]);
            byts[index++] = label[i] & 0xffff;
            printf("val = %c\n",  label[i] & 0xffff );
        }
        label = strtok (NULL, ".");
        printf("####################################################################\n");
    }

    for (i = 0; i < 17; i++) {
        printf("byts[%i] =int: %d char: %c\n", i, byts[i], byts[i]);
    }
    exit(EXIT_SUCCESS);
}
