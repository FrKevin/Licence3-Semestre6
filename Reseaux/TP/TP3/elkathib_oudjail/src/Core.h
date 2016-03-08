/*!
  \file common.h
  \author Oudjail & El Kathib
  \date 2016
  \brief define and debug's methodes && define type of project
*/

#ifndef __CORE_H__
#define __CORE_H__


/*!
    \brief Check error and print this
    \param cond the condition to abort
    \param message the message
*/
void assert_message(cond, char *message);


/*!
  \brief List of type used : [byte]
*/
typedef unsigned char byte_t;
typedef uint16_t id_t;




#endif
