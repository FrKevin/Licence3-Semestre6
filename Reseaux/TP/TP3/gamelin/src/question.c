#include <stdio.h>
#include <string.h>

#include "common.h"
#include "question.h"

#define MAXQUESTIONS      255              /* max question at DNS packet */
static question questions[MAXQUESTIONS];

unsigned int index_question = 0;


void setName(int index, char* n){
    assert_message(n != NULL, "The name of the question is null.");
    assert_message(strcmp(n, "") != 0, "The name of the question is empty.");
    questions[index].name = n;
}


void setType(int index, q_types t){
    questions[index].type = t;
}


void setClass(int index, q_class c){
    questions[index].class = c;
}

void add_question(char* name, q_types type, q_class class){
    assert_message( index_question < 255, "The limite of question is bigger than 255.");
    setName(index_question, name);
    setType(index_question, type);
    setClass(index_question, class);
    index_question++;
}

unsigned int get_index_question(){
    return index_question;
}
