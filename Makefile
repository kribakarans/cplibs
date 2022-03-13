
# GNU Makefile

EXE = cplibs
SRC = cplibs.sh
BIN = $(HOME)/bin

all:
	bash -n $(SRC)

install:
	install -D $(SRC) $(BIN)/$(EXE)

uninstall:
	rm -f $(BIN)/$(EXE)

clean:

help:
	@echo "make [OPTIONS]"
	@echo "     -- all"
	@echo "     -- install"
	@echo "     -- uninstall"
	@echo "     -- help"
