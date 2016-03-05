/*!
    \file Packet.h
    \brief Définie un paquet DNS
*/
#ifndef _DNSPacket_H_
#define _DNSPacket_H_

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
unsigned char qr[1];

/*!
    \brief
        A four bit field that specifies kind of query in this
        message.  This value is set by the originator of a query
        and copied into the response.  The values are:
            0               a standard query (QUERY)
            1               an inverse query (IQUERY)
            2               a server status request (STATUS)
            3-15            reserved for future use
*/
unsigned char op_code[4];

/*
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
unsigned char authoritative_answer[1];

/*
    \brief
        TrunCation - specifies that this message was truncated
        due to length greater than that permitted on the
        transmission channel.
*/
unsigned char tc[1];

/*
    \brief
        Recursion Desired - this bit may be set in a query and
        is copied into the response.  If RD is set, it directs
        the name server to pursue the query recursively.
        Recursive query support is optional.
*/
unsigned char recursion_desired[1];

/*
    \brief
        Only for answer.
        Recursion Available - this be is set or cleared in a
        response, and denotes whether recursive query support is
        available in the name server.
*/
unsigned char recursion_available[1];

/*
    \brief
        Reserved for future use.  Must be zero in all queries
        and responses.
*/
unsigned char reserved[3] = {0x00, 0x00, 0x00};

/*
    \brief
        Only for answer.
        Response code - this 4 bit field is set as part of
        responses.  The values have the following interpretation:
            0               No error condition

            1               Format error - The name server was
                            unable to interpret the query.

            2               Server failure - The name server was
                            unable to process this query due to a
                            problem with the name server.

            3               Name Error - Meaningful only for
                            responses from an authoritative name
                            server, this code signifies that the
                            domain name referenced in the query does
                            not exist.

            4               Not Implemented - The name server does
                            not support the requested kind of query.

            5               Refused - The name server refuses to
                            perform the specified operation for
                            policy reasons.  For example, a name
                            server may not wish to provide the
                            information to the particular requester,
                            or a name server may not wish to perform
                            a particular operation (e.g., zone transfer) for particular data.

            6-15            Reserved for future use.
*/
unsigned char r_code[4];

/*
    \brief
        an unsigned 16 bit integer specifying the number of
        entries in the question section.
*/
unsigned char qd_cound[16];

/*
    \brief
        an unsigned 16 bit integer specifying the number of
        resource records in the answer section.
*/
unsigned char an_count[16];

/*
    \brief
        an unsigned 16 bit integer specifying the number of name
        server resource records in the authority records
        section.
*/
unsigned char ns_count[16];

/*
    \brief
        an unsigned 16 bit integer specifying the number of
        resource records in the additional records section.
*/
unsigned char ar_count[16];


#endif
