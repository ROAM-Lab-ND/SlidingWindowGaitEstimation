#include "helper.hpp"

class MotionMatcher {
public:
    size_t N;   // Length of kernel
    size_t m;   // Number of kernels (each one represent a channel)
    unique_ptr<float[]> rk; // Duplicated rolling kernel, dim: 2Nxm
    unique_ptr<float[]> A;  // Cache matrix, dim: NxN
    unique_ptr<float[]> r;  // Result, dim: N
    int ind = 0;// Rolling index
    int match_ind = 0; // Index that best match
    float min_error = 0; // Minimum SSE error
    string kernel_name;  // Name of motion
    int kernel_id;      // ID of motion
    
    bool ready = false; // For future use (encapsulation): if we found init() function is necessary, 
    // we'd better check this at pushData() to avoid user error.


    /* Note: The rolling kernel is arranged in reverse order as:
       Original Kernel = [k0 k1 k2 k3 ... kN-3 kN-2 kN-1]
       Rolling kernel  = [k0 kN-1 kN-2 kN-3 ... k3 k2 k1]
       Kernel start with first element and reversely enumerate
       Then the kernel is duplicated to form array rk:
       rk = [k0 kN-1 kN-2 kN-3 ... k2 k1 k0 kN-1 kN-2 kN-3 ... k2 k1]
       ind:  0  1    2    3    ... N-2 N-1 N N+1 N+2  N+3  ... 2N-2 2N-1
       to improve the locality.
    */

    /* Note: reuslt cache r is not the actual matching result, the actual result start from 
       the ind-th element of r, where ind is the rolling index, then rolling as:
       actual result = r[ind] --> ... --> r[end] --> r[start] --> ... --> r[ind-1]
    */

    MotionMatcher () {
        // Do nothing. For array init.
    }

    MotionMatcher (string kernel_path) {
        loadKernel(kernel_path);
        initCache();
        clearCache();
        ready = true;
    }

    void init (string kernel_path) {
        loadKernel(kernel_path);
        initCache();
        clearCache();
        ready = true;
    }

    void initCache () {
        // Create cache matrix
        A.reset(new float[N * N]); // = new float[N * N];
        // Create result array
        r.reset(new float[N]); // = new float[N];
    }

    void clearCache (){
        // Reset index
        ind = 0;
        
        // Clear cache matrix
        for (int row = 0; row < N; row++){
            for (int col = 0; col < N; col++){
                A[row * N + col] = 0.0;
            }
        }
        
        // Clear result array
        for (size_t col = 0; col < N; col++){
            r[col] = 0;
        }

    }

    void loadKernel(string kernel_path) {
    
        ///////// Load Kernel File //////////
        ifstream kernel_file(kernel_path, ios::in);

        string linestr;
        vector<string> line_split;
        vector<string> field_split;
        vector<string> vector_split;

        bool hasDim = false;
        getline(kernel_file,linestr);
        SplitString(linestr,line_split,";");
        for (const string& line_split_str : line_split) {
            field_split.clear();
            SplitString(line_split_str,field_split,":");
            if (field_split[0] == "Name") {
                kernel_name = field_split[1]; // Name of motion
            }else if (field_split[0] == "ID") {
                kernel_id = atoi(field_split[1].c_str()); // ID of motion
            }else if (field_split[0] == "Dimension") {
                vector_split.clear();
                SplitString(field_split[1],vector_split,"x");
                m = atoi(vector_split[0].c_str()); // Number of kernels
                N = atoi(vector_split[1].c_str()); // Length of kernel
                hasDim = true;
                #ifdef DETAIL_PRINT
                disp(m);
                disp(N);
                #endif
            }else {
                #ifdef DEBUG
                cout << "Warning while reading csv file: " << kernel_path << endl;
                cout << "Unknown field in header term: " << line_split_str << endl;
                #endif
            }
        }

        if (!hasDim) {
            std::cerr << "Error whiler eading csv file: " << kernel_path << std::endl;
            std::cerr << "Dimensions are not defined" << std::endl;
            exit(1);
        }

        // Flush the header line for signal name
        // Can be used for future
        getline(kernel_file,linestr);

        rk.reset(new float[m * 2 * N]); //  = new float[m * 2 * N];
        #ifdef DETAIL_PRINT
        float k[N][m];
        #endif //DETAIL_PRINT
        
        for (int i_time = 0; i_time < N; ++i_time){
            line_split.clear();
            vector_split.clear();
            getline(kernel_file,linestr);
            SplitString(linestr,vector_split,",");
            for (int i_kernel = 0; i_kernel < m; ++i_kernel){
                float temp = strtof(vector_split[i_kernel].c_str(), NULL);
                #ifdef DETAIL_PRINT
                k[i_time][i_kernel] = temp;
                #endif //DETAIL_PRINT
                int ind_rolling = (i_time != 0) ? (N - i_time) : 0;
                rk[      ind_rolling * m + i_kernel] = temp;
                rk[(N + ind_rolling) * m + i_kernel] = temp;

                #ifdef DETAIL_PRINT
                cout    << k[i_time][i_kernel] << ", ";
                #endif //DETAIL_PRINT
            }
            
            #ifdef DETAIL_PRINT
            cout << endl;
            #endif //DETAIL_PRINT
        }
        
        
        kernel_file.close();
    }

    float pushData(const float* newdata) {
        float temp, diff;
        for (size_t j = 0; j < N; ++j) {
            r[j] -= A[ind * N + j];
            temp = 0.0;
            for (size_t i = 0; i < m; ++i) {
                diff = rk[(N + j - ind) * m + i] - newdata[i]; // Good without pointer
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

        return getMatch();

    }

    float getMatch() {
        float* minError = min_element(r.get(), r.get() + N);
        min_error = *minError;
        match_ind = (minError - r.get()) - ind; // Shifted by ind
        if (match_ind < 0) {
            match_ind += N;
        }
        return min_error;
    }

    float getGait() {
        float gait_pct = 1.0 - ((float)match_ind / N);
        return gait_pct;
    }

    int getID() {
        return kernel_id;
    }

    string getName() {
        return kernel_name;
    }

};