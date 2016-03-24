###   DATA   ###
TP=5
NOM1=Gamelin
NOM2=Oudjail
### END DATA ###

all: Interprete

Interprete: Interprete.hs
	ghc --make Interprete.hs

clean:
	rm -rf *~ *.hi *.o Interprete

## Permet de creer une archive coforme pour le depot PDS
archive: clean
	zip -r TP${TP}_${NOM1}_${NOM2}.zip *
