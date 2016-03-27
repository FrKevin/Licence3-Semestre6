BINS:=FibEul Echo Echo2 Interblocage Philosophes

_: ${BINS}

%: %.hs
	ghc -O2 -threaded -eventlog $^

clean:
	rm ${BINS} *.hi *.o
