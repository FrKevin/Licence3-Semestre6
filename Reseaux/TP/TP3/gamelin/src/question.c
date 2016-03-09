#include <stdio.h>
#include <string.h>

#include "common.h"
#include "question.h"

/*!
    \brief Contains all question, present in DNS packet
*/
static question questions[MAXQUESTIONS];

/*!
    \brief The index of the question's array
*/
unsigned int index_question = 0;

void set_name(int index, char* n){
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

void display_question(int index){
    int tmp = index +1;
    assert_message(index < index_question, "Cannot display question");
    printf("\tQuery %i:\n", tmp);
    printf("\t\tName: %s\n", get_name(index));
    printf("\t\tType: %i\n", get_type(index));
    printf("\t\tClass: %i\n", get_class(index));
}

extern void display_questions(){
    int i = 0;
    for (i = 0; i < index_question; i++) {
        display_question(i);
    }
}
