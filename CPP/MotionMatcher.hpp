#include <algorithm>
#include "helper.hpp"

class MotionMatcher {
public:
    size_t N;   // Length of kernel
    size_t m;   // Number of kernels (each one represent a channel)
    float * rk; // Duplicated rolling kernel, dim: 2Nxm
    float * A;  // Cache matrix, dim: NxN
    float * r;  // Result, dim: N
    int ind = 0;// Rolling index
    int match_ind = 0; // Index that best match


    /* Note: The rolling kernel is arranged in reverse order as:
       Original Kernel = [k0 k1 k2 k3 ... kN-3 kN-2 kN-1]
       Rolling kernel  = [k0 kN-1 kN-2 kN-3 ... k3 k2 k1]
       Kernel start with first element and reversely enumerate
       Then the kernel is duplicated to form array rk:
       rk = [k0 kN-1 kN-2 kN-3 ... k2 k1 k0 kN-1 kN-2 kN-3 ... k2 k1]
       ind:  0  1    2    3    ... N-2 N-1 N N+1 N+2  N+3  ... 2N-2 2N-1
       to improve the locality.
    */

    MotionMatcher (string kernel_path){
        loadKernel(kernel_path);
        init();
    }
    ~MotionMatcher () {
        #ifdef DEBUG
        cout << "Destructing MotionMatcher" << endl;
        #endif
        delete [] rk;
        delete [] A;
        delete [] r;
    }

    void init (){
        // Create and init cache matrix
        A = new float[N * N];
        for (int row = 0; row < N; row++){
            for (int col = 0; col < N; col++){
            A[row * N + col] = 0.0;
            }
        }
        
        // Create and init result array
        r = new float[N];
        for (size_t col = 0; col < N; col++){
            r[col] = 0;
        }

    }

    void loadKernel(string kernel_path){
    
        ///////// Load Kernel File //////////
        ifstream kernel_file(kernel_path, ios::in);
        
        string linestr;
        vector<string> line_split;
        vector<string> vector_split;

        vector_split.clear();
        getline(kernel_file,linestr);
        SplitString(linestr,vector_split,",");

        m = atoi(vector_split[1].c_str()); // Number of kernels
        N = atoi(vector_split[2].c_str()); // Length of kernel

        // Flush the header line
        getline(kernel_file,linestr);

        rk  = new float[m * 2 * N];
        float k[N][m];
        
        for (int i_time = 0; i_time < N; ++i_time){
            line_split.clear();
            vector_split.clear();
            getline(kernel_file,linestr);
            SplitString(linestr,vector_split,",");
            for (int i_kernel = 0; i_kernel < m; ++i_kernel){
                float temp = strtof(vector_split[i_kernel].c_str(), NULL);
                k[i_time][i_kernel] = temp;
                int ind_rolling = (i_time != 0) ? (N - i_time) : 0;
                rk[      ind_rolling * m + i_kernel] = temp;
                rk[(N + ind_rolling) * m + i_kernel] = temp;

                // #ifdef DEBUG
                // cout    << k[i_time][i_kernel] << ", ";
                // #endif //DEBUG
            }
            
            // #ifdef DEBUG
            // cout << endl;
            // #endif //DEBUG
        }
        
        
        kernel_file.close();
    }

    void testFunction(float* newdata) {
        disp(newdata);
        for (size_t i = 0; i < m; ++i){
            cout << newdata[i] << ", ";
        }
        cout << endl;
        

    }


    void pushData(float* newdata){
        for (size_t j = 0; j < N; ++j) {
            r[j] -= A[ind * N + j];
            float temp = 0.0;
            for (size_t i = 0; i < m; ++i) {
                float diff = rk[(N + j - ind) * m + i] - newdata[i]; // Good without pointer
                temp +=  diff * diff;
            }
            A[ind * N + j] = temp;
            r[j] += temp;
        }
        
        // step size is 1
        ind++;
        if (ind >= N) {
            ind -= N;
        }
        // ind = (ind + 1) % N;

        getMatchInd();

    }

    void getMatchInd() {
        float* minElement = min_element(r, r + N);
        match_ind = minElement - r - ind;
        if (match_ind < 0) {
            match_ind += N;
        }
    }

    float getGait() {
        float gait_pct = 1.0 - ((float)match_ind / N);
        return gait_pct;
    }

};