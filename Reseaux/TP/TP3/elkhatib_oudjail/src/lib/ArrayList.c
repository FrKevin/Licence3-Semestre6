#include "ArrayList.h"
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


ArrayList *ArrayList_construct()
{
  return ArrayList_construct_with_capacite(DEFAULT_CAPACITE);
}

ArrayList *ArrayList_construct_with_capacite(int capacite)
{
  ArrayList *construct;

  construct = (ArrayList*) malloc(sizeof(ArrayList));
  construct->capacite = capacite;
  construct->size = 0;
  construct->data = (elm_t*) malloc(capacite * sizeof(elm_t));

  return construct;
}

void ArrayList_destruct(ArrayList *list);
{
  free(list->data);
  list->data = NULL;
  free(list);
}

int ArrayList_add_elm(ArrayList **list, elm_t elm)
{
  ArrayList *new_list;
  ArrayList *llist = *list;
  int i;

  if (llist->size == llist->capacite) {
    new_list = ArrayList_construct_with_capacite(llist->capacite*2);

    for (i = 0; i < llist->size; ++i) {
      new_list->data[i] = llist->data[i];
    }

    new_list->size = llist->size;
    ArrayList_destruct(llist);
    *list = new_list; /* Effet de bord */
  }

  llist->data[llist->size++] = elm;
  return 1;
}



int ArrayList_remove_elm(ArrayList *list, int index)
{
  int i;

  if (index < 0 || index >= list->size) {
    return 0;
  }

  for (i=index; i < list->size -1; ++i) {
    list->data[i] = list->data[i+1];
  }

  list->size--;
  return 1;
}


int ArrayList_contains(ArrayList *list, elm_t elm)
{
  int i;
  for (i=0; i < list->size; ++i) {
    if (ArrayList_get_elm(list, i) == elm) {
      return 1;
    }
  }
  return 0;
}

elm_t ArrayList_get_elm(const ArrayList *list, int index)
{
  if (index < 0 || index >= list->size) {
    fprintf(stderr, "ArrayList : Out of range\n");
    return 0;
  }
  return list->data[index];
}


int ArrayList_set_elm(const ArrayList *list, int index, elm_t new_elm);
{
  if (index < 0 || index >= list->size) {
    fprintf(stderr, "ArrayList : Out of range\n");
    return 0;
  }

  list->data[index] = new_elm;
  return 1;
}


void ArrayList_print(const ArrayList *list);
{
  int i;
  printf("[ ");
  for(i=0; i < list->size-1; ++i) {
    printf("%s, ", ArrayList_get_elm(list, i));
  }
  printf("%s ]\n", ArrayList_get_elm(list, list->size-1));
}

void ArrayList_print_all(const ArrayList *list)
{
  int i;
  printf("[ ");
  for(i=0; i < list->capacite-1; ++i) {
    printf("%s, ", list->data[i]);
  }
  printf("%s ]\n", list->data[list->capacite-1]);
}
