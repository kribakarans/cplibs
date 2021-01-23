
# GNU Makefile

EXE = cplibs
SRC = cplibs.sh
BIN = $(HOME)/bin

all:
	bash -n $(SRC)

install:
	install -d $(BIN)
	install -D $(SRC) $(BIN)/$(EXE)

uninstall:
	rm -f $(BIN)/$(EXE)

help:
	@echo "make [OPTIONS]"
	@echo "     -- all"
	@echo "     -- install"
	@echo "     -- uninstall"
	@echo "     -- help"
