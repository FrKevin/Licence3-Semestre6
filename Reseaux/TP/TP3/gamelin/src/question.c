#include <stdio.h>
#include <string.h>

#include "common.h"
#include "question.h"

#define MAXQUESTIONS      255              /* max question at DNS packet */
static question questions[MAXQUESTIONS];

unsigned int index_question = 0;


void set_name(int index, char* n){
    assert_message(n != NULL, "The name of the question is null.");
    assert_message(strcmp(n, "") != 0, "The name of the question is empty.");
    questions[index].name = n;
}

char* get_name(int index){
    assert_message( index < index_question, "Cannot access The name of question.");
    return questions[index].name;
}


void set_type(int index, q_types t){
    questions[index].type = t;
}

q_types get_type(int index){
    assert_message( index < index_question, "Cannot access The name of question.");
    return questions[index].type;
}

void set_class(int index, q_class c){
    questions[index].class = c;
}

q_class get_class(int index){
    assert_message( index < index_question, "Cannot access The name of question.");
    return questions[index].class;
}

void add_question(char* name, q_types type, q_class class){
    assert_message( index_question < 255, "The limite of question is bigger than 255.");
    set_name(index_question, name);
    set_type(index_question, type);
    set_class(index_question, class);
    index_question++;
}

unsigned int get_index_question(){
    return index_question;
}
