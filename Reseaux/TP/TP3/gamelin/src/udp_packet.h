/*!
    \file udp_packet.h
    \author Kevin Gamelin
    \date 2016
    \brief Define udp packet
*/
#ifndef _udp_packet_H_
#define _udp_packet_H_


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

/*!
    \brief initialize_socket for udp_packet
    \brief packet The UDP packet
*/
extern void initialize_socket(udp_packet* packet);

/*!
    \brief initialize hostname for udp_packet
    \param packet The UDP packet
    \brief hostname The receiver hostname
*/
extern void initialize_hostname(udp_packet* packet, char* hostname);

/*!
    \brief initialize sockaddr_in for udp_packet
    \param packet The UDP packet
    \param hostname The receiver hostname
    \param sin_family address family, must be AF_INET
    \param addr The addresse of receiver, use -1 is unknown
*/
extern void initialize_sockaddr_in(udp_packet* packet, short sin_family, int port, long addr);

/*!
    \brief close socket
    \param packet The UDP packet
*/
extern void close_socket(udp_packet* packet);

#endif
