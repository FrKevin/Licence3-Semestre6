#include <netinet/in.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <assert.h>

void blank(struct sockaddr_in **sa_in){
	*sa_in = memset(*sa_in, 0, sizeof(struct sockaddr_in)) ;
}

int main(int argc, char **argv) {
    /* Declaration des variables */
	char buf[1024];
	int sockfd;
	struct sockaddr_in *sa_in;

	sa_in = (struct sockaddr_in*) malloc(sizeof(struct sockaddr_in));
	assert(sa_in);

	blank(&sa_in);

	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	assert(sockfd != -1);

	sa_in->sin_family = AF_INET;
	sa_in->sin_port = htons(8008);
	sa_in->sin_addr.s_addr = INADDR_ANY;

	assert(bind(sockfd,sa_in, sizeof(struct sockaddr_in)) >= 0);

	assert(recv(sockfd, buf, 1024, 0) != -1);

	printf("%s\n", buf);


  return 0;
}



