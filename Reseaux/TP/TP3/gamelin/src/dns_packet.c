
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "common.h"
#include "question.h"
#include "dns_packet.h"



void initialize_packet(dns_packet* packet){
    int i = 0;

    for(i =0; i < 3; i++){
        packet->reserved[i] = 0x00;
    }
    packet->r_code = NO_ERROR;
    packet->an_count = 0;
    packet->ns_count = 0;
    packet->ar_count = 0;
    packet->recursion_available = 0;
    packet->authoritative_answer = 0;
}

void set_id(dns_packet* packet, unsigned char b1, unsigned char b2){
    packet->id[0] = b1;
    packet->id[1] = b2;
}

void create_query(dns_packet* packet, char* hostname){
    initialize_packet(packet);
    srand(time(NULL));
    set_id(packet, ((unsigned char)(rand() & 0x00f)), ((unsigned char)(rand() & 0x00ff)));

    packet->is_answer = 0;
    packet->op_code = QUERY;
    packet->truncated = 0;
    packet->recursion_desired = 1;

    add_question(hostname, A, IN);
}

void display_packet(dns_packet* packet){
    printf("DNS packet details :\n");
	printf("\tTransaction Id: %02x %02x\n", packet->id[0], packet->id[1]);
	printf("\tType of packet: %i\n", packet->is_answer);
	printf("\t The OpCode : %i\n", packet->op_code);
	if (packet->is_answer == 1) {
        printf("\tIs authoritative: %i\n", packet->authoritative_answer);
    }
	printf("\tIs truncated: %i\n", packet->truncated);
	printf("\tIs recursion desired: %i\n", packet->recursion_desired);
	if (packet->is_answer == 1 ) {
		printf("\tIs recursion available: %i\n", packet->recursion_available);
    }
	if (packet->is_answer == 0) {
		printf("\tResponse code: %d\n"+packet->r_code);
    }

    printf("\tNumber of query: %i\n", get_index_question() );

    display_questions();
}

void display_packet_to_format(char* dns_query, int sizeof_query, int is_binary){
    int i = 0, j = 0;
    unsigned char buffer_byte[8] ={0,0,0,0,0,0,0,0};

    printf("DNS packet format details: ");
    if ( is_binary == 1 ) {
        printf("(binary format)\n");
    } else {
        printf("(binary format)\n");
    }

    for (i = 0; i < sizeof_query; i++) {
        if ( is_binary == 2) {
            int_to_byte((int) dns_query[i], buffer_byte);
            for( j = 0; j < 8; j++) {
                printf("%i", buffer_byte[j]);
            }
            memset(&buffer_byte[0], 0, sizeof(buffer_byte));
            printf(" ");
        } else {
            printf("%02x ", dns_query[i]);
        }
        if ( (i+1) % 16 == 0 ) {
            printf("\n");
        }
    }
    printf("\n");
}

