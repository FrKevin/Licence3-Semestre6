/*!
    \file udp_packet.h
    \author Kevin Gamelin
    \date 2016
    \brief Define udp packet
*/
#ifndef _udp_packet_H_
#define _udp_packet_H_


#ifdef __WIN32__
    typedef int socklen_t;
#endif

/*!
    \def h_addr
    \brief This is a synonym for h_addr_list[0]; in other words, it is the first host address. (compatibility)
*/
#define h_addr h_addr_list[0]

/*!
    \def closesocket
    \brief For windows compatibility
*/
#define closesocket(s) close(s)

/*!
    \brief Create a structure in order to send an udp packet
*/
typedef struct udp_packet_st {
   int  sockfd; /*!< The socket id */
   char* hostname; /*!< The hostname */
   struct hostent *hostinfo; /*!< The structure contains many informations of hostname */
   struct sockaddr_in *receiver; /*!< The structure represent the receiver */
} udp_packet;


extern void initialize_udp_packet(udp_packet* packet, char* hostname, int port);

/*!
\brief Send UDP packet
\param packet The udp_packet structure
\param message The message to send
*/
extern void send_packet(udp_packet* packet, int size, char* message);

/*!
  \brief receive UDP packet
  \param packet The udp_packet structure
  \param message The message to send
*/
extern void receive_packet(udp_packet* packet, char buffer[], int sizeof_buffer);

/*!
    \brief close socket
    \param packet The UDP packet
*/
extern void close_socket(udp_packet* packet);

#endif
