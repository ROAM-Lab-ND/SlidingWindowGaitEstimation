#ifndef HELPER_HPP
#define HELPER_HPP

#include <iostream>
#include <cstdio>
#include <fstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <iomanip>
#include <cmath>

#include <chrono>

#define DEBUG

using namespace std;
using namespace chrono;

#define disp(x) cout<<#x<<"="<<endl<<x<<endl
#define dispN(x,n) cout<<#x<<"="<<endl;for(int i=0;i<n;++i){cout<<x[i]<<endl;}

#define csvout(outport,x,flag) if(flag){outport << #x <<",";}else{outport<<setprecision(12)<<x<<",";}
#define csvoutN(outport,x,n,flag)                                     \
                    if(flag){                                         \
                      for(int i=0;i<n;++i){                           \
                        outport << #x << "{" << i <<"}/" << n << ","; \
                      }                                               \
                    }else{                                            \
                      for(int j=0;j<n;++j){outport<<x[j]<<",";}       \
                    }


void SplitString(const string& s, vector<string>& v, const string& c)
{
  std::string::size_type pos1, pos2;
  pos2 = s.find(c);
  pos1 = 0;
  while(std::string::npos != pos2)
  {
    v.push_back(s.substr(pos1, pos2-pos1));
   
    pos1 = pos2 + c.size();
    pos2 = s.find(c, pos1);
  }
  if(pos1 != s.length())
    v.push_back(s.substr(pos1));
}



void saveResult(string file_path, float* data, int data_length){
    cout<<setiosflags(ios::fixed); 
    ofstream csvLog;
    csvLog.open(file_path);
    csvLog << "Test" << ", ";
    csvLog << "\n";
    for (size_t i_time = 0; i_time < data_length; i_time++) {
        csvout(csvLog,data[i_time],false);
        csvLog << "\n";
    }
    csvLog.close();

}



#endif