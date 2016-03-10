/*!
    \file udp_sender.h
    \author Kevin Gamelin
    \date 2016
    \brief Send UDP packet
*/

#ifndef _question_H_
#define _question_H_

/*!
    \def h_addr
    \brief This is a synonym for h_addr_list[0]; in other words, it is the first host address. (compatibility)
*/
#define h_addr h_addr_list[0] /* */

/*!
    \def closesocket
    \brief For windows compatibility
*/
#define closesocket(s) close(s)

#ifdef __WIN32__
    typedef int socklen_t;
#endif


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
    \brief clear all entry in the structure
    \param packet The udp_packet structure
    \param hostname The hostname where send upd packet
    \param port The port
*/
extern void initialize(udp_packet* packet, char* hostname, int port);

/*!
    \brief clear all entry in the structure
    \param packet The udp_packet structure
*/
extern void clear(udp_packet* packet);

/*!
  \brief Send UDP packet
  \param packet The udp_packet structure
  \param message The message to send
*/
extern void send_packet(udp_packet* packet, int size, char* message);

#endif
