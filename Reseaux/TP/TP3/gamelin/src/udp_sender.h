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

/*! \brief Create int_socket type */
typedef int int_socket;

/*! \brief Create a sockaddr_in type */
typedef struct sockaddr_in sockaddr_in;

/*! \brief Create a SOCKADDR type */
typedef struct sockaddr sockaddr;

/*! \brief Create a IN_ADDR type */
typedef struct in_addr in_addr;

#ifdef __WIN32__
    typedef int socklen_t;
#endif

/*!
  \brief The socket
*/
int_socket sockfd;

/*!
  \brief  The hostent struct
*/
struct hostent *hostinfo = NULL;

/*!
  \brief The receiver of paquet
*/
sockaddr_in receiver;

/*!
    \brief initialize a socket
*/
extern void initialize_socket();

/*!
    \brief The hostname
*/
char* hostname;

/*!
    \brief initialize hostinfo and conver the hostname to address IP
    \param hostname the receiver hostname
*/
extern void initialize_hostname(char* hostname);

/*!
  \brief initialize receiver
*/
extern void initialize_sockaddr_in(int port);

/*!
    \brief close socket
    \param sock socket id
*/
extern void close_socket();

/*!
  \brief Send UDP packet
*/
extern void send_packet(char* hostname, int port, char* message);

#endif
