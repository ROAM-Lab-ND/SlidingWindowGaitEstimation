#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ANSI color codes for error and warning
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
SUCCEED="${GREEN}[Succeed]${NC} "
WARNING="${YELLOW}[Warning]${NC} "
ERROR="${RED}[ Error ]${NC} "
INFO="${BLUE}[ Info. ]${NC} "
INQUIRE="${MAGENTA}[Inquire]${NC} "
PROGRES="${CYAN}[Progres]${NC} "

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo -e "${INFO} To set specific compiler and/or Eigen dependency:"
    echo -e "${INFO}    ./setup.sh [COMPILER] [/PATH/TO/EIGEN]"
    exit 0
fi

echo -e "${INFO} Setting up build directory, C++ compiler, and Eigen path."

make_build=$(mkdir build 2>&1)
if [[ $? -eq 0 ]]; then
  echo -e "${SUCCEED} 'build' directioy has been created"
else
  echo -e "${WARNING} Something wrong: --> ${YELLOW}${make_build}${NC}"
#   echo -e "--"
#   read -p "Press enter to continue."
fi



# Generate config.mk
echo "# Configuration file for compiler and Eigen." > config.mk

# Check if the user has provided a compiler as an argument
if [ ! -z "$1" ]; then
    CC="$1"
else
    # Check for available compilers
    if command_exists g++; then
        CC="g++"
    elif command_exists clang++; then
        CC="clang++"
    else
        echo -e "${ERROR} Neither g++ nor clang++ found! Please install a C++ compiler or specify one."
        exit 1
    fi
fi

# Check if the selected compiler (CC) is linked to clang
if $CC --version 2>/dev/null | grep -q "clang"; then
    echo -e "${WARNING} Only clang++ is found or g++ is linked to clang++."
    echo -e "${INFO} Program compiled via clang++ is marginally slower than the on via g++."
    echo -e "${INQUIRE} Do you want to manually specify a different compiler? [y/N]: "
    read -r USER_INPUT

    if [[ "$USER_INPUT" =~ ^[Yy]$ ]]; then
        echo -e "${INQUIRE} Please enter the compiler command you want to use (e.g., g++-14, g++-12, cc): "
        read -r USER_CC
        CC="$USER_CC"
    fi
fi



echo -e "${SUCCEED} Selected compiler: $CC"
echo "# compiler" >> config.mk
echo "CC := $CC" >> config.mk


# Define Eigen path

# Check user definitation
if [ ! -z "$2" ]; then
    EIGEN_DIR="$2"
else
    # No user defined Eigen path
    if [ $(uname -s) == "Darwin" ]; then
        if [ -d "/usr/include/eigen3/" ]; then
            EIGEN_DIR="/usr/include/eigen3/"
        else
            # No Eigen at default path Trying to ask homebrew
            EIGEN_DIR=$(brew --prefix eigen 2>&1)/include/eigen3
            if [[ $? -eq 0 ]]; then
                echo -e "${SUCCEED} Found Eigen: $EIGEN_DIR"
            else
                echo -e "${WARNING} homebrew$EIGEN_DIR"
            fi
        fi
    else
        EIGEN_DIR="/usr/include/eigen3/"
    fi
fi


if [ -d "$EIGEN_DIR" ]; then
    # Found Eigen
    echo -e "${SUCCEED} Eigen: $EIGEN_DIR"
    echo "# Eigen" >> config.mk
    echo "EIGEN_FOUND = 1" >> config.mk
    echo "EIGEN_DIR = $EIGEN_DIR" >> config.mk
else
    echo -e "${WARNING} No Eigen library found, Eigen implementation will be disabled, carrying on."
    echo -e "${INFO} You can manually specify a Eigen path by run ./setup.h compiler /path/to/Eigen/"
    echo -e "              e.g. ./setup.h g++-14 /usr/include/eigen3"
    echo "# Eigen" >> config.mk
    echo "EIGEN_FOUND = 0" >> config.mk
    echo "EIGEN_DIR = $EIGEN_DIR" >> config.mk # Should not be used
fi


echo -e "${SUCCEED} Setup complete! You can now run 'make all' to build the project."

echo -e "${INFO} Then use './runtest.sh' to run test."