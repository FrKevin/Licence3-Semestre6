# mshell - a job manager
VPATH = src
OBJ = ./bin

TP=3
NOM1=Gamelin

CC      = gcc
CFLAGS  = -g
CFLAGS += -Wall -Werror -ansi -pedantic
CFLAGS += -D_XOPEN_SOURCE=500
LDFLAGS = -g
SRCS    = common.c question.c packet.c main.c
OBJS    = common.o question.o packet.o main.o
EXEC    = DNS_Solveur

# main entries
all: $(EXEC)
		 rm -rf $(OBJ)/ || true
		 mkdir $(OBJ)
		 mv -f $(OBJS) $(OBJ)

DNS_Solveur: $(OBJS)
	$(CC) ${CFLAGS} $(OBJS) -o $@

# gcc -MM generated dependencies
common.o: common.c
question.o: question.c common.h
packet.o: packet.c question.h
main.o: main.c common.h packet.h

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}.zip *
