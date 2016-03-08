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
SRCS    = common.c question.c packet.c udp_sender.c main.c
OBJS    = common.o question.o packet.o udp_sender.o main.o
EXEC    = DNS_Solveur

# main entries
all: $(EXEC)
		 rm -rf $(OBJ)/ || true
		 mkdir $(OBJ)
		 mv -f $(OBJS) $(OBJ)

DNS_Solveur: $(OBJS)
	$(CC) ${CFLAGS} $(OBJS) -o $@

#-lws2_32
# gcc -MM generated dependencies
common.o: common.c
question.o: question.c common.h
packet.o: packet.c question.h
udp_sender.o: udp_sender.c common.h
main.o: main.c common.h packet.h udp_sender.h

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}.zip *
