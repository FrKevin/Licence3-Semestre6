/*! \mainpage  TP 3: Reseaux

 \section intro_sec Introduction
    This project was created in order to create and decrypt an DNS Packet

 \section overview Overview
     The goal of domain names is to provide a mechanism for naming resources
     in such a way that the names are usable in different hosts, networks,
     protocol families, internets, and administrative organizations.
     From the user's point of view, domain names are useful as arguments to a
     local agent, called a resolver, which retrieves information associated
     with the domain name.

 \section format The format of DNS Packet
     All communications inside of the domain protocol are carried in a single
     format called a message.  The top level format of message is divided
     into 5 sections (some of which are empty in certain cases) shown below:
     \verbatim
         +---------------------+
         |        Header       |
         +---------------------+
         |       Question      | the question for the name server
         +---------------------+
         |        Answer       | RRs answering the question
         +---------------------+
         |      Authority      | RRs pointing toward an authority
         +---------------------+
         |      Additional     | RRs holding additional information
         +---------------------+
     \endverbatim

     \subsection header The header
        The header contains the following fields:
        \verbatim
              0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
            |                      ID                       |
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
            |QR|   Opcode  |AA|TC|RD|RA|   Z    |   RCODE   |
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
            |                    QDCOUNT                    |
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
            |                    ANCOUNT                    |
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
            |                    NSCOUNT                    |
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
            |                    ARCOUNT                    |
            +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

            where:
            ID              A 16 bit identifier assigned by the program that
                            generates any kind of query.  This identifier is copied
                            the corresponding reply and can be used by the requester
                            to match up replies to outstanding queries.

            QR              A one bit field that specifies whether this message is a
                            query (0), or a response (1).

            OPCODE          A four bit field that specifies kind of query in this
                            message.  This value is set by the originator of a query
                            and copied into the response.  The values are:

                            0               a standard query (QUERY)

                            1               an inverse query (IQUERY)

                            2               a server status request (STATUS)

                            3-15            reserved for future use

            AA              Authoritative Answer - this bit is valid in responses,
                            and specifies that the responding name server is an
                            authority for the domain name in question section.

                            Note that the contents of the answer section may have
                            multiple owner names because of aliases.  The AA bit
                            corresponds to the name which matches the query name, or
                            the first owner name in the answer section.

            TC              TrunCation - specifies that this message was truncated
                            due to length greater than that permitted on the
                            transmission channel.

            RD              Recursion Desired - this bit may be set in a query and
                            is copied into the response.  If RD is set, it directs
                            the name server to pursue the query recursively.
                            Recursive query support is optional.

            RA              Recursion Available - this be is set or cleared in a
                            response, and denotes whether recursive query support is
                            available in the name server.

            Z               Reserved for future use.  Must be zero in all queries
                            and responses.

            RCODE           Response code - this 4 bit field is set as part of
                            responses.  The values have the following
                            interpretation:

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
                                            a particular operation (e.g., zone transfer)
                                             for particular data.

                            6-15            Reserved for future use.

            QDCOUNT         an unsigned 16 bit integer specifying the number of
                            entries in the question section.

            ANCOUNT         an unsigned 16 bit integer specifying the number of
                            resource records in the answer section.

            NSCOUNT         an unsigned 16 bit integer specifying the number of name
                            server resource records in the authority records
                            section.

            ARCOUNT         an unsigned 16 bit integer specifying the number of
                            resource records in the additional records section.
        \endverbatim

        \subsection question The question
            The question section is used to carry the "question" in most queries,
            i.e., the parameters that define what is being asked.  The section
            contains QDCOUNT (usually 1) entries, each of the following format:
            \verbatim
                 0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                                               |
                /                     QNAME                     /
                /                                               /
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                     QTYPE                     |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                     QCLASS                    |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

            where:
                QNAME       a domain name represented as a sequence of labels, where
                            each label consists of a length octet followed by that
                            number of octets.  The domain name terminates with the
                            zero length octet for the null label of the root.  Note
                            that this field may be an odd number of octets; no
                            padding is used.

                QTYPE       a two octet code which specifies the type of the query.
                            The values for this field include all codes valid for a
                            TYPE field, together with some more general codes which
                            can match more than one type of RR.

                QCLASS      A two octet code that specifies the class of the query.
                            For example, the QCLASS field is IN for the Internet.
            \endverbatim

        \subsection answer The Answer
            The answer, authority, and additional sections all share the same
            format: a variable number of resource records, where the number of
            records is specified in the corresponding count field in the header.
            Each resource record has the following format:
            \verbatim
                 0  1  2  3  4  5  6  7  8  9  0  1  2  3  4  5
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                                               |
                /                                               /
                /                      NAME                     /
                |                                               |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                      TYPE                     |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                     CLASS                     |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                      TTL                      |
                |                                               |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
                |                   RDLENGTH                    |
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--|
                /                     RDATA                     /
                /                                               /
                +--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+

                where:

                NAME        a domain name to which this resource record pertains.

                TYPE        two octets containing one of the RR type codes.  This
                            field specifies the meaning of the data in the RDATA
                            field.

                CLASS       two octets which specify the class of the data in the
                            RDATA field.

                TTL         a 32 bit unsigned integer that specifies the time
                            interval (in seconds) that the resource record may be
                            cached before it should be discarded.  Zero values are
                            interpreted to mean that the RR can only be used for the
                            transaction in progress, and should not be cached.

                RDLENGTH    an unsigned 16 bit integer that specifies the length in
                            octets of the RDATA field.

                RDATA       a variable length string of octets that describes the
                            resource.  The format of this information varies
                            according to the TYPE and CLASS of the resource record.
                            For example, the if the TYPE is A and the CLASS is IN,
                            the RDATA field is a 4 octet ARPA Internet address.
            \endverbatim
*/
