
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

void print(){
    printf("DNS packet details :");
		printf("\tTransaction Id: %s ", id);
		printf("\tType of packet: %i", qr);
		printf("\t The OpCode : %i", op_code);
		if (qr == 0) {
			printf("\tIs authoritative : %c", authoritative_answer);
    }
		printf("\tIs truncated : %c ", tc);
		printf("\tIs recursion desired : %c ", recursion_desired);
		if (qr == 0 ) {
			printf("\tIs recursion available : %c ", recursion_available);
    }
		if (qr == 0) {
			printf("\tResponse code : %c "+r_code);
    }

	/*	System.out.println(" Nb of query : "+queries.size()); */
		/* les questions */
    /*display_questions
		for (Query query : queries) {
			System.out.println("  Query "+(i++)+" :");
			System.out.println("     Name : "+query.qName);
			System.out.println("     Type : "+query.qType);
			System.out.println("     Class : "+query.qClass);
		}*/
}

unsigned char*  get_bytes_query(){
    static unsigned char buffer[16384];
    int index_of_buffer = 0;
    int i=0, j = 0, offset = 0;
    unsigned char buffer_bin[8] ={0,0,0,0,0,0,0,0};
    char buffer_label[512];
    unsigned char bits[8];

    /* Insert id */
    buffer[index_of_buffer++] = id[0];
    buffer[index_of_buffer++] = id[2];

    /* Insert  1er flags*/
    int_to_bin(op_code, buffer_bin);
    bits[0] = qr;
    bits[1] = buffer_bin[4];
    bits[2] = buffer_bin[5];
    bits[3] = buffer_bin[6];
    bits[4] = buffer_bin[7];
    bits[5] = authoritative_answer;
    bits[6] = tc;
    bits[7] = recursion_desired;
    buffer[index_of_buffer++] = toByte(bits);

    memset(&buffer_bin[0], 0, sizeof(buffer_bin));
    memset(&bits[0], 0, sizeof(bits));

    /* Insert  2e flags*/
    int_to_bin(r_code, buffer_bin);
    bits[0] = recursion_available;
    bits[1] = 0; /* Insert Z (for more info see rfc1035.txt line 1473)*/
    bits[2] = 0; /* Insert Z (for more info see rfc1035.txt line 1473)*/
    bits[3] = 0; /* Insert Z (for more info see rfc1035.txt line 1473)*/
    bits[4] = buffer_bin[4];
    bits[5] = buffer_bin[5];
    bits[6] = buffer_bin[6];
    bits[7] = buffer_bin[7];
    buffer[index_of_buffer++] = toByte(bits);

    memset(&buffer_bin[0], 0, sizeof(buffer_bin));
    memset(&bits[0], 0, sizeof(bits));

    /* Insert QDCOUNT */
    buffer[index_of_buffer++] = get_index_question() & 0xffff;

    /* Insert an_count */
    buffer[index_of_buffer++] = ( an_count >> 8 ) & 0xffff;
    buffer[index_of_buffer++] = an_count & 0xffff;

    /* Insert ns_count */
    buffer[index_of_buffer++] = (ns_count >> 8) & 0xffff;
    buffer[index_of_buffer++] = ns_count & 0xffff;

    /* Insert ar_count */
    buffer[index_of_buffer++] = ( ar_count >> 8) & 0xffff;
    buffer[index_of_buffer++] = ar_count & 0xffff;

    /* Insert all Questions */
    for(i=0; i< get_index_question(); i++){
        offset = convert_donmaine_name_to_label(get_name(i), buffer_label);
        for( j = 0; j < offset; j++){
            buffer[index_of_buffer++] = buffer_label[j];
        }
        buffer[index_of_buffer++] = (get_type(i) >> 8) & 0xffff;
        buffer[index_of_buffer++] = get_type(i) & 0xffff;

        buffer[index_of_buffer++] = ( get_class(i) >> 8) & 0xffff;
        buffer[index_of_buffer++] = get_class(i) & 0xffff;
    }
    return buffer;
}
