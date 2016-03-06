/*!
    \file Packet.h
    \brief Définie un paquet DNS
*/
#ifndef _packet_H_
#define _packet_H_

enum type_of_request
{
    QUERY=      0x0,    /*\brief   0 a standard query (QUERY)         */
    IQUERY=     0x1,    /*\brief   1 an inverse query (IQUERY)        */
    STATUS=     0x1     /*\brief   2 server status request (STATUS)    */
};
typedef enum type_of_request type_of_request;


enum response_code
{
    /*\brief 0 No error condition*/
    NO_ERROR= 0x0,
    /*\brief  Format error - The name server was unable to interpret the query. */
    FORMAT_ERROR= 0x1,
    /*\brief
        Server failure - The name server was
        unable to process this query due to a
        problem with the name server.
    */
    SERVER_FAILURE= 0x2,
    /*\brief
        Name Error - Meaningful only for
        responses from an authoritative name
        server, this code signifies that the
        domain name referenced in the query does
        not exist.
    */
    NAME_ERROR= 0x3,
    /*\brief Not Implemented - The name server does not support the requested kind of query.*/
    NOT_IMPLEMENTED= 0x4,
    /*\brief
        Refused - The name server refuses to
        perform the specified operation for
        policy reasons.  For example, a name
        server may not wish to provide the
        information to the particular requester,
        or a name server may not wish to perform
        a particular operation (e.g., zone transfer) for particular data.
    */
    REFUSED= 0x5,
    /*\brief  Answer only */
    UNDEFINED= 255
};
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
*/
extern void set_id(unsigned char b1, unsigned char b2);

/*!
    \brief Set type: Answer or response
*/
extern void set_qerry_type(unsigned char type);

/*!
    \brief Set type
*/
extern void set_op_code(type_of_request op);

/*!
    \brief Set type
*/
extern void set_authoritative_answer(unsigned char aa);

/*!
    \brief  Set TrunCation
*/
extern void set_truncated(unsigned char t);

/*!
    \brief  Set recursion_desired
*/
extern void set_recursion_desired(unsigned char rd);

/*!
    \brief  Set recursion_available
*/
extern void set_recursion_available(unsigned char ra);

/*!
    \brief Crate a simple query
*/
extern void create_simple_query();

/*!
    \brief Create a byte array width an query
*/
unsigned char*  get_bytes_query();

#endif
