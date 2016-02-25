#!/bin/sh

# exécution de LanceurAnalyseurSyntaxique
# texte à analyser en ligne
#
# M. Nebut 


#*******************************

# la classe contenant votre main
MAIN=logicline.executeurs.LanceurAnalyseurSyntaxique

#*******************************

echo "Entrez le texte à analyser :"
java -cp lib/jflex-1.6.0.jar:lib/java-cup-11a.jar:classes $MAIN
