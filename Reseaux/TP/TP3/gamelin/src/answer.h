/*!
    \file answer.h
    \author Kevin Gamelin
    \date 2016
    \brief Define a answer in  DNS packet
*/
#ifndef _answer_H_
#define _answer_H_

#include "question.h"

#if !defined(PATH_MAX)
  /*!
    \def PATH_MAX
    \brief  compatibility for windows
  */
  #define PATH_MAX        4096
#endif


/*!
 * \struct st_answer
 * \brief A representation of answer
 */
struct st_answer {
    char* name;     /*!< An owner name, i.e., the name of the node to which this resource record pertains */
    q_types type;   /*!< two octets containing one of the RR TYPE codes.                                  */
    q_class class;  /*!< two octets containing one of the RR CLASS codes.                                 */
    unsigned int ttl;  /*!< a 32 bit unsigned integer that specifies the time
                interval (in seconds) that the resource record may be
                cached before it should be discarded.  Zero values are
                interpreted to mean that the RR can only be used for the
                transaction in progress, and should not be cached.                                         */
    int rd_length; /*!< an unsigned 16 bit integer that specifies the length in
                octets of the RDATA field.                                                                 */
    int rdata[PATH_MAX];/*!< a variable length string of octets that describes the
                resource.  The format of this information varies
                according to the TYPE and CLASS of the resource record.
                For example, the if the TYPE is A and the CLASS is IN,
                the RDATA field is a 4 octet ARPA Internet address.                                        */
};

/*! \brief Create a answer type */
typedef struct st_answer answer;

/*!
    \brief Display an answer
    \param a the answer to display
*/
extern void display_answer(answer* a);

#endif
