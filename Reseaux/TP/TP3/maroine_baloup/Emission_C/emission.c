#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h> 
#include <netdb.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INVALID_SOCKET -1
#define SOCKET_ERROR -1
#define closesocket(s) close(s)
#define h_addr h_addr_list[0] /* Compatibilité anciennes versions */
#define PORT 49500


typedef int SOCKET;
typedef struct sockaddr_in SOCKADDR_IN;
typedef struct sockaddr SOCKADDR;
typedef struct in_addr IN_ADDR;

int main(int argc, char** argv) {
	
	SOCKET sock = socket(AF_INET, SOCK_DGRAM, 0);
	
	if(sock == INVALID_SOCKET) {
	    perror("socket()");
	    exit(errno);
	}

	
	SOCKADDR_IN sin = {0};

	struct hostent *hostinfo;
	const char *hostname = "localhost";

	// Connexion
	hostinfo = gethostbyname(hostname); /* on récupère les informations de l'hôte auquel on veut se connecter */

	if (hostinfo == NULL) { /* l'hôte n'existe pas */
    	fprintf (stderr, "Unknown host %s.\n", hostname);
    	exit(EXIT_FAILURE);
	}

	sin.sin_addr = *(IN_ADDR *) hostinfo->h_addr; /* l'adresse se trouve dans le champ h_addr de la structure hostinfo */
	sin.sin_port = htons(PORT); /* on utilise htons pour le port */
	sin.sin_family = AF_INET;

	if(connect(sock,(SOCKADDR *) &sin, sizeof(SOCKADDR)) == SOCKET_ERROR) {
    	perror("connect()");
    	exit(errno);
	}

	//Emission
	
	char *buffer = "Salut Maffande Maroxine \0";


	if(send(sock, buffer, strlen(buffer), 0) < 0) {
	    perror("send()");
	    exit(errno);
	}


	closesocket(sock);
	return 0;
} 