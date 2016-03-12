#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "packet.h"
#include "common.h"
#include "udp_sender.h"

/*
 * usage - print a help message
 */
void usage(void) {
    #ifdef __WIN32__
        printf("Usage: windows.exe [-hv]\n");
    #else
        printf("Usage: DNS_Solveur [-hv]\n");
    #endif
    printf("   -h   print this message\n");
    printf("   -v   print additional diagnostic information\n");
    exit(EXIT_FAILURE);
}

int main(int argc, char **argv) {
    udp_packet packet_udp;
    dns_packet packet_dns;

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
    initialize(&packet_udp, "8.8.8.8", 53);

    create_query(&packet_dns, "www.google.fr");

    display_packet(&packet_dns);

    offset = convert_dns_query_to_char(&packet_dns, buffer);

    display_packet_to_format((char *) buffer, offset, 16);
    printf("\n");
    display_packet_to_format((char *) buffer, offset, 2);

    send_packet(&packet_udp, offset, (char *) buffer);

    clear(&packet_udp);
    exit(EXIT_SUCCESS);
}
