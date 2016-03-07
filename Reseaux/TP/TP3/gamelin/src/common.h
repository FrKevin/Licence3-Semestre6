/*!
  \file common.h
  \author Kevin Gamelin
  \date 2016
  \brief define and debug's methodes
*/

#ifndef _COMMON_H_
#define _COMMON_H_

/*!
    brief Check error and print this
    \param cond the condition to abort
    \param message the message
*/
extern void assert_message(int cond, char* message);

/*!
    \brief
        Convert integer to string
        Converts an integer value to a null-terminated string using the specified base and stores the result in the array given by str parameter.
        If base is 10 and value is negative, the resulting string is preceded with a minus sign (-). With any other base, value is always considered unsigned.
    \param value the integer value
    \param str the buffer
    \param radix the base
*/
extern char* itoa(int value, char* str, int radix);

/*!
    \brief Put Array of unisgned char to a single (unsigned) char
    \param bits[] the bits array
*/
extern unsigned char toByte(unsigned char bits[]);

/*!
    \brief Convert Domaine to label sequences
    \param domaine_name[] the domaine name
    \param byts[]  the result
    \return the offset of byts array
*/
extern int convert_donmaine_name_to_label(char domaine_name[], char byts[]);

#endif
