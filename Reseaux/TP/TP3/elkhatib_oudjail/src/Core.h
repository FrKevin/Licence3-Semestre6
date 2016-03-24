/*!
  \file Core.h
  \author Oudjail & El Khatib
  \date 2016
  \brief define and debug's methodes && define type of project
*/

#ifndef __CORE_H__
#define __CORE_H__

#include <stdint.h>
#include <stddef.h>


#define MAX_U16INT 65535

/*!
  \brief List of type used : [byte]
*/
typedef unsigned char byte_t;

/*!
  \brief Implentation for boolean
*/
typedef enum { false, true } bool;

/*!
    \brief Check error and print this
    \param cond the condition to abort
    \param message the message
*/


extern void assert_message(int cond, char *message);

extern uint16_t generate_uint16();

extern int MAX_VALUE(int nbit);

extern void insert_uint16(byte_t bytes[], size_t index, uint16_t n);

extern void insert_inf_uint8(byte_t bytes[], size_t index, byte_t n, int nshift);

#endif
