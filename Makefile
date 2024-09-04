BUILDPATH=./build/

CC=clang++

HEADERS=$(shell find ./CPP -type f -name *.hpp)

$(BUILDPATH)main: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -g -O3 -march=native CPP/main.cpp -o $(BUILDPATH)main

$(BUILDPATH)SSEplain: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -g -O3 -march=native -fsanitize=address -D MODE=MODE_PLAIN CPP/main.cpp -o $(BUILDPATH)SSEplain

$(BUILDPATH)SSEtrick: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -g -O3 -march=native -fsanitize=address -D MODE=MODE_TRICK CPP/main.cpp -o $(BUILDPATH)SSEtrick

.PHONY : all
all: $(BUILDPATH)SSEtrick $(BUILDPATH)SSEplain

.PHONY : clean
clean:
	-rm -rf $(BUILDPATH)*