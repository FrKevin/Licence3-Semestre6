/*!
  \file common.h
  \author Oudjail & El Khatib
  \date 2016
  \brief define and debug's methodes && define type of project
*/

#ifndef __CORE_H__
#define __CORE_H__


/*!
  \brief List of type used : [byte]
*/
typedef unsigned char byte_t;
typedef uint16_t id_t;



/*!
  \brief Implentation for boolean
*/
typedef enum { false, true } bool;

/*!
    \brief Check error and print this
    \param cond the condition to abort
    \param message the message
*/
extern void assert_message(cond, char *message);

extern id_t generate_id();

extern int MAX_VALUE(int nbit);


#endif
