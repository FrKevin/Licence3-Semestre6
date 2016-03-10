#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "packet.h"
#include "common.h"
#include "udp_sender.h"

int main(int argc, char **argv) {
    udp_packet packet;
    char buffer[16384];
    int offset =0;

    initialize(&packet, "8.8.8.8", 53);

    create_simple_query("www.google.fr");

    display_packet();

    offset = get_bytes_query(buffer);
    send_packet(&packet, offset, (char *) buffer);

    clear(&packet);
    exit(EXIT_SUCCESS);
}
