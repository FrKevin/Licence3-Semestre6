#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "common.h"
#include "dns_packet.h"
#include "udp_packet.h"


/*
 * usage - print a help message
 */
void usage(void) {
    #ifdef __WIN32__
        printf("Usage: dns_windows.exe [-hv]\n");
    #else
        printf("Usage: dns_linux [-hv]\n");
    #endif
    printf("   -h   print this message\n");
    printf("   -v   print additional diagnostic information\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char **argv) {
    udp_packet udp_packet;
    dns_packet dns_packet;

    char buffer[16384];
    int offset = 0;
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

    initialize_udp_packet(&udp_packet, "212.27.40.241", 53);

    create_query(&dns_packet, "www.google.fr");

    display_packet(&dns_packet);

    offset = convert_dns_query_to_char(&dns_packet, buffer);

    display_packet_to_format((char *) buffer, offset, 16);
    printf("\n");
    display_packet_to_format((char *) buffer, offset, 2);

    send_packet(&udp_packet, offset, (char *) buffer);
    memset(&buffer[0], 0, 16384);
    receive_packet(&udp_packet, buffer, offset*2);

    close_socket(&udp_packet);

    exit(EXIT_SUCCESS);
}
