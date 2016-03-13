/*!
    \file udp_receiver.h
    \author Kevin Gamelin
    \date 2016
    \brief Send UDP packet
*/
#ifndef _udp_receiver_H_
#define _udp_receiver_H_

/*!
    \brief initialize the structure udp_packet in order to receive.
    \param packet The udp_packet structure
    \param port The port
*/
extern void initialize_receiver(udp_packet* packet, int port);

/*!
  \brief receive UDP packet
  \param packet The udp_packet structure
  \param message The message to send
*/
extern void receive_packet(udp_packet* packet, char buffer[], int sizeof_buffer);

#endif
