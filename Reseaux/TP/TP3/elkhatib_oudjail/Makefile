VPATH = src
OBJ = ./bin

TP=3
NOM1=ElKhatib
NOM2=Oudjail

CC      = gcc
CFLAGS  = -g
CFLAGS += -Wall -Werror -std=c99 -pedantic
CFLAGS += -D_XOPEN_SOURCE=500
LDFLAGS = -g
SRCS    = Core.c DNS.c DNSQuestion.c DNSHeader.c UDPReceive.c
OBJS    = Core.o DNS.o DNSQuestion.o DNSHeader.o UDPReceive.o
EXEC    = DNSSolver

# main entries
all: $(EXEC)
		 rm -rf $(OBJ)/ || true
		 mkdir $(OBJ)
		 mv -f $(OBJS) $(OBJ)

DNSSolver: $(OBJS)
	$(CC) ${CFLAGS} $(OBJS) -o $@

# gcc -MM generated dependencies
Core.o: Core.c

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}_${NOM2}.zip *
