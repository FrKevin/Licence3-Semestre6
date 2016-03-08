#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common.h"

void assert_message(int cond, char* message){
    if(cond == 0 ){
      #ifdef WIN32
        fprintf(stdout, "%s\n", msg);
      #endif
      #ifdef UNIX
        fprintf(stdout, "%s: %s\n", msg, strerror(errno));
      #endif
      exit(EXIT_FAILURE);
    }
}

char* itoa(int value, char* str, int radix) {
    static char dig[] =
        "0123456789"
        "abcdefghijklmnopqrstuvwxyz";
    int n = 0, neg = 0;
    unsigned int v;
    char* p, *q;
    char c;
    if (radix == 10 && value < 0) {
        value = -value;
        neg = 1;
    }
    v = value;
    do {
        str[n++] = dig[v%radix];
        v /= radix;
    } while (v);
    if (neg)
        str[n++] = '-';
    str[n] = '\0';
    for (p = str, q = p + n/2; p != q; ++p, --q)
        c = *p, *p = *q, *q = c;
    return str;
}

unsigned char toByte(unsigned char bits[]) {
  unsigned char b = 0;
  int i =0;
  for (i=0; i<8; i++) {
    b = (unsigned char) ((b << 1) + ((bits[i]) ? 1 : 0));
  }
  return b;
}

int convert_donmaine_name_to_label(char domaine_name[], char byts[]){
    char * label;
    int len;
    int index = 0;
    int i = 0;

    assert_message( domaine_name != NULL, "Conot convert the domaine name, because its null.");

    label = strtok (domaine_name, ".");
    while (label != NULL) {
        len = strlen(label);
        assert_message( len != 0 , "The label of domaine name is empty.");
        assert_message( len < 63, "The label of domaine name is bigger than 63 octets.");
        byts[index++] = len & 0x3f;
        for(i =0; i< len; i++){
            byts[index++] = label[i];
        }
        byts[index++] = 0;
        label = strtok (NULL, ".");
    }
    return index;
}
