## CAPTURE DE TRAMES
** 1) Que fait cette commande (utilisez le man) ? **

  ` ifconfig affiche simplement l'état des interfaces actuellement définies
    si seul le paramètre -a est fourni, il affiche l'état de toutes les interfaces, même celles qui ne sont pas actives `

** 2)  Quelles interfaces réseaux sont actuellement actives (running) ? **
  - eth0

** 3) Parmi ces interfaces, quelle est celle qui vous permet de communiquer avec d'autres machines ?
**
  - eth0

** 4) Quelles sont les adresses MAC et IPv4 de cette interface ? **
  - MAC: 98:90:96:bb:80:7c
  - IPV4: inet adr:192.168.5.58  Bcast:192.168.5.255  Masque:255.255.255.0

** 5) Utilisez la commande ping pour tester la connectivité de votre machine vers la machine du voisin **

  - ping 192.168.5.59
  - PING 192.168.5.59 (192.168.5.59) 56(84) bytes of data.
  - 64 bytes from 192.168.5.59: icmp_seq=1 ttl=64 time=0.705 ms
  - 64 bytes from 192.168.5.59: icmp_seq=2 ttl=64 time=0.740 ms
  - 64 bytes from 192.168.5.59: icmp_seq=3 ttl=64 time=0.774 ms
  - 64 bytes from 192.168.5.59: icmp_seq=4 ttl=64 time=0.702 ms
  - 64 bytes from 192.168.5.59: icmp_seq=5 ttl=64 time=0.718 ms
  - 64 bytes from 192.168.5.59: icmp_seq=6 ttl=64 time=0.656 ms
  - 64 bytes from 192.168.5.59: icmp_seq=7 ttl=64 time=0.623 ms
  - 64 bytes from 192.168.5.59: icmp_seq=8 ttl=64 time=0.754 ms
  - 64 bytes from 192.168.5.59: icmp_seq=9 ttl=64 time=0.684 ms
  - 64 bytes from 192.168.5.59: icmp_seq=10 ttl=64 time=0.651 ms
  - 64 bytes from 192.168.5.59: icmp_seq=11 ttl=64 time=0.664 ms
  - ^C

  - --- 192.168.5.59 ping statistics ---
  - 11 packets transmitted, 11 received, 0% packet loss, time 9998ms
  - rtt min/avg/max/mdev = 0.623/0.697/0.774/0.050 ms

** 6) Que représente la valeur « Time » retournée par la commande ping ? **
  - Time représente le temps en ms du trajet aller retour entre 2 machines.

** 7)Selon vous, de manière générale, pourquoi utilise-t-on l'adresse IP et non directement l'adresse MAC pour les communications réseaux ? **
  - Adresse MAC formtement liés au materiel (graver), elle ne donne pas précission sur le réseau, contrairement au adresse IP.

** 8) Lancez la commande ping vers votre voisin. D'après les informations capturées et décodées par
wireshark, quels sont les paquets envoyés et reçus suite à l'exécution du ping ? Quels protocoles sont
utilisés ? **
  - Le protocole: ICMP
  - 1 paquet de 48 bits et envoyer a l'adrese du ping.
  - Cette adresse renvoie un autre paquets de 48 bits pour confirmer qu'il la reçue.

** 9) A quelles couches appartiennent les protocoles cités précédemment ? **
  - A la couche transport

** 10) Le filtre à l'affichage : après avoir effectué la capture précédente, dans le menu « analyse > display
filters », faites en sorte que s'affiche uniquement le dialogue entre votre machine et celle du voisin.
**
  - voisin_filter
  - ip.addr == 192.168.5.59

** 11) le filtre de capture : dans le menu « capture > options », faites en sorte que soit capturé uniquement le
dialogue entre votre machine et celle du voisin. **
  - IP adress 192.168.5.59
  - host 192.168.5.59

## ETHERNET

** 1) Quel est le code du protocole de couche supérieur ? **
  - Ethernet II, Src: Dell_bb:80:7c (98:90:96:bb:80:7c), Dst: Dell_bb:7b:4f (98:90:96:bb:7b:4f)
    0000   98 90 96 bb 7b 4f 98 90 96 bb 80 7c 08 00        ....{O.....|..

** 2) Quel est le rôle des 2 premiers champ de l'en-tête de la trame ? **
  - 0000 ->
  - 98 90 96 bb 7b 4f -> adresse cible
  - 98 90 96 bb 80 7c 08 -> adresse destinataire (nous)
  - 00 ->

** 3) Quelle est l'utilité de ces commandes et à quel niveau du modèle OSI interviennent-elles principalement ? **
  - Speed: 100Mb/s
  - Duplex: Full
  - Il est utilie a la couche physique


** 4) Que constatez-vous ? **
  - le champ Speed et Duplex ont un statut Unknown! de plus Link detected est a: no.
    Pour le eth0 sont statut a changer il n'est plus en RUNNING

