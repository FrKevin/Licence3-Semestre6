#ifdef _MSC_VER
    #pragma comment(lib, "wsock32.lib")
#endif

#ifdef __WIN32__ /* si vous êtes sous Windows */
    #include <windows.h>
    #include <winsock.h>

#else
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>
    #include <netdb.h> /* gethostbyname */
    #include <linux/limits.h> /* const PATH_MAX */
#endif

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h> /* close */
#define HOSTNAME "224.0.0.1"
#define PORT 7654
#define closesocket(s) close(s)
typedef int MYSOCKET;
typedef struct sockaddr_in SOCKADDR_IN;
typedef struct sockaddr SOCKADDR;
typedef struct in_addr IN_ADDR;


void print_error(int cond, char *msg){
    if(cond == 1){
        #ifdef WIN32
        fprintf(stdout, "%s\n", msg);
        #endif
        #ifdef UNIX
        fprintf(stdout, "%s: %s\n", msg, strerror(errno));
        #endif
        exit(EXIT_FAILURE);
    }
}

void init(int* sock){
    #ifdef __WIN32__
    WORD versionWanted = MAKEWORD(1, 1);
    WSADATA wsaData;
    int err = WSAStartup(versionWanted, &wsaData);
    if (err < 0) {
        puts("WSAStartup failed !");
        exit(EXIT_FAILURE);
    }
    #endif
    *sock = socket(AF_INET, SOCK_DGRAM, 0);
    print_error(*sock == -1, "socket()");
}

void end(int sock_fd) {
    #ifdef __WIN32__
    WSACleanup();
    #endif
    closesocket(sock_fd);
}

/*
* main - The Chat's main routine
*/
int main(int argc, char **argv) {
    MYSOCKET sock;
    char buffer[PATH_MAX];
    struct hostent *hostinfo = NULL;
    SOCKADDR_IN to;
    int tosize = sizeof(to);
    int n_octet = 0;

    printf("begin inti()\n");
    init(&sock);
    printf("end init()\n");

    hostinfo = gethostbyname(HOSTNAME);
    if (hostinfo == NULL) {
        fprintf (stderr, "Unknown host %s.\n", HOSTNAME);
        exit(EXIT_FAILURE);
    }

    /* init SOCKADDR_IN */
    memset((char *) &to, 0, sizeof(to));
    to.sin_family = AF_INET;
    to.sin_port = htons(PORT);
    #ifdef __WIN32__
        int tmp_windows;
        tmp_windows = inet_addr(HOSTNAME);
        if ( tmp_windows == 1 && strcmp(HOSTNAME, "255.255.255.225") ){
            return 0;
        }
        to.sin_addr.s_addr = tmp_windows;
    #else
        print_error( inet_aton(HOSTNAME , &to.sin_addr) == 0, "inet_aton() failed\n");
    #endif


    printf("en cours d'envoie du message.\n");
    if(sendto(sock, argv[1], strlen(argv[1]), 0, (SOCKADDR *)&to, tosize) < 0) {
        perror("sendto()");
        exit(errno);
    }

    printf("Envoi ok\n");

    printf("Begin end()\n");
    end(sock);
    printf("end() ok \n");

    exit(EXIT_SUCCESS);
}
