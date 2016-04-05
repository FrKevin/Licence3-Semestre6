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
SRCS    = Core.c DNSHeader.c main.c
OBJS    = Core.o DNSHeader.o main.o
EXEC    = TestDNSHeader

# main entries
all: $(EXEC)
		 rm -rf $(OBJ)/ || true
		 mkdir $(OBJ)
		 mv -f $(OBJS) $(OBJ)

$(EXEC): $(OBJS)
	$(CC) ${CFLAGS} $(OBJS) -o $@

# gcc -MM generated dependencies
main.o: main.c Core.h DNSHeader.h
Core.o: Core.c Core.h
DNSHeader.o: DNSHeader.c DNSHeader.h Core.h

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}_${NOM2}.zip *
