#ifdef _MSC_VER
#pragma comment(lib, "wsock32.lib")
#endif

#ifdef __WIN32__ /* si vous êtes sous Windows */
#include <windows.h>
#include <winsock.h>

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
#include <sys/types.h>
#include <unistd.h> /* close */

#include "common.h"
#include "udp_sender.h"

void initialize_socket(udp_packet* packet){
    #ifdef __WIN32__
        int err;
        WORD versionWanted;
        WSADATA wsaData;
    #endif
    int sockfd;

    #ifdef __WIN32__
        versionWanted = MAKEWORD(1, 1);
        err = WSAStartup(versionWanted, &wsaData);
        assert_message( (err == 0 ), "WSAStartup failed !");
    #endif

    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    assert_message(sockfd != -1, "Cannot initialize socket");
    packet->sockfd = sockfd;
}

void initialize_hostname(udp_packet* packet, char* h){
    packet->hostname = h;
    packet->hostinfo = gethostbyname(h);
    assert_message( packet->hostinfo != NULL, "Unknown hos hostname");
}

void initialize_sockaddr_in(udp_packet* packet, int port){
    #ifdef __WIN32__
        int tmp_windows;
    #endif
    struct sockaddr_in receiver_st;

    memset( (char *) &receiver_st, 0, sizeof(receiver_st) );

    receiver_st.sin_family = AF_INET;
    receiver_st.sin_port = htons(port);

    #ifdef __WIN32__
        tmp_windows = inet_addr(packet->hostname);
        assert_message( tmp_windows != -1, "inet_addr() error");
        receiver_st.sin_addr.s_addr = tmp_windows;
    #else
        memcpy(&receiver_st.sin_addr, packet->hostinfo->h_addr, packet->hostinfo->h_length);
    #endif

    packet->receiver = &receiver_st;
}

void close_socket(udp_packet* packet) {
    #ifdef __WIN32__
        WSACleanup();
    #endif

    closesocket(packet->sockfd);
}


void initialize(udp_packet* packet, char* hostname, int port){
    initialize_socket(packet);
    initialize_hostname(packet, hostname);
    initialize_sockaddr_in(packet, port);
}


void send_packet(udp_packet* packet, char* message) {
    int sendto_check;
    struct sockaddr_in receiver_st;

    receiver_st = *(packet->receiver);
    printf("%s\n", message);
    sendto_check = sendto(packet->sockfd, message, strlen(message), 0, (struct sockaddr *)&receiver_st, (socklen_t) sizeof(receiver_st) );
    assert_message((sendto_check != -1), "sendto() error ");
}

void clear(udp_packet* packet){
    close_socket(packet);
    printf("Close socket ok\n");
}
