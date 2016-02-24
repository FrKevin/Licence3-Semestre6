# TP Réseaux


## Table des matières
- Les IP des différents réseaux
- Répartion des postes
- Tables des routeurs
- Configuration du matériel
- Test
- Taches

## Les IP des différents réseaux
- IP Global: 192.168.0.0/24
- Adresse du 1er réseau: 192.168.1.0/24
- Adresse du 2eme réseau: 192.168.2.0/24
- Adresse du 3eme réseau: 192.168.3.0/24
- Adresse du 3eme réseau: 192.168.4.0/24

## Répartion des postes
- Pour le réseau SJ1:
  - Poste 6: 192.168.3.16 (J4/1)
  - Poste 7: 192.168.3.17 (J5/1)
  - Poste 9: 192.168.3.19 (B3/1)
  - Poste 10: 192.168.3.20 (B4/1)
  - Poste 11: 192.168.3.21 (B5/1)
- Pour le réseau SJ2:
  - Poste 1: 192.168.4.11 (B1/1)
  - Poste 2: 192.168.4.12 (J2/1)
  - Poste 3: 192.168.4.13 (J1/1)
  - Poste 4: 192.168.4.14 (J2/1)
  - Poste 5: 192.168.4.15 (J3/1)

## Tables des routeurs
  - RJ1:
    - 192.168.3.0/24 | GE 0/0 | 192.168.1.2
    - 192.168.4.0/24 | GE 0/1 | 192.168.2.3
  - RJ2:
    - default | GE 0/0 | 192.168.1.1
  - RJ3:
    - default | Ge 0/0 | 192.168.2.1

## Configuration du matériel
- Pour les machines
  - sudo ifconfig eth0 192.168.X.Y/24
  - sudo route add default gw 192.168.X.Y
- Pour les routeurs
  - Acces a la console du routeur: minicom
  - ajout des routes: ip route 192.168.4.0 255.255.255.0 192.168.2.3

## Test
- ping:
  - Poste 6 > ping 192.168.4.13 (vers Poste 3)
  - Poste 6 > ping 192.168.4.15 (vers Poste 5)
  - Poste 5 > ping 192.168.3.16 (vers Poste 6)
  - Poste 3 > ping 192.168.3.16 (vers Poste 6)
  - Poste 5 > ping 192.168.4.11 (vers Poste 1)
  - Poste 9 > ping 192.168.3.20 (vers Poste 10)

## Taches
- Coordinateur: Marc Baloup
- rapport: Kevin Gamelin
- configuration routeur: Maxime Maroine  & Dorian (RJ1), Veis Oudjail (RJ3), Charles & Kevin Gallet  (RJ2)
- Montage: Kevin Morlet, Pierre, Jeremy, Lucile, Antoine
