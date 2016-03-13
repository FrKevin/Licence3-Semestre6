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

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h> /* close */

#include "common.h"
#include "udp_packet.h"

void initialize_socket(udp_packet* packet){
    #ifdef __WIN32__
        int err;
        WORD versionWanted;
        WSADATA wsaData;
    #endif
    int sockfd;

    #ifdef __WIN32__
        versionWanted = MAKEWORD(2, 2);
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

void initialize_sockaddr_in(udp_packet* packet, short sin_family, int port, long addr){
    #ifdef __WIN32__
        unsigned long int tmp_windows;
    #endif
    static struct sockaddr_in receiver_st;

    memset( (char *) &receiver_st, 0, sizeof(receiver_st) );

    receiver_st.sin_family = sin_family;
    receiver_st.sin_port = htons(port);
    if(addr == -1 ){
        #ifdef __WIN32__
            tmp_windows = inet_addr(packet->hostname);
            assert_message( tmp_windows != -1, "inet_addr() error");
            receiver_st.sin_addr.s_addr = tmp_windows;
        #else
            memcpy(&receiver_st.sin_addr, packet->hostinfo->h_addr, packet->hostinfo->h_length);
        #endif
    }
    else{
        receiver_st.sin_addr.s_addr = (unsigned long) addr;
    }

    packet->receiver = &receiver_st;
}

void close_socket(udp_packet* packet) {
    #ifdef __WIN32__
        WSACleanup();
    #endif

    closesocket(packet->sockfd);
    send_verbose_message("The socket is closed.");
}