int  convert_dns_packet_to_char(dns_packet* packet, char buffer[16384]){
    int index_of_buffer = 0;
    int i=0, j = 0, offset = 0;
    unsigned char buffer_byte[8] ={0,0,0,0,0,0,0,0};
    char buffer_label[512];
    unsigned char bits[8];

    send_verbose_message("");
    send_verbose_message("Begin convert query to char.");

    /* Insert id */
    buffer[index_of_buffer++] = packet->id[0];
    buffer[index_of_buffer++] = packet->id[1];
    send_verbose_message("\tThe id has been inserted.");

    /* Insert  1er flags*/
    int_to_byte(packet->op_code, buffer_byte);
    bits[0] = packet->is_answer;
    bits[1] = buffer_byte[4];
    bits[2] = buffer_byte[5];
    bits[3] = buffer_byte[6];
    bits[4] = buffer_byte[7];
    bits[5] = packet->authoritative_answer;
    bits[6] = packet->truncated;
    bits[7] = packet->recursion_desired;
    buffer[index_of_buffer++] = toByte(bits);
    send_verbose_message("\tThe first flags has been inserted.");
    memset(&buffer_byte[0], 0, sizeof(buffer_byte));
    memset(&bits[0], 0, sizeof(bits));

    /* Insert  2e flags*/
    int_to_byte(packet->r_code, buffer_byte);
    bits[0] = packet->recursion_available;
    bits[1] = packet->reserved[0]; /* Insert Z (for more info see rfc1035.txt line 1473)*/
    bits[2] = packet->reserved[1]; /* Insert Z (for more info see rfc1035.txt line 1473)*/
    bits[3] = packet->reserved[2]; /* Insert Z (for more info see rfc1035.txt line 1473)*/
    bits[4] = buffer_byte[4];
    bits[5] = buffer_byte[5];
    bits[6] = buffer_byte[6];
    bits[7] = buffer_byte[7];
    buffer[index_of_buffer++] = toByte(bits);
    send_verbose_message("\tThe second flags has been inserted.");
    memset(&buffer_byte[0], 0, sizeof(buffer_byte));
    memset(&bits[0], 0, sizeof(bits));

    /* Insert QDCOUNT */
    buffer[index_of_buffer++] = ( get_index_question() >> 8 ) & 0xffff;
    buffer[index_of_buffer++] = get_index_question() & 0xffff;
    send_verbose_message("\tThe number of query has been inserted.");

    /* Insert an_count */
    buffer[index_of_buffer++] = ( packet->an_count >> 8 ) & 0xffff;
    buffer[index_of_buffer++] = packet->an_count & 0xffff;
    send_verbose_message("\tThe the number of resource records (in the answer section) has been inserted.");

    /* Insert ns_count */
    buffer[index_of_buffer++] = (packet->ns_count >> 8) & 0xffff;
    buffer[index_of_buffer++] = packet->ns_count & 0xffff;
    send_verbose_message("\tThe the number of name server resource records has been inserted.");

    /* Insert ar_count */
    buffer[index_of_buffer++] = ( packet->ar_count >> 8) & 0xffff;
    buffer[index_of_buffer++] = packet->ar_count & 0xffff;
    send_verbose_message("\tThe the number of resource records (in the additional records section) has been inserted.");

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
    send_verbose_message("\tAll query has been inserted.");

    send_verbose_message("Finish convert query to char.");
    send_verbose_message("");

    return index_of_buffer;
}

char* convert_label_to_char(int n, char buffer[], int offset){
    char* name;
    int i = 0;

    name = malloc (n*sizeof(char));
    assert_message( name != NULL, "malloc error.");

    for(i = 0; i< n; i++){
        name[i] = (char)buffer[offset+i];
    }
    name[n] = '\0';
    return name;
}

void convert_char_to_dns_packet(char buffer[], int sizeof_buffer, dns_packet* packet){
    int flag = 0;
    int index = 0;
    int i = 0;
    unsigned char buffer_byte[8] ={0,0,0,0,0,0,0,0};
    char domaine_name[PATH_MAX];
    char** tmp;

    /* The id of answer */
    packet->id[0] = buffer[index++];
    packet->id[1] = buffer[index++];

    memset(&buffer_byte[0], 0, sizeof(buffer_byte));
    flag = buffer[index++] & 0xFF;
    int_to_byte(flag, buffer_byte);
    packet->is_answer = buffer_byte[0];
    /* op_code: buffer_byte[1] buffer_byte[2] buffer_byte[3] buffer_byte[4] */
    packet->op_code = QUERY;

    packet->authoritative_answer =  buffer_byte[5];
    packet->truncated = buffer_byte[6];
    packet->recursion_desired  = buffer_byte[7];

    memset(&buffer_byte[0], 0, sizeof(buffer_byte));
    flag = buffer[index++] & 0xFF;
    packet->recursion_available = buffer_byte[0];
    packet->reserved[0] = 0;
    packet->reserved[1] = 0;
    packet->reserved[2] = 0;

    /* TODO */
    packet->r_code = NO_ERROR;

    flag = ( buffer[index++] & 0xffff) << 8;
    flag += buffer[index++] & 0xffff;
    packet->nunber_of_question = flag;

    flag = ( buffer[index++] & 0xffff) << 8;
    flag += buffer[index++] & 0xffff;
    packet->an_count = flag;

    flag = ( buffer[index++] & 0xffff) << 8;
    flag += buffer[index++] & 0xffff;
    packet->ns_count = flag;

    flag = ( buffer[index++] & 0xffff) << 8;
    flag += buffer[index++] & 0xffff;
    packet->ar_count = flag;


    tmp = (char**)malloc(3*sizeof(char*));
    assert_message( tmp!= NULL, "malloc error");

    for( i = 0; i < 3; i++){
        flag = buffer[index++] & 0xFF;
        tmp[i] = convert_label_to_char(flag, buffer, index);
        index += flag;
    }
    snprintf(domaine_name, PATH_MAX, "%s.%s.%s", tmp[0], tmp[1], tmp[2]);

    printf("domaine_name %s \n", domaine_name);
}
