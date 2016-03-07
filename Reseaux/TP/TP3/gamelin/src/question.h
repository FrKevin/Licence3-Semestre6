/*!
    \file DNSPacket.h
    \brief Définie une question DNS
*/
#ifndef _question_H_
#define _question_H_

/*!
    \brief
        TYPE fields are used in resource records.  Note that these types are a
        subset of QTYPEs.
*/
enum type
{
    A=      1,  /*\brief    1 a host address                                        */
    NS=     2,  /*\brief    2 an authoritative name server                          */
    MD=     3,  /*\brief    3 a mail destination (Obsolete - use MX)                */
    MF=     4,  /*\brief    4 a mail forwarder (Obsolete - use MX)                  */
    CNAME=  5,  /*\brief    5 the canonical name for an alias                       */
    SOA=    6,  /*\brief    6 marks the start of a zone of authority                */
    MB=     7,  /*\brief    7 a mailbox domain name (EXPERIMENTAL)                  */
    MG=     8,  /*\brief    8 a mail group member (EXPERIMENTAL)                    */
    MR=     9,  /*\brief    9 a mail rename domain name (EXPERIMENTAL)              */
    NONE=   10, /*\brief    10 a null RR (EXPERIMENTAL)                             */
    WKS=    11, /*\brief    11 a well known service description                     */
    PTR=    12, /*\brief    12 a domain name pointer                                */
    HINFO=  13, /*\brief    13 host information                                     */
    MINFO=  14, /*\brief    14 mailbox or mail list information                     */
    MX=     15, /*\brief    15 mail exchange                                        */
    TXT=    16, /*\brief    16 text strings                                         */
    AXFR=   252,/*\brief    252 A request for a transfer of an entire zone          */
    MAILB=  253,/*\brief    253 A request for mailbox-related records (MB, MG or MR)*/
    MAILA=  254,/*\brief    254 A request for mail agent RRs (Obsolete - see MX)    */
    ALL=    255 /*\brief    255 A request for all records                           */
};
typedef enum type q_types;

/*
    \brief CLASS fields appear in resource records.
*/
enum class
{
    IN=      1,  /*\brief   1 the Internet                                                              */
    CS=      2,  /*\brief   2 the CSNET class (Obsolete - used only for examples insome obsolete RFCs)  */
    CH=      3,  /*\brief   3 the CHAOS class                                                           */
    HS=      4   /*\brief   4 Hesiod [Dyer 87]                                                          */
};
typedef enum class q_class;


struct st_question {
    char* name;     /*! \brief An owner name, i.e., the name of the node to which this resource record pertains */
    q_types type;   /*! \brief two octets containing one of the RR TYPE codes.                                  */
    q_class class;  /*! \brief two octets containing one of the RR CLASS codes.                                 */
};
typedef struct st_question question;

/*
    \brief Set a name for question
*/
extern void set_name(int index, char* name);

/*
    \brief get a name for question n°index
*/
extern char* get_name(int index);

/*
    \brief Set a type for question
*/
extern void set_type(int index, q_types t);

/*
    \brief get a type for question n°index
*/
extern q_types get_type(int index);

/*
    \brief Set a class for question
*/
extern void set_class(int index, q_class c);

/*
    \brief get a class for question n°index
*/
extern q_class get_class(int index);


/*!
    \brief add question in a packet
*/
extern void add_question(char* name, q_types type, q_class class);

/*!
    \brief Return a size of questions
*/
extern unsigned int get_index_question();

#endif
