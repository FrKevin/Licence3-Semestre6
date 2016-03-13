/*!
    \file udp_sender.h
    \author Kevin Gamelin
    \date 2016
    \brief Send UDP packet
*/
#ifndef _question_H_
#define _question_H_


#ifdef __WIN32__
    typedef int socklen_t;
#endif


/*!
    \brief initialize the structure udp_packet in order to send.
    \param packet The udp_packet structure
    \param hostname The hostname where send upd packet
    \param port The port
*/
extern void initialize_sender(udp_packet* packet, char* hostname, int port);


/*!
  \brief Send UDP packet
  \param packet The udp_packet structure
  \param message The message to send
*/
extern void send_packet(udp_packet* packet, int size, char* message);

#endif
