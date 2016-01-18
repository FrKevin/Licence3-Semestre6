# mshell - a job manager
VPATH = src
OBJ = ./obj

TP=1
NOM1=Gamelin
NOM2=Oudjail

CC      = gcc
CFLAGS  = -g
CFLAGS += -Wall -Werror -ansi -pedantic
CFLAGS += -D_XOPEN_SOURCE=500
LDFLAGS = -g
SRCS    = client.c
OBJS    = client.o
EXEC    = chat

# main entries
all: $(EXEC)
		 rm -rf $(OBJ)/ || true
		 mkdir $(OBJ)
		 mv -f $(OBJS) $(OBJ)

chat: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@

# gcc -MM generated dependencies
client.o: client.c

# misc
.PHONY: clean realclean

clean:
	rm -rf $(OBJ) *~

realclean: clean
	rm -f $(EXEC)

archive: clean realclean
	zip -r TP${TP}_${NOM1}_${NOM2}.zip *
