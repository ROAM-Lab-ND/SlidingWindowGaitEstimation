#!/bin/bash

./build/SSEtrick ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 5000 7000 ./CPPResult/Test_Trick.csv
./build/SSEplain ./Data/DataBase_CSV ./Data/Experiment_CSV/Multispeed_Walk_AB.csv 5000 7000 ./CPPResult/Test_Plain.csv