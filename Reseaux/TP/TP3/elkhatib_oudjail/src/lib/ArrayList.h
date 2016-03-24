#ifndef ARRAY_LIST_H
#define ARRAY_LIST_H

#define DEFAULT_SIZE 2

typedef elm_t unsigned char;

typedef struct {
    int capacite;
    int size;
    elm_t *data;
} ArrayList;

ArrayList *ArrayList_construct();
ArrayList *ArrayList_construct_with_capacite(int capacite);

void ArrayList_destruct(ArrayList *list);

int ArrayList_add_elm(ArrayList **list, elm_t elm);
int ArrayList_add_all(ArrayList **list, elm_t[] elm, size_t nelms);
int ArrayList_remove_elm(ArrayList *list, int index);

int ArrayList_contains(ArrayList *list, elm_t elm);

elm_t ArrayList_get_elm(const ArrayList *list, int index);
int ArrayList_set_elm(const ArrayList *list, int index, elm_t new_elm);


void ArrayList_print(const ArrayList *list);
void ArrayList_print_all(const ArrayList *list)


#endif
