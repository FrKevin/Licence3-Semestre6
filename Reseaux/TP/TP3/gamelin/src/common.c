#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef __WIN32__
    #include <windows.h>
#endif

#include "common.h"

#ifdef __WIN32__
    /*
    Value for color
    0: noir
    1: bleu foncé
    2: vert
    3: bleu-gris
    4: marron
    5: pourpre
    6: kaki
    7: gris clair
    8: gris
    9: bleu
    10: vert fluo
    11: turquoise
    12: rouge
    13: rose fluo
    14: jaune fluo
    15: blanc
    */
    void set_color(int t, int f) {
        HANDLE H=GetStdHandle(STD_OUTPUT_HANDLE);
        SetConsoleTextAttribute(H,f*16+t);
    }
#endif


void assert_message(int cond, char* message){
    if(cond == 0 ){
      #ifdef __WIN32__
        printf("%s: code error: %i\n", message, errno_windows);
      #else
        perror(message);
      #endif
      exit(EXIT_FAILURE);
    }
}

void send_verbose_message(char* message){
    if(verbose == 1){
        #ifdef __WIN32__
            set_color( 2, 0);
            printf("%s\n", message);
            set_color(7, 0);
        #else
            printf(ANSI_COLOR_BOLDGREEN "%s"NORM"\n", message);
        #endif
    }
}

void int_to_byte(unsigned int value, unsigned char buffer_byte[8]) {
  int i;

  for (i = 7; i >= 0; i--) {
    buffer_byte[i] = value & 1;
    value >>= 1;
  }
}

unsigned char toByte(unsigned char bits[]) {
  unsigned char b = 0;
  int i =0;
  for (i=0; i<8; i++) {
    b = (unsigned char) ((b << 1) + ((bits[i]) ? 1 : 0));
  }
  return b;
}

#ifdef __WIN32__
  char *strdup (const char *s) {
      char *d = malloc (strlen (s) + 1);   /* Space for length plus nul */
      if (d == NULL) return NULL;          /* No memory */
      strcpy (d,s);                        /* Copy the characters */
      return d;                            /* Return the new string */
  }
#endif

int convert_donmaine_name_to_label(char domaine_name[], char byts[]){
    char * label;
    int len;
    int index = 0;
    int i = 0;
    char* domaine_name_cp = strdup(domaine_name);

    assert_message( domaine_name != NULL, "Conot convert the domaine name, because its null.");
    label = strtok (domaine_name_cp, ".");
    while (label != NULL) {
        len = strlen(label);
        assert_message( len != 0 , "The label of domaine name is empty.");
        assert_message( len < 63, "The label of domaine name is bigger than 63 octets.");
        byts[index++] = len & 0x3f;
        for(i =0; i< len; i++){
            byts[index++] = label[i];
        }
        label = strtok (NULL, ".");
    }
    byts[index++] = 0;
    return index;
}