** 5) Tester la connectivité de votre machine vers la machine du voisin.**
  - La connection entre la machine et le voisin marche.

##  CONCENTRATEUR

** 1)Que constatez-vous ? Déduisez-en la manière dont fonctionne cet équipement. Les données émises par un poste sont-elles reçues par ce même poste ? **
  - Tous les ordinateurs présent sur le hub, recoivent les requètes  ping, mais seule la source envoie          uen reponsse.

** 2) Recommencez la manipulation en désactivant le mode promiscuous de wireshark. A quoi sert-il ? **
  - Le mode promiscuous permet de capturer les packets même lorsqu'ils ne nous sont pas detinées

** 3)  Quel est le mode duplex des interfaces connectées au hub ? Quelle en est la signification ?
**
  - 10 base t
  - Half Duplex : on ne peut pas envoyer en même temps que recevoir.

** 4) Quelles sont les topologies physique et logique du réseau constitué par le concentrateur et les postes qui y sont connectés ?**
  - Physique : étoile. Logique : bus.

** 5)  Notez le débit atteint et les valeurs du compteur de collisions (ifconfig) avant et après la
manipulation. **
  -  -- Serveur
    - Server listening on TCP port 5001
    - TCP window size: 85.3 KByte (default)
    - [  4] local 192.168.5.58 port 5001 connected with 192.168.5.57 port 48170
    - [ ID] Interval       Transfer     Bandwidth
    - [  4]  0.0-10.4 sec  8.12 MBytes  6.54 Mbits/sec
    - [  5] local 192.168.5.58 port 5001 connected with 192.168.5.57 port 48171
    - [  5]  0.0-10.6 sec  8.12 MBytes  6.45 Mbits/sec


  - --Avant
    - collisions:0, bande passante: 422.8 KiB, erreur 0
    - RX packets:4998 errors:0 dropped:0 overruns:0 frame:0
    - TX packets:3419 errors:0 dropped:0 overruns:0 carrier:0
    - collisions:0 lg file transmission:1000
    - RX bytes:4958497 (4.7 MiB)  TX bytes:432998 (422.8 KiB)
    - Interruption:20 Mémoire:f7d00000-f7d20000


  - --Apres
    - collisions:198 bande passante: 1.2 MiB, erreur 3
    - RX packets:25683 errors:0 dropped:0 overruns:0 frame:0
    - TX packets:15602 errors:3 dropped:0 overruns:0 carrier:3
    - collisions:198 lg file transmission:1000
    - RX bytes:32901097 (31.3 MiB)  TX bytes:1331282 (1.2 MiB)
    - Interruption:20 Mémoire:f7d00000-f7d20000
    - ------------------------------------------------------------
    Un hub trasmet le message a tous les pc présent sur le hub.

    Si deux requêtes sont envoyer en même temps => colision.

    - COMMUTATEUR
      - 1) On ne recoit pas les paquets qui ne nous sont pas destiné

        - --Avant
            - TX packets:15966 errors:3 dropped:0 overruns:0 carrier:3
            - collisions:198 lg file transmission:1000

        - --Apres
          - RX packets:107785 errors:0 dropped:0 overruns:0 frame:0
          - TX packets:56163 errors:3 dropped:0 overruns:0 carrier:3
          - collisions:198

Pas de colisions, pas d'erreur.

## ROUTEUR
1. Le ping passe par le routeur. L'adresse MAC source de la trame reçu est l'adresse MAC du routeur du côté de 192.168.1.0/24. L'adresse MAC de destination de la trame envoyée est l'adresse MAC du routeur du côté de 192.168.5.0/24.

2. (voir PDF)

3. Le ping ne passe pas par le routeur, mais tout le reste du réseau dans 192.168.5.0/24 (le routeur inclu) reçoit et répond au ping.

4. Le ping broadcast est impossible vers un autre réseau. Cependant, le routeur répond au ping à la place.

5. Le ping de broadcast destiné au réseau 192.168.5.0/24 arrive à destination des postes du réseau. Les adresses IP ne changent pas. L'option est désactivé par défaut pour éviter la surcharge réseau et pour la sécurité.

6. Unicast : 1 machine vers 1 machine.
    Diffusion limitée : Broadcast uniquement sur le réseau actuel.
    Diffusion dirigée : Broadcast redirigée vers d'autres réseau via le routeur.  


7. Un routeur ne transmet jamais les diffusions limitées (même reseaux)
Un routeur transmet les unicast => diffusion dirigés
			@src       @dst
	Mais pour des raisons de securité, ils sont en général configuré pour bloquer des diffusions dirigés

##  ARP

1. arp -s 192.168.5.59 98:90:96:bb:7f:ee

2. Le ping se dirige vers voisin 1 au lieu de voisin 2. Voisin 2 ne répond pas au ping puisque qu'il n'est normalement pas destiné à lui. Le cache ARP permet de savoir a quelle adresse phisique correspond une adresse IP, pour pouvoir compléter l'adresse de destination dans la trame.

3.
