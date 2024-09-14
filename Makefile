BUILDPATH=./build/

CC=g++-14
# CC=clang++
IPATHS=-I $(shell brew --prefix eigen)/include/eigen3

HEADERS=$(shell find ./CPP -type f -name *.hpp)

$(BUILDPATH)main: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -g -O3 -march=native CPP/main.cpp -o $(BUILDPATH)main

$(BUILDPATH)SSEplain: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native -D MODE=MODE_PLAIN CPP/main.cpp -o $(BUILDPATH)SSEplain

$(BUILDPATH)SSEtrick: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native -D MODE=MODE_TRICK CPP/main.cpp -o $(BUILDPATH)SSEtrick

$(BUILDPATH)SSEplainEigen: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native $(IPATHS) -D MODE=MODE_PLAIN_EIGEN CPP/main.cpp -o $(BUILDPATH)SSEplainEigen

$(BUILDPATH)SSEtrickEigen: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native $(IPATHS) -D MODE=MODE_TRICK_EIGEN CPP/main.cpp -o $(BUILDPATH)SSEtrickEigen

.PHONY : all
all: $(BUILDPATH)SSEtrick $(BUILDPATH)SSEplain $(BUILDPATH)SSEplainEigen $(BUILDPATH)SSEtrickEigen

.PHONY : clean
clean:
	-rm -rf $(BUILDPATH)*