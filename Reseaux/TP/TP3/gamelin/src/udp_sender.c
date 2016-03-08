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

void initialize_socket(){
  #ifdef __WIN32__
    WORD versionWanted = MAKEWORD(1, 1);
    WSADATA wsaData;
    err = WSAStartup(versionWanted, &wsaData);
    assert_message( (err > 0 ), "WSAStartup failed !");
  #endif

  sockfd = socket(AF_INET, SOCK_DGRAM, 0);
  assert_message(sockfd != -1, "Cannot initialize socket");
}

void initialize_hostname(char* hostname){
  hostinfo = gethostbyname(hostname);
  assert_message( hostinfo != NULL, "Unknown hos hostname");
}

void initialize_sockaddr_in(int port){
  memset((char *) &receiver, 0, sizeof(receiver));
  receiver.sin_family = AF_INET;
  receiver.sin_port = htons(port);

  #ifdef __WIN32__
    int tmp_windows;
    tmp_windows = inet_addr(receiver->h_name);
    assert_message( tmp_windows != -1, "inet_addr() error")
    receiver.sin_addr.s_addr = tmp_windows;
  #else
    memcpy(&receiver.sin_addr, hostinfo->h_addr, hostinfo->h_length);
  #endif
}

void close_socket() {
  #ifdef __WIN32__
    WSACleanup();
  #endif

  closesocket(sockfd);
}


void send_packet(char* hostname, int port, char* message) {
  int sendto_check;

  printf("begin initialize_socket()\n");
  initialize_socket();
  printf("end initialize_socket()\n");

  printf("begin initialize_hostname()\n");
  initialize_hostname(hostname);
  printf("end initialize_hostname()\n");

  printf("begin initialize_sockaddr_in()\n");
  initialize_sockaddr_in(port);
  printf("end initialize_sockaddr_in()\n");

  printf("en cours d'envoie du message.\n");
  sendto_check = sendto(sockfd, message, strlen(message), 0, (sockaddr *)&receiver, (socklen_t) sizeof(receiver));

  assert_message((sendto_check > 0), "sendto() error ");
  printf("Envoi ok\n");

  printf("Begin close_socket()\n");
  close_socket();
  printf("end close_socket()\n");
}
