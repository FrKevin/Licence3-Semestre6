JAVA=java
JAVAC=javac
JAVAFLAGS= -cp lib/jflex-1.6.0.jar:lib/java-cup-11a.jar:classes
LEX=$(JAVA) -jar lib/jflex-1.6.0.jar
CUP=$(JAVA) -jar lib/java-cup-11a.jar

PACKAGE=logicline

TARGETDIR=src/$(PACKAGE)/analyseurs/
SPECDIR=spec/

LEXFILE=lexiqueLogic.lex
LEXER=ScannerLogic


CUPFILE=syntaxeLogic.cup
PARSER=ParserLogic

.PHONY: all clean

all: $(TARGETDIR)$(LEXER).java $(TARGETDIR)$(PARSER).java
	$(JAVAC) $(JAVAFLAGS) -d classes `ls */$(PACKAGE)/*/*.java`

$(TARGETDIR)$(LEXER).java: $(SPECDIR)$(LEXFILE)
	$(LEX) $(SPECDIR)$(LEXFILE)
	mv $(SPECDIR)$(LEXER).java $@

$(TARGETDIR)$(PARSER).java: $(SPECDIR)$(LEXFILE) $(SPECDIR)$(CUPFILE)
	$(CUP) -parser $(PARSER) -symbols TypeSymboles $(SPECDIR)$(CUPFILE)
	mv TypeSymboles.java $(PARSER).java $(TARGETDIR)

clean:
	rm -rf classes/*  $(TARGETDIR)$(LEXER).java $(TARGETDIR)$(PARSER).java