# Makefile for Calculator Project
# Handles shared library for Python GUI and standalone C++ CLI

CXX = g++
CXXFLAGS = -fPIC -Wall
LDFLAGS = -shared
ARITH_SRC = calculations/arithmetics.cpp
MAIN_SRC = calculations/main.cpp
LIB_NAME = flutter_gui/libarith.dylib
CLI_NAME = calculations/calc
FLUTTER = flutter

.PHONY: all lib cli clean run

all: lib cli

lib: $(LIB_NAME)

$(LIB_NAME): $(ARITH_SRC)
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $@ $^

cli: $(CLI_NAME)

$(CLI_NAME): $(MAIN_SRC) $(ARITH_SRC)
	$(CXX) $(CXXFLAGS) -o $@ $^

run: lib
	@echo "Note: Flutter SDK required to run"
	cd flutter_gui && $(FLUTTER) run -d macos

clean:
	rm -f $(LIB_NAME) $(CLI_NAME)
