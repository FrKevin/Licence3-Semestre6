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
    REFUSED= 0x5, /*!<
        Refused - The name server refuses to
        perform the specified operation for
        policy reasons.  For example, a name
        server may not wish to provide the
        information to the particular requester,
        or a name server may not wish to perform
        a particular operation (e.g., zone transfer) for particular data.
    */
    UNDEFINED= 255 /*!<  Answer only */
};
/*! \brief Create a  response_code type */
typedef enum response_code response_code;

/*!
    \brief
        A 16 bit identifier assigned by the program that
        generates any kind of query.  This identifier is copied
        the corresponding reply and can be used by the requester
        to match up replies to outstanding queries.
*/
unsigned char id[2];

/*!
    \brief
        A one bit field that specifies whether this message is a
        query (0), or a response (1).
*/
unsigned char qr;

/*!
    \brief
        A four bit field that specifies kind of query in this
        message.  This value is set by the originator of a query
        and copied into the response.
*/
type_of_request op_code;

/*!
    \brief
    Only for answer.
    Authoritative Answer - this bit is valid in responses,
    and specifies that the responding name server is an
    authority for the domain name in question section.

    Note that the contents of the answer section may have
    multiple owner names because of aliases.  The AA bit
    corresponds to the name which matches the query name, or
    the first owner name in the answer section.
*/
unsigned char authoritative_answer;

/*!
    \brief
        TrunCation - specifies that this message was truncated
        due to length greater than that permitted on the
        transmission channel.
*/
unsigned char tc;

/*!
    \brief
        Recursion Desired - this bit may be set in a query and
        is copied into the response.  If RD is set, it directs
        the name server to pursue the query recursively.
        Recursive query support is optional.
*/
unsigned char recursion_desired;

/*!
    \brief
        Only for answer.
        Recursion Available - this be is set or cleared in a
        response, and denotes whether recursive query support is
        available in the name server.
*/
unsigned char recursion_available;

/*!
    \brief
        Reserved for future use.  Must be zero in all queries
        and responses.
*/
unsigned char reserved[3];

/*!
    \brief
        Only for answer.
        Response code - this 4 bit field is set as part of
        responses.
*/
response_code r_code;

/*!
    \brief
        an unsigned 16 bit integer specifying the number of
        resource records in the answer section.
*/
unsigned int an_count;

/*!
    \brief
        an unsigned 16 bit integer specifying the number of name
        server resource records in the authority records
        section.
*/
unsigned int ns_count;

/*!
    \brief
        an unsigned 16 bit integer specifying the number of
        resource records in the additional records section.
*/
unsigned int ar_count;

/*!
    \brief Initialize packet
*/
extern void init();

/*!
    \brief Set an id
    \param b1 the first identifier's octet
    \param b2 the first identifier's octet
*/
extern void set_id(unsigned char b1, unsigned char b2);

/*!
    \brief Set type: Answer or response
    \param type the type of querry.\n
        Must be 1 (for query) or 0 (for answer)
*/
extern void set_qerry_type(unsigned char type);

/*!
    \brief Set op_code
    \param op the type of request.
*/
extern void set_op_code(type_of_request op);

/*!
    \brief Set authoritative_answer
    \param aa the authoritative answer, only if the type of packet is answer
*/
extern void set_authoritative_answer(unsigned char aa);

/*!
    \brief  Set truncated
    \param t  the truncated mode.\n
        Must be 1 or 0
*/
extern void set_truncated(unsigned char t);

/*!
    \brief  Set recursion_desired
    \param rd the recursion desired mode.\n
        Must be 1 or 0
*/
extern void set_recursion_desired(unsigned char rd);

/*!
    \brief  Set recursion_available
    \param ra the recursion available of packet, only if the type of packet is answer
*/
extern void set_recursion_available(unsigned char ra);

/*!
    \brief Crate a simple query
*/
extern void create_simple_query();

/*!
    \brief Create a byte array width an query
*/
unsigned char* get_bytes_query();

#endif
