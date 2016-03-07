/*!
    \file question.h
    \author Kevin Gamelin
    \date 2016
    \brief Define a question in  DNS packet
*/
#ifndef _question_H_
#define _question_H_

/*!
    \def MAXQUESTIONS
    \brief Max question at DNS packet
*/
#define MAXQUESTIONS      255

/*!
    \enum type
    \brief TYPE fields are used in resource records.  Note that these types are a
            subset of QTYPEs.
*/
enum type
{
    A=      1,  /*!<    1 a host address                                        */
    NS=     2,  /*!<    2 an authoritative name server                          */
    MD=     3,  /*!<    3 a mail destination (Obsolete - use MX)                */
    MF=     4,  /*!<    4 a mail forwarder (Obsolete - use MX)                  */
    CNAME=  5,  /*!<    5 the canonical name for an alias                       */
    SOA=    6,  /*!<    6 marks the start of a zone of authority                */
    MB=     7,  /*!<    7 a mailbox domain name (EXPERIMENTAL)                  */
    MG=     8,  /*!<    8 a mail group member (EXPERIMENTAL)                    */
    MR=     9,  /*!<    9 a mail rename domain name (EXPERIMENTAL)              */
    NONE=   10, /*!<    10 a null RR (EXPERIMENTAL)                             */
    WKS=    11, /*!<    11 a well known service description                     */
    PTR=    12, /*!<    12 a domain name pointer                                */
    HINFO=  13, /*!<    13 host information                                     */
    MINFO=  14, /*!<    14 mailbox or mail list information                     */
    MX=     15, /*!<    15 mail exchange                                        */
    TXT=    16, /*!<    16 text strings                                         */
    AXFR=   252,/*!<    252 A request for a transfer of an entire zone          */
    MAILB=  253,/*!<    253 A request for mailbox-related records (MB, MG or MR)*/
    MAILA=  254,/*!<    254 A request for mail agent RRs (Obsolete - see MX)    */
    ALL=    255 /*!<    255 A request for all records                           */
};
/*! \brief Create a q_types type */
typedef enum type q_types;

/*!
    \brief This is an enum class fields appear in resource records.
*/
enum class {
    IN=      1,  /*!<   1 the Internet                                                              */
    CS=      2,  /*!<   2 the CSNET class (Obsolete - used only for examples insome obsolete RFCs)  */
    CH=      3,  /*!<   3 the CHAOS class                                                           */
    HS=      4   /*!<   4 Hesiod [Dyer 87]                                                          */
};
/*! \brief Create a q_class type */
typedef enum class q_class;

/*!
 * \struct st_question
 * \brief A representation of question
 */
struct st_question {
    char* name;     /*!< An owner name, i.e., the name of the node to which this resource record pertains */
    q_types type;   /*!< two octets containing one of the RR TYPE codes.                                  */
    q_class class;  /*!< two octets containing one of the RR CLASS codes.                                 */
};
/*! \brief Create a question type */
typedef struct st_question question;

/*!
    \brief Set a name for question
    \param index The index of array
    \param name A name
*/
extern void set_name(int index, char* name);

/*!
    \brief get a name for question n°index
    \param index The index of array
*/
extern char* get_name(int index);

/*!
    \brief Set a type for question
    \param index The index of array
    \param t A question's type
*/
extern void set_type(int index, q_types t);

/*!
    \brief get a type for question n°index
    \param index The index of array
*/
extern q_types get_type(int index);

/*!
    \brief Set a class for question
    \param index The index of array
    \param c class of question
*/
extern void set_class(int index, q_class c);

/*!
    \brief get a class for question n°index
    \param index The index of array
*/
extern q_class get_class(int index);


/*!
    \brief add question in a packet
    \param name A name for question
    \param type A type for question
    \param class A class for question
*/
extern void add_question(char* name, q_types type, q_class class);

/*!
    \brief Return a size of questions
*/
extern unsigned int get_index_question();


#endif
