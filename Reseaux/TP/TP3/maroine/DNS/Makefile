### Modèle pour vos Makefile

## Compilateur C et éditeur de liens
CC      = gcc -lm

## Options pour la compilation du C
CFLAGS  = 
#  Spécifie la version de la norme POSIX à respecter
CFLAGS += -D_XOPEN_SOURCE=500
#  Active les informations de débogage
CFLAGS += -g

## Options de l’édition de liens
LDFLAGS  = -g

## Compilation séparée
#  Le .o doit être recompilé dès que le .c ou le .h (s'il existe) change
%.o: %.c %.h
	${CC} ${CFLAGS} -c $<

all: dns

dns: dns.o
	${CC} -o $@ $^ -lm