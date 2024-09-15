
# NAME HERE
[![standard-readme compliant](https://img.shields.io/badge/ICRA-2025-orange.svg?style=flat)](https://ieee-iros.org)

<!-- Simultaneous Locomotion Mode Classification and Continuous Gait
Phase Estimation for Transtibial Prostheses -->

Example code of \
_**Simultaneous Locomotion Mode Classification and Continuous Gait Phase Estimation for Transtibial Prostheses**_\
Ryan R. Posh* $^1$, Shenggao Li* $^2$, Patrick M. Wensing $^2$



## Background

Recognizing and identifying human locomotion is a critical step to ensuring fluent control of wearable robots, such as transtibial prostheses. In particular, classifying the intended locomotion mode and estimating the gait phase are key. In this work, a novel, interpretable, and computationally efficient algorithm is presented for simultaneously predicting locomotion mode and gait phase. Using able-bodied (AB) and transtibial prosthesis (PR) data, seven locomotion modes are tested including slow, medium, and fast level walking (0.6, 0.8, and 1.0 m/s), ramp ascent/descent (5 degrees), and stair ascent/descent (20 cm height). Overall classification accuracy was 99.1$\%$ and 99.3$\%$ for the AB and PR conditions, respectively. The average gait phase error was less than 4$\%$ across all data. Exploiting the structure of the historical data, coumputational efficiency reached 2.91 $\mu$s per time step. The time complexity of this algorithm scales as $\mathcal{O}(N\cdot M)$ with the number of locomotion modes $M$ and samples per gait cycle $N$. This efficiency and high accuracy could accommodate a much larger set of locomotion modes ($\sim$ 700 on OpenSource Leg Prosthesis) to handle the wide range of activities pursued by individuals during daily living.



## Dependencies and Requirements

- OS: Crossplatform, but tested on MacOSX or Linux (x86/x64 and/or ARM)
- C++ Compiler: g++ (recommended) or clang++
	> g++ compiled code in our test is 10~20% faster than the clang++ compiled one
- [Eigen][24aab043] - (Optional) for implementation using Eigen library.
	> Eigen is a header library for linear algebra. It provides explicit vectorization for matrix operations and is better optimized. Therefore, it reduce the computation time of naive/plain approach to a fraction of pointer implementation.
		The setup script would tell makefile to skip Eigen implementation if no Eigen library is found.
- [MATLAB][4b980ec4] - For converting, processing, and plotting data.
	> We use [PopIn][63a823c4] to read and converting .yaml format data in MATLAB.
		The setup script can automatically download it to directory [`MATLAB/PopIn`](MATLAB/PopIn)




[4b980ec4]: https://matlab.mathworks.com "Matlab"

[63a823c4]: https://www.mathworks.com/matlabcentral/fileexchange/45376-davidmercier-popin "PopIn"

[24aab043]: https://eigen.tuxfamily.org "Eigen"




## Getting Started

### Install

Download this project
```
git clone https://github.com/ROAM-Lab-ND/xxxx.git
cd xxxx
```

Run the setup script and follow the instruction to configure compiler and Eigen.
```
./setup.sh
```
or specify a compiler and Eigen path
```
./setup.sh [COMPILER] [/PATH/TO/EIGEN]
```

##### Available Makefile commands

1. `make clean` to remove all compiling and executable files of this project.
2. `make all` to compile all.




### Run Example

- Run the script to test the C++ code:
```
./runtest.sh
```
The computation time would be output as
> Start: Trick (moving window) - pointer implementation
Total Time (us): 10073
Time Per Data (us): 3.35767
- Or run the MATLAB script [`MATLAB/SSE_without_savings.m`](MATLAB/SSE_without_savings.m) to run the MATLAB implementation. 
- Script [`MATLAB/DebugTest/CPPClassificationTest.m`](MATLAB/DebugTest/CPPClassificationTest.m) will compare the result between C++ and MATLAB implementation

### Flag Definitions 
We have four different implementations with two set of flags: Trick/Plain and Homemade/Eigen.
Suppose we have $M$ activities and each activity has $N$ data.
- **Trick** - using sliding window trick, time complexity $\mathcal{O}(N\cdot M)$, space complexity $\mathcal{O}(M\cdot N^2)$.
- **Plain** - (a.k.a., **Naive** in paper) no computation save, compute SSE from scratch, time complexity $\mathcal{O}(M\cdot N^2)$, space complexity $\mathcal{O}(N\cdot M)$.
- **Homemade** - (i.e., **pointer**) store and compute array/matrix with pointer, probably less overhead.
- **Eigen** - store array/matrix with Eigen array type, and compute with Eigen function, better vectorization due to explicit AVX/SIMD call, cleaner expression.

## C++ Implementation Usage

Direct call C++ program via command line.
`./build/SSExxxxx /DIR/OF/DATABASE/ /PATH/TO/EXPERIMENT/DATA/ INDEX_START INDEX_END /PATH/TO/RESULT/FILE` 
For example: 
`./build/SSEtrick ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 4000 7000 ./CPPResult/Test_Trick.csv`




## Citation

```
{
...
}
```



### Contact

$^{1}$ University of Michigan, Ann Arbor, MI, US. poshr@umich.edu\
$^{2}$ University of Notre Dame, South Bend, IN, US. \{sli25,pwensing\}@nd.edu
