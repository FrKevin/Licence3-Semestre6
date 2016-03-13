#ifdef __WIN32__ /* Only for  Windows */
    #include <winsock2.h>
    #include <windows.h>
#else
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <netdb.h> /* gethostbyname */
    #include <linux/limits.h> /* const PATH_MAX */
    #include <string.h>
#endif

#include <stdio.h>
#include <stdlib.h>

#include "udp_packet.h"
#include "udp_receiver.h"
#include "common.h"

void initialize_receiver(udp_packet* packet, int port){
    send_verbose_message("");

    initialize_socket(packet);
    send_verbose_message("The socket is initialize.");

    initialize_sockaddr_in(packet, AF_INET, port, INADDR_ANY);
    send_verbose_message("The receiver of dns packet is initialize.");

    assert_message( bind(packet->sockfd, (struct sockaddr*)packet->receiver, sizeof(struct sockaddr_in) ) >=0, "bind(), error" );
    send_verbose_message("Successful link into my socket and receiver");

    send_verbose_message("The UDP packet is initialize.");
    send_verbose_message("");
}

void receive_packet(udp_packet* packet, char buffer[], int sizeof_buffer){
    int len = sizeof_buffer, n;

    printf("Enter receive_packet() \n");
    while ( len > 0 && (n=recv(packet->sockfd, buffer, len, 0) ) > 0 ) {
        printf("zjdzdjozjdjiz j\n");
      len =- (size_t)n;
    }
    printf("The receive message is: %s\n", buffer);
}
