CFLAGS += -std=gnu99 -g

z0parser: parser.tab.o lex.yy.o
	$(CC) $^ -o $@

tools/astgen-yacc4spl:
	GOPATH=$(PWD)/tools/go go get -u github.com/zarevucky/astgen/tools/astgen-yacc4spl
	mv tools/go/bin/astgen-yacc4spl tools

cat.def: ../spec/*.def
	cat $^ > $@

parser.y: tools/astgen-yacc4spl cat.def
	tools/astgen-yacc4spl cat.def > $@

parser.tab.c parser.tab.h: parser.y
	bison -t -d --report=all parser.y

lex.yy.c: parser.lex parser.tab.h
	flex parser.lex

clean:
	rm -rf parser.tab.o lex.yy.o parser.tab.c parser.tab.h parser.output lex.yy.c parser.y cat.def z0parser tools
