#!/bin/sh

# exécution de LanceurAnalyseurSyntaxique
# texte à analyser ds un fichier
# nom du fichier passé en ligne de commande
#
# M. Nebut

#*******************************
# la classe contenant votre main
MAIN=logicline.executeurs.LanceurAnalyseurSyntaxique

#*******************************
java -cp lib/jflex-1.6.0.jar:lib/java-cup-11a.jar:classes $MAIN $1
