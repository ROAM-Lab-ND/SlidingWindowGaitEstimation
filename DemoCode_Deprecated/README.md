
Compile command:

- GCC: 

  `g++ -std=c++11 -O3 -march=native IncrementalConv.cpp -o IncrementalConv`
  
  Or on MacOS: `g++-13 -std=c++11 -O3 -march=native IncrementalConv.cpp -o IncrementalConv` where 13 is the version of your gcc.
- Clang:

  `clang++ -std=c++11 -O3 -march=native IncrementalConv.cpp -o IncrementalConv`
  
Note: gcc seems to be a little bit faster than clang on my machine.
