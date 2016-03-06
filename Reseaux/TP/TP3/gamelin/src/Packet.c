
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "common.h"
#include "question.h"
#include "packet.h"



void init(){
    reserved[0] = 0x00;
    reserved[1] = 0x00;
    reserved[2] = 0x00;
    r_code = UNDEFINED;
    an_count = 0;
    ns_count = 0;
    ar_count = 0;
}

void set_id(unsigned char b1, unsigned char b2){
    id[0] = b1;
    id[1] = b2;
}

void set_qerry_type(unsigned char type){
    assert_message( (type == 0 || type == 1), "Rrror: cannot set type of packet");
    qr = type;
}

void set_op_code(type_of_request op){
    op_code = op;
}

void set_authoritative_answer(unsigned char aa){
    assert_message(qr != 0, "The type of packet is not answer.");
    authoritative_answer = aa;
}

void set_truncated(unsigned char t){
    assert_message( (t == 0 || t == 1), "Error cannot set TrunCation");
    tc = t;
}

void set_recursion_desired(unsigned char rd){
    assert_message( (rd == 0 || rd == 1), "Error cannot set recursion desired");
    recursion_desired = rd;
}

void set_recursion_available(unsigned char ra){
    assert_message(qr != 0, "The type of packet is not answer.");
    recursion_available = ra;
}

void create_simple_query(char* hostname){
    set_id(((unsigned char)(rand() & 0x00ff)), ((unsigned char)(rand() & 0x00ff)));
    set_qerry_type(0);
    set_op_code(QUERY);
    set_truncated(0);
    set_recursion_desired(1);

    add_question(hostname, A, IN);
}

unsigned char*  get_bytes_query(){
    static unsigned char buffer[16384];
    int j =20;
    int i=0;
    char buffer_bin[8] ={0,0,0,0,0,0,0,0};

    /* Insert id */
    buffer[0] = id[0];
    buffer[1] = id[2];

    /* Insert QR*/
    buffer[2] = qr;

    /* Insert OPCODE*/
    itoa(op_code, buffer_bin, 2);
    buffer[3] = buffer_bin[4];
    buffer[4] = buffer_bin[5];
    buffer[5] = buffer_bin[6];
    buffer[6] = buffer_bin[7];

    memset(&buffer_bin[0], 0, sizeof(buffer_bin));

    /* Insert a authoritative_answer */
    buffer[7] = authoritative_answer;

    /* insert truncated*/
    buffer[8] = tc;

    /* Insert recursion_desired */
    buffer[9] = recursion_desired;

    /* Insert recursion_available */
    buffer[10] = recursion_available;

    /* Insert Z (for more info see rfc1035.txt line 1473)*/
    buffer[11] = 0; buffer[12] = 0; buffer[13] = 0;

    /* Insert RCODE */
    itoa(r_code, buffer_bin, 2);
    buffer[14] = buffer_bin[4];
    buffer[15] = buffer_bin[5];
    buffer[16] = buffer_bin[6];
    buffer[17] = buffer_bin[7];

    /* Insert QDCOUNT */
    buffer[18] = get_index_question() & 0xffff;

    /* Insert an_count */
    buffer[19] = an_count & 0xffff;

    /* Insert ns_count */
    buffer[19] = ns_count & 0xffff;

    /* Insert ar_count */
    buffer[19] = ar_count & 0xffff;


    /* Insert all Questions */
    for(i=0; i< get_index_question(); i++){
        j++;
    }
    return buffer;
}
