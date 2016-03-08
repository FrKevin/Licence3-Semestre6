#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#include "packet.h"
#include "common.h"
#include "udp_sender.h"

int main(int argc, char **argv) {

    printf("begin create_simple_query() \n");
        create_simple_query("wwww.google.com");
    printf("create_simple_query() ok \n");

    printf("begin send_packet()  \n");
    send_packet("8.8.8.8", 53, get_bytes_query());
    printf("send_packet() ok \n");
    exit(EXIT_SUCCESS);
}
