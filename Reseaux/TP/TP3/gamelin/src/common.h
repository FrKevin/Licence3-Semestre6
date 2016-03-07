/*!
  \file common.h
  \brief define and debug's methodes
*/

#ifndef _COMMON_H_
#define _COMMON_H_

/*
    brief Check error and print this
*/
extern void assert_message(int cond, char* message);

/*!
    \brief
        Convert integer to string
        Converts an integer value to a null-terminated string using the specified base and stores the result in the array given by str parameter.
        If base is 10 and value is negative, the resulting string is preceded with a minus sign (-). With any other base, value is always considered unsigned.
*/
extern char* itoa(int value, char* str, int radix);

/*!
    \brief Put Array of unisgned char to a single (unsigned) char
*/
extern unsigned char toByte(unsigned char bits[]);

/*!
    \brief Convert Domaine to label sequences
    @return the offset of byts array
*/
extern int convert_donmaine_name_to_label(char domaine_name[], char byts[]);

#endif
