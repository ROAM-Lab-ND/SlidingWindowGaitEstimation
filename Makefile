BUILDPATH=./build/

CC=clang++

HEADERS=$(shell find ./CPP -type f -name *.hpp)

$(BUILDPATH)main: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -g -O3 -march=native CPP/main.cpp -o $(BUILDPATH)main

.PHONY : all
all: $(BUILDPATH)main

.PHONY : clean
clean:
	-rm -rf $(BUILDPATH)