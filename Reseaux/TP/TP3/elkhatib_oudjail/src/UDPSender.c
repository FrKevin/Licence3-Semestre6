#include <netinet/in.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <assert.h>


/* HTONS */

void blank(struct sockaddr_in **sa_in){
	*sa_in = memset(*sa_in, 0, sizeof(struct sockaddr_in)) ;
}


int main(int argc, char **argv) {
    /* Declaration des variables */
	char* message_sender = argv[1];
	int  nmessage_s = strlen(message_sender);
	char* addresse = "127.0.0.1";


	struct sockaddr_in *sa_in;
	int sockfd;
	struct in_addr addr;
	

	sa_in = (struct sockaddr_in*) malloc(sizeof(struct sockaddr_in));
	assert(sa_in);
	
	blank(&sa_in);

	sockfd = socket (AF_INET, SOCK_DGRAM, 0);
	assert(sockfd != -1);

	inet_pton(AF_INET, addresse, &addr);
	sa_in->sin_family = AF_INET;
	sa_in->sin_port = htons(8008);
	sa_in->sin_addr = addr;


	/* Senders */

	sendto(sockfd, message_sender, nmessage_s+1, NULL, sa_in, sizeof(struct sockaddr_in));

	/* Destruction */

	free(sa_in);

	close(sockfd);


  return 0;
}
