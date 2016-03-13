#ifdef _MSC_VER
    #pragma comment(lib, "wsock32.lib")
#endif

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

#include "common.h"
#include "udp_packet.h"
#include "udp_sender.h"

void initialize_sender(udp_packet* packet, char* hostname, int port){
    send_verbose_message("");

    initialize_socket(packet);
    send_verbose_message("The socket is initialize.");

    initialize_hostname(packet, hostname);
    send_verbose_message("The hostname is initialize.");

    initialize_sockaddr_in(packet, AF_INET, port, -1);
    send_verbose_message("The receiver of dns packet is initialize.");

    send_verbose_message("The UDP packet is initialize.");
    send_verbose_message("");
}


void send_packet(udp_packet* packet, int size, char* message) {
    int sendto_check;
    struct sockaddr_in receiver_st;

    receiver_st = *(packet->receiver);
    sendto_check = sendto(packet->sockfd, message, size, 0, (struct sockaddr *)&receiver_st, (socklen_t) sizeof(receiver_st) );

    assert_message((sendto_check != -1), "sendto() error ");
    send_verbose_message("Your message has been sent.");
}
