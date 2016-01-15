#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <netdb.h>
#include <unistd.h>
#include <assert.h>

//#define PROGRAM_CALL_DNS

#define QUERYLENGTH 29
#define BUFFERLENGTH 512

#define HOSTDESTNAME "reserv1.univ-lille1.fr"
#define HOSTDESTADDR "193.49.225.15"
#define PORT     53

int main() {
  int sock = 0;
  struct sockaddr_in name;
  struct hostent * hp = NULL;
  char query[QUERYLENGTH] = 
    {
      (char) 0x08, (char) 0xbb,  (char) 0x01, (char) 0x00,/* a) 12 octets d'entete : identifiant de requete/parametres */
      (char) 0x00, (char) 0x01,  (char) 0x00, (char) 0x00, 
      (char) 0x00, (char) 0x00,  (char) 0x00, (char) 0x00, 
      (char) 0x03, (char) 0x77,  (char) 0x77, (char) 0x77,/* b) question : "3www4lifl2fr0" */
      (char) 0x04, (char) 0x6c,  (char) 0x69, (char) 0x66,
      (char) 0x6c, (char) 0x02,  (char) 0x66, (char) 0x72,
      (char) 0x00,
      (char) 0x00, (char) 0x01,                           /* c) */
      (char) 0x00, (char) 0x01
    };
  
  char buffer[BUFFERLENGTH];
  char ** p = NULL;

  /* recvfrom */
  int len,i ;
  struct sockaddr_in addrClient;
  socklen_t          addrClientlen = 0;
  


  memset(&addrClient, 0, sizeof(struct sockaddr_in));
  memset(&name, 0, sizeof(struct sockaddr_in));
  
  /* 1) creation d'un socket udp */
  fprintf(stderr," creation du socket UDP ... ");

  sock = socket(PF_INET, SOCK_DGRAM, 0);

  if (sock < 0) {  /* un  perror est plus simple ... mais les cas d'erreurs moins explicites ... */
    fprintf(stderr,"[erreur] : ");
    switch(errno) {
    case EPROTONOSUPPORT:
      fprintf(stderr,"Le type de protocole, ou le protocole lui-même n'est pas disponible dans ce domaine de communication.");
      break;
    case EAFNOSUPPORT:
      fprintf(stderr,"L'implementation ne supporte pas la famille d'adresses indiquee.");
      break;
    case ENFILE:
      fprintf(stderr,"La table des descripteurs par processus est pleine.");
      break;
    case EMFILE:
      fprintf(stderr,"La table des fichiers est pleine.");
      break;
    case EACCES:
      fprintf(stderr,"La creation d'une telle socket n'est pas autorisee.");
      break;
    case ENOBUFS:
    case ENOMEM:
      fprintf(stderr,"Pas suffisament d'espace pour allouer les buffers necessaires.");
      break;
    case  EINVAL:
      fprintf(stderr,"Protocole inconnu, ou famille de protocole inexistante.");
      break;
    default:
      fprintf(stderr,"Erreur inconnue");
      break;
    }
    return -1;
  }
  fprintf(stderr,"[ok]\n");

  
  /* 2) hote de destination */
#ifdef PROGRAM_CALL_DNS
  fprintf(stderr," recherche de hote de destination ... ");
  hp = gethostbyname(HOSTDESTNAME); //convertir @alphanum en  @IP
  if (hp == NULL){ 
    fprintf(stderr,"[erreur] : ");
    switch(h_errno) {
    case HOST_NOT_FOUND:
      fprintf(stderr,"L'hote indique est inconnu.");
      break;
    case NO_ADDRESS:  
      fprintf(stderr,"Le nom est valide mais ne possede pas d'adresse IP.");
      break;
    case NO_RECOVERY:
      fprintf(stderr,"Une erreur fatale du serveur de noms est apparue.");
      break;
    case TRY_AGAIN:
    default:
      fprintf(stderr,"Erreur inconnue");
      break;
    }
    return -2;
  }
  fprintf(stderr,"[ok]\n");
  
  /* affichage */
  fprintf(stderr," - h_name : \"%s\"\n",hp->h_name);
  for ( p =  hp->h_aliases; *p != NULL ; p++){
    fprintf(stderr," - h_aliases : \"%s\"\n",*p);
  }
  fprintf(stderr," - h_addrtype : %s\n",(hp->h_addrtype == AF_INET)?"AF_INET":((hp->h_addrtype == AF_INET6)?"AF_INET6":"unknown"));
  fprintf(stderr," - h_length : %d\n",hp->h_length);
  for ( p =  hp->h_addr_list; *p != NULL ; p++){
    fprintf(stderr," - h_addr_list : \"%x.%x.%x.%x\"\n",*(*p)&0xff,*(*p+1)&0xff,*(*p+2)&0xff,*(*p+3)&0xff);
  }
  fprintf(stderr," - h_addr : \"%x.%x.%x.%x\"\n",*(hp->h_addr)&0xff,*(hp->h_addr+1)&0xff,*(hp->h_addr+2)&0xff,*(hp->h_addr+3)&0xff);

  /* 3) preparation du socket d'envoi */
  name.sin_family = hp->h_addrtype;
  name.sin_port   = htons(PORT);
  memcpy(/*dest*/(char *)&name.sin_addr.s_addr,/*src */(char *)hp->h_addr,hp->h_length); //<- memcpy + inversion!!!

#else /* PROGRAM_CALL_DNS */
  /* 3) autre possibilite si l'on connait l'ip du DNS */
  name.sin_family = AF_INET;
  name.sin_port   = htons(PORT);
  inet_pton(AF_INET, HOSTDESTADDR, &name.sin_addr.s_addr);

#endif /* PROGRAM_CALL_DNS */





  
  /* 4) envoi du message */  
  fprintf(stderr," envoie du message ... ");
  if (sendto(sock, query, QUERYLENGTH , 0,(struct sockaddr*)&name, sizeof(struct sockaddr_in)) < 0 ) { 
    fprintf(stderr,"[erreur] : ");
    switch(errno) {
    
    case EAGAIN:
      fprintf(stderr,"La socket est non-bloquante et l'operation demandee bloquerait.");
      break;
    
    case EBADF:  
      fprintf(stderr,"Descripteur de socket invalide.");
      break;
    
    case ECONNRESET:
      fprintf(stderr,"Connexion re-initialisee par le pair.");
      break;
      

    case EDESTADDRREQ:
      fprintf(stderr,"La socket n'est pas en mode connexion et aucune adresse de pair n'a ete positionnee.");
      break;
      
    case EFAULT: 
      fprintf(stderr,"Un parametre pointe en dehors de l'espace d'adressage accessible.");
      break;
      
    case EINTR: 
      fprintf(stderr,"Un signal a ete reçu avant que la moindre donnee n'ait ete transmise.");
      break;
      
    case EINVAL: 
      fprintf(stderr,"Un argument invalide a ete transmis.");
      break;
      
    case EISCONN:
      fprintf(stderr,"La  socket  en mode connexion est deja connectee mais un destinataire a ete specifie. (Maintenant, soit cette erreur est retournee, soit la specification du destinataire est ignoree.");
      break;
      
    case EMSGSIZE:  
      fprintf(stderr,"Le type de socket necessite une emission integrale du message mais la taille de celui-ci ne le permet pas.");
      break;
      
    case ENOBUFS:  
      fprintf(stderr,"La file d'emission de l'interface reseau est pleine. Ceci indique generalement une panne de l'interface reseau, mais peut egalement être dû a un engorgement passager. Ceci ne doit pas se produire sous Linux, les paquets sont silencieusement elimines.");
      break;
      
    case ENOMEM: 
      fprintf(stderr,"Pas assez de memoire pour le noyau.");
      break;
      
    case ENOTCONN:  
      fprintf(stderr,"La socket n'est pas connectee et aucune cible n'a ete fournie.");
      break;
      
    case ENOTSOCK:  
      fprintf(stderr,"L'argument s n'est pas une socket.");
      break;
      
    case EOPNOTSUPP:  
      fprintf(stderr,"Au moins un bit de l'argument flags n'est pas approprie pour le type de socket.");
      break;
            
    case EPIPE:  
      fprintf(stderr,"L'ecriture  est  impossible  (correspondant  absent).  Dans  ce  cas,  le processus recevra egalement un signal SIGPIPE sauf s'il a activee l'option MSG_NOSIGNAL.");
      break;
      
    default:
      fprintf(stderr,"Erreur inconnue");
      break;
    }
    return -1;
  }
  fprintf(stderr,"[ok]\n");


    /* 5) reception du message */  
  fprintf(stderr," reception du message ... ");
  if ((len = recvfrom(sock, buffer, BUFFERLENGTH , 0,(struct sockaddr*)&addrClient, &addrClientlen)) <= 0 ) {  /* GAFFE AU PARENTHESAGE !! */
    fprintf(stderr,"[erreur] : ");
    switch(errno) {
    case EBADF: 
      fprintf(stderr,"L'argument s n'est pas un descripteur valide.");
      break;
    case ECONNREFUSED: 
      fprintf(stderr,"Un hôte distant a refuse la connexion reseau (generalement parce qu'il n'offre pas le service demande).");
      break;
    case ENOTCONN: 
      fprintf(stderr,"La socket est associee a un protocole oriente connexion et n'a pas encore ete connectee (voir connect(2) et accept(2)).");
      break;
    case ENOTSOCK: 
      fprintf(stderr,"L'argument s ne correspond pas a une socket.");
      break;
    case EAGAIN: 
      fprintf(stderr,"La socket est non-bloquante et aucune donnee n'est disponible, ou un delai de timeout a ete indique, et il a expire sans que l'on ait reçu quoi que ce soit.");
      break;
    case EINTR: 
      fprintf(stderr,"Un signal a interrompu la lecture avant que des donnees soient disponibles.");
      break;

    case EFAULT: 
      fprintf(stderr,"Un buffer pointe en dehors de l'espace d'adressage accessible.");
      break;
      
    case EINVAL: 
      fprintf(stderr,"Un argument est invalide.");
      break;
      
    default:
      fprintf(stderr,"Erreur inconnue");
      break;
    }
    return -1;
  }
  fprintf(stderr,"[ok]\n");
  

  close(sock); //fermeture de la liaison.		

  /* affichage de la reponse */
  fprintf(stdout,"Message\n",len);
  fprintf(stdout,"- message length : %d\n",len);
  fprintf(stdout,"- message : \n");
  
  /* affichage %c */
  for( i=0 ; i<len ; i++){
    fprintf(stdout,"%c,",buffer[i]>31?buffer[i]:'.');
    if (!((i+1)%16))
      fprintf(stdout,"\n");
  }
  fprintf(stdout,"\n");

  /* affichage %h */
  for( i=0 ; i<len ; i++){
    fprintf(stdout,"%.2x ",(int)(buffer[i]&0xff));
    if (!((i+1)%16))
      fprintf(stdout,"\n");
  }
  fprintf(stdout,"\n");
  
  
  
}


