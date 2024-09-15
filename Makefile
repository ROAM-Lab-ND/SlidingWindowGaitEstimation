-include config.mk
# config.mk defines: CC, EIGEN_FOUND, and EIGEN_DIR

BUILDPATH=./build/

IPATHS=-I $(EIGEN_DIR)

HEADERS=$(shell find ./CPP -type f -name *.hpp)

TARGETS := $(BUILDPATH)SSEtrick $(BUILDPATH)SSEplain
# If Eigen is found, add the Eigen-dependent targets
ifeq ($(EIGEN_FOUND), 1)
    TARGETS += $(BUILDPATH)SSEplainEigen $(BUILDPATH)SSEtrickEigen
endif

$(BUILDPATH)SSEplain: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native -D MODE=MODE_PLAIN CPP/main.cpp -o $(BUILDPATH)SSEplain

$(BUILDPATH)SSEtrick: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native -D MODE=MODE_TRICK CPP/main.cpp -o $(BUILDPATH)SSEtrick

$(BUILDPATH)SSEplainEigen: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native $(IPATHS) -D MODE=MODE_PLAIN_EIGEN CPP/main.cpp -o $(BUILDPATH)SSEplainEigen

$(BUILDPATH)SSEtrickEigen: CPP/main.cpp $(HEADERS)
	$(CC) -std=c++11 -O3 -march=native $(IPATHS) -D MODE=MODE_TRICK_EIGEN CPP/main.cpp -o $(BUILDPATH)SSEtrickEigen

.PHONY : all
all: $(TARGETS)

.PHONY : clean
clean:
	-rm -rf $(BUILDPATH)*