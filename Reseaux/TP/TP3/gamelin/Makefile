# mshell - a job manager
VPATH = src
OBJ = ./bin

TP=3
NOM1=Gamelin

CC		= gcc
CFLAGS	= -g
CFLAGS	+= -Wall -Werror -ansi -pedantic
CFLAGS	+= -D_XOPEN_SOURCE=500
LDFLAGS	= -g
OBJS	= common.o question.o answer.o dns_packet.o udp_packet.o main.o
EXEC	= dns_linux

# main entries
all: $(EXEC)
	rm -rf $(OBJ)/ || true
	mkdir $(OBJ)
	mv -f $(OBJS) $(OBJ)

dns_linux: $(OBJS)
		$(CC) ${CFLAGS} $(OBJS) -o $@

dns_windows:$(OBJS)
	$(CC) ${CFLAGS} $(OBJS) -o $@ -lws2_32

# gcc -MM generated dependencies
common.o: common.c
question.o: question.c common.h
answer.o: answer.c question.h
dns_packet.o: dns_packet.c question.h answer.h answer.h
udp_packet.o: udp_packet.c common.h
main.o: main.c common.h dns_packet.h udp_packet.h answer.h

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}.zip *
