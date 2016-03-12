/*!
    \file packet.h
    \author Kevin Gamelin
    \date 2016
    \brief Définie un paquet DNS
*/
#ifndef _packet_H_
#define _packet_H_

/*!
    \enum type_of_request
    \brief Enum of type of request
*/
enum type_of_request
{
    QUERY=      0x0,    /*!<   0 a standard query (QUERY)         */
    IQUERY=     0x1,    /*!<   1 an inverse query (IQUERY)        */
    STATUS=     0x2     /*!<  2 server status request (STATUS)   */
};
/*! \brief Create a  type_of_request type */
typedef enum type_of_request type_of_request;

/*!
    \enum response_code
    \brief Enum of response code
*/
enum response_code {
    NO_ERROR= 0x0,/*!< 0 No error condition*/
    FORMAT_ERROR= 0x1,/*!<  Format error - The name server was unable to interpret the query. */
    SERVER_FAILURE= 0x2, /*!<
            Server failure - The name server was
            unable to process this query due to a
            problem with the name server.
        */
    NAME_ERROR= 0x3, /*!<
            Name Error - Meaningful only for
            responses from an authoritative name
            server, this code signifies that the
            domain name referenced in the query does
            not exist.
        */
    NOT_IMPLEMENTED= 0x4, /*!< Not Implemented - The name server does not support the requested kind of query.*/
    REFUSED= 0x5 /*!<
        Refused - The name server refuses to
        perform the specified operation for
        policy reasons.  For example, a name
        server may not wish to provide the
        information to the particular requester,
        or a name server may not wish to perform
        a particular operation (e.g., zone transfer) for particular data.
    */
};
/*! \brief Create a  response_code type */
typedef enum response_code response_code;

struct st_dns_packet {
    unsigned char id[2]; /*!< A 16 bit identifier assigned by the program that
            generates any kind of query.  This identifier is copied
            the corresponding reply and can be used by the requester
            to match up replies to outstanding queries.
    */

    unsigned char is_answer; /*!< A one bit field that specifies whether this message is a
            query (0), or a response (1).
    */
    type_of_request op_code; /*!< A four bit field that specifies kind of query in this
            message.  This value is set by the originator of a query
            and copied into the response.
    */
    unsigned char authoritative_answer;     /*!< Only for answer.
            Authoritative Answer - this bit is valid in responses,
            and specifies that the responding name server is an
            authority for the domain name in question section.

            Note that the contents of the answer section may have
            multiple owner names because of aliases.  The AA bit
            corresponds to the name which matches the query name, or
            the first owner name in the answer section.
    */
    unsigned char truncated; /*!< TrunCation - specifies that this message was truncated
            due to length greater than that permitted on the
            transmission channel.
    */
    unsigned char recursion_desired; /*!< Recursion Desired - this bit may be set in a query and
            is copied into the response.  If RD is set, it directs
            the name server to pursue the query recursively.
            Recursive query support is optional.
    */
    unsigned char recursion_available; /*!< Only for answer.
            Recursion Available - this be is set or cleared in a
            response, and denotes whether recursive query support is
            available in the name server.
    */
    unsigned char reserved[3]; /*!< Reserved for future use.  Must be zero in all queries and responses. */
    response_code r_code; /*!< Only for answer.
            Response code - this 4 bit field is set as part of
            responses.
    */
    unsigned int an_count; /*!< an unsigned 16 bit integer specifying the number of
            resource records in the answer section.
    */
    unsigned int ns_count;/*!< an unsigned 16 bit integer specifying the number of name
            server resource records in the authority records
            section.
    */
    unsigned int ar_count; /*!< an unsigned 16 bit integer specifying the number of
            resource records in the additional records section.
    */
};
/*! \brief Create a question type */
typedef struct st_dns_packet dns_packet;

/*!
    \brief Crate a simple query
    \param packet The DNS packet
*/
extern void create_query(dns_packet* packet, char* hostname);

/*!
  \brief display the packet
  \param packet The DNS packet
*/
extern void display_packet(dns_packet* packet);

/*!
  \brief display the packet
  \param packet The DNS packet
  \param is_binary The format: 1 for binary, other for hexadeximal
*/
extern void display_packet_to_format(char* dns_query, int sizeof_query, int is_binary);

/*!
    \brief Create a byte array width an query
*/
extern int convert_dns_query_to_char(dns_packet* packet, char buffer[16384]);


#endif
