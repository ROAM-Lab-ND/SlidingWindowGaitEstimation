#!/bin/bash

echo "Warmup"
./build/SSEtrick ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 4000 7000 ./CPPResult/Test_Trick.csv
echo "Speed Comparison:"
./build/SSEtrick ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 4000 7000 ./CPPResult/Test_Trick.csv
./build/SSEtrickEigen ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 4000 7000 ./CPPResult/Test_Trick_Eigen.csv
./build/SSEplain ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 4000 7000 ./CPPResult/Test_Plain.csv
./build/SSEplainEigen ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 4000 7000 ./CPPResult/Test_Plain_Eigen.csv