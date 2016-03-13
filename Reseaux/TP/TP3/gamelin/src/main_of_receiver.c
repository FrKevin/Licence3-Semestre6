#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "common.h"
#include "dns_packet.h"
#include "udp_packet.h"
#include "udp_receiver.h"


/*
 * usage - print a help message
 */
void usage(void) {
    #ifdef __WIN32__
        printf("Usage: windows_receiver.exe [-hv]\n");
    #else
        printf("Usage: receiver [-hv]\n");
    #endif
    printf("   -h   print this message\n");
    printf("   -v   print additional diagnostic information\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char **argv) {
    udp_packet udp_receiver;

    char buffer[16384];
    char c;

    verbose = 0;

    /* Parse the command line */
    while ((c = getopt(argc, argv, "hv")) != EOF) {
        switch (c) {
            case 'h':              /* print help message */
                usage();
            break;
            case 'v':              /* emit additional diagnostic info */
                verbose = 1;
            break;
            default:
                usage();
        }
    }

    memset(&buffer[0], 0, 16384);

    initialize_receiver(&udp_receiver, 53);

    receive_packet(&udp_receiver, buffer, 6);

    close_socket(&udp_receiver);

    exit(EXIT_SUCCESS);
}
