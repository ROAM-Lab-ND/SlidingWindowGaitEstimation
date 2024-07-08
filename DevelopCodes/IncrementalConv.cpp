#include <iostream>
#include <chrono>
#include <thread>
#include <stdlib.h>
using namespace std;
using namespace chrono;
#define N 1000
#define dataLen 10000 // data length


float k[2*N]; // kernel
float A[N][N]; // cache matrix
float data[dataLen]; // dummy sensing data
float* ke = &k[N];
  
void init(){
  
  
  // Init A matrix
  for (int row = 0; row < N; row++){
    for (int col = 0; col < N; col++){
      A[row][col] = 0;
    }
  }
  
  // Random gen kernel
  for (int col = 0; col < N; col++){
    k[col] = (float) (rand() % 1000); // Limit to 1000
    k[N+col] = (float) (rand() % 1000); // Limit to 1000
    /* Note: The kernel is arranged in reverse order as:
       Kernel = [k1 kN kN-1 kN-2 ... k3 k2]
       Kernel start with first element and reversely enumerate
       Then the kernel is duplicated to form array k:
       k = [k1 kN kN-1 kN-2 ... k3 k2 k1 kN kN-1 kN-2 ... k3 k2]
       to improve the locality.
    */
  }
  
  for (size_t i = 0; i < dataLen; i++) {
    data[i] = (float) (rand() % 1000); // Limit to 1000
  }
}

void Conv(){
  float c[N]; // conv result
  // float w[N]; // data window
  for (size_t col = 0; col < N; col++){
    c[col] = 0;
    // w[col] = 0;
  }
    
  

  int index = 0; // index of the circular data
  float newdata = 0;
    
  for (size_t i = 0; i < dataLen; i++) {
    newdata = data[i];
    // w[index] = newdata;
    for (size_t j = 0; j < N; j++) {
      c[j] -= A[index][j];
      // A[index][j] = (*(ke+j-index)) * newdata; // Good but use pointer
      A[index][j] = k[(N+j-index)] * newdata; // Good without pointer
      // A[index][j] = k[(j-index) % N] * newdata; // Bad since modulo operation and locality of reference
      c[j] += A[index][j];
    }
    
    // step size is 1
    index++;
    if (index >= N) {
      index -= N;
    }
    // index = (index + 1) % N;
  }
  
}


int main(){
  
  init();
  
  cout << "Start" << endl;
  auto start_total = high_resolution_clock::now();
  
  Conv();
  
  auto end_total   = high_resolution_clock::now();
  auto duration_total = duration_cast<microseconds>(end_total - start_total);
  double duration_total_time = double(duration_total.count());
  
  cout << "Total Time (us): " << duration_total_time << endl;
  cout << "Time Per Data (us): " << duration_total_time/dataLen << endl;
  cout << "Max Frequency (Hz): " << (1000000.0*dataLen)/duration_total_time << endl;
  
  return 0;
}
