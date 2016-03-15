/*!
  \file common.h
  \author Kevin Gamelin
  \date 2016
  \brief define and debug's methodes
*/

#ifndef _COMMON_H_
#define _COMMON_H_

#ifdef __WIN32__
    #define errno_windows WSAGetLastError()
#endif

/*!
  \def MAXCMDS
  \brief le nombre max de commandes possibles pour les pipes
*/
#define MAXCMDS    10

/*!
  \def ANSI_COLOR_BLACK
  \brief color: black
*/
#define ANSI_COLOR_BLACK        "\033[30m"

/*!
  \def ANSI_COLOR_RED
  \brief color: red
*/
#define ANSI_COLOR_RED          "\033[31m"

/*!
  \def ANSI_COLOR_GREEN
  \brief color: green
*/
#define ANSI_COLOR_GREEN        "\033[32m"

/*!
  \def ANSI_COLOR_YELLOW
  \brief color: yellow
*/
#define ANSI_COLOR_YELLOW       "\033[33m"

/*!
  \def ANSI_COLOR_BLUE
  \brief color: blue
*/
#define ANSI_COLOR_BLUE         "\033[34m"

/*!
  \def ANSI_COLOR_MAGENTA
  \brief color: magenta
*/
#define ANSI_COLOR_MAGENTA      "\033[35m"

/*!
  \def ANSI_COLOR_CYAN
  \brief color: cyan
*/
#define ANSI_COLOR_CYAN         "\033[36m"

/*!
  \def ANSI_COLOR_WHITE
  \brief color: white
*/
#define ANSI_COLOR_WHITE        "\033[37m"

/*!
  \def ANSI_COLOR_BOLDBLACK
  \brief Bold and black text
*/
#define ANSI_COLOR_BOLDBLACK    "\033[1m\033[30m"

/*!
  \def ANSI_COLOR_BOLDRED
  \brief  Bold and red text
*/
#define ANSI_COLOR_BOLDRED      "\033[1m\033[31m"

/*!
  \def ANSI_COLOR_BOLDGREEN
  \brief Bold and green text
*/
#define ANSI_COLOR_BOLDGREEN    "\033[1m\033[32m"

/*!
  \def ANSI_COLOR_BOLDYELLOW
  \brief Bold and yellow text
*/
#define ANSI_COLOR_BOLDYELLOW   "\033[1m\033[33m"

/*!
  \def ANSI_COLOR_BOLDBLUE
  \brief  Bold and blue text
*/
#define ANSI_COLOR_BOLDBLUE     "\033[1m\033[34m"

/*!
  \def ANSI_COLOR_BOLDMAGENTA
  \brief  Bold and magenta text
*/
#define ANSI_COLOR_BOLDMAGENTA  "\033[1m\033[35m"

/*!
  \def ANSI_COLOR_BOLDCYAN
  \brief Bold and cyan text
*/
#define ANSI_COLOR_BOLDCYAN     "\033[1m\033[36m"

/*!
  \def ANSI_COLOR_BOLDWHITE
  \brief Bold and white text
*/
#define ANSI_COLOR_BOLDWHITE    "\033[1m\033[37m"

/*!
  \def BOLD
  \brief Bold text
*/
#define BOLD "\033[00;01m"

/*!
  \def NORM
  \brief normal text
*/
#define NORM "\033[00;00m"

/*!
  \brief Verbose mode 1 to print all verbose message.
*/
int verbose;

/*!
    \brief Check error and print this
    \param cond the condition to abort
    \param message the message
*/
extern void assert_message(int cond, char* message);

/*!
    \brief Print a verbose message
    \param message the message
*/
extern void send_verbose_message(char* message);

/*!
    \brief
        Convert integer to binary
    \param value the integer value
    \param str the buffer
    \param radix the base
*/
extern void int_to_byte(unsigned int value, unsigned char buffer_byte[8]);

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
