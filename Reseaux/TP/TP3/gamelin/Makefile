# mshell - a job manager
VPATH = src
OBJ = ./bin

TP=3
NOM1=Gamelin

CC      		= gcc
CFLAGS  		= -g
CFLAGS 			+= -Wall -Werror -ansi -pedantic
CFLAGS 			+= -D_XOPEN_SOURCE=500
LDFLAGS 		= -g
OBJS_SENDER		= common.o question.o dns_packet.o udp_packet.o udp_sender.o main_of_sender.o
OBJS_RECEIVER	= common.o question.o dns_packet.o udp_packet.o udp_receiver.o main_of_receiver.o
EXEC    		= sender receiver

# main entries
all: $(EXEC)
	rm -rf $(OBJ)/ || true
	mkdir $(OBJ)
	mv -f $(OBJS_SENDER) $(OBJ)
	mv -f $(OBJS_RECEIVER) $(OBJ)

windows: windows_sender windows_receiver

windows_sender: $(OBJS_SENDER)
	$(CC) ${CFLAGS} $(OBJS_SENDER) -o $@ -lws2_32

windows_receiver: $(OBJS_RECEIVER)
	$(CC) ${CFLAGS} $(OBJS_RECEIVER) -o $@ -lws2_32

sender: $(OBJS_SENDER)
	$(CC) ${CFLAGS} $(OBJS) -o $@

receiver: $(OBJS_RECEIVER)
	$(CC) ${CFLAGS} $(OBJS) -o $@

# gcc -MM generated dependencies
common.o: common.c
question.o: question.c common.h
dns_packet.o: dns_packet.c question.h
udp_packet.o: udp_packet.c common.h
udp_sender.o: udp_sender.c udp_packet.h common.h
udp_receiver.o: udp_receiver.c udp_packet.h common.h
main_of_sender.o: main_of_sender.c common.h dns_packet.h udp_packet.h udp_sender.h
main_of_receiver.o: main_of_receiver.c common.h dns_packet.h udp_packet.h udp_receiver.h

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}.zip *
