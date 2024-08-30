#include "helper.hpp"
#include "MotionMatcher.hpp"

int m, len;
float* sensor_data;
// float* newData;

void loadData(string kernel_path){

    ///////// Load data File //////////
    ifstream data_file(kernel_path, ios::in);
    
    string linestr;
    vector<string> line_split;
    vector<string> vector_split;

    vector_split.clear();
    getline(data_file,linestr);
    SplitString(linestr,vector_split,",");

    m = atoi(vector_split[1].c_str()); // Number of channels
    len = atoi(vector_split[2].c_str()); // Length of data

    // Flush the header line
    getline(data_file,linestr);

    sensor_data  = new float[m * len];
        
    #ifdef DEBUG
    cout << "sensor_data:" << endl;
    #endif //DEBUG
    
    for (int i_time = 0; i_time < len; ++i_time){
        line_split.clear();
        vector_split.clear();
        getline(data_file,linestr);
        SplitString(linestr,vector_split,",");
        for (int i_channel = 0; i_channel < m; ++i_channel){
            sensor_data[i_time * m + i_channel] = strtof(vector_split[i_channel].c_str(), NULL);

            // #ifdef DEBUG
            // cout    << sensor_data[i_time * m + i_channel] << ", ";
            // #endif //DEBUG
        }
        
        // #ifdef DEBUG
        // cout << endl;
        // #endif //DEBUG
    }
    
    
    data_file.close();
}

int main(){
    MotionMatcher test_matcher("/Users/whitebook/Desktop/ConvolutionGaitPhaseEstimation/Data/DataBase_CSV/Slow_AB_Reference.csv");
    loadData("/Users/whitebook/Desktop/ConvolutionGaitPhaseEstimation/Data/Experiment_CSV/Multispeed_Walk_AB.csv");

    int time_start = 5000;
    int time_end   = 7000;
    int dataLen = time_end - time_start;
    float gait_pct[dataLen];
  
    cout << "Start" << endl;
    auto start_total = high_resolution_clock::now();
    for (size_t i = time_start; i < time_end; ++i) {
        float* newData = sensor_data + (i * m);
        test_matcher.pushData(newData);
        gait_pct[i-time_start] = test_matcher.getGait();
    }  
    auto end_total   = high_resolution_clock::now();
    auto duration_total = duration_cast<microseconds>(end_total - start_total);
    double duration_total_time = double(duration_total.count());
    
    cout << "Total Time (us): " << duration_total_time << endl;
    cout << "Time Per Data (us): " << duration_total_time/dataLen << endl;
    cout << "Max Frequency (Hz): " << (1000000.0*dataLen)/duration_total_time << endl;

    // saveResult("./Result/Test.csv", test_matcher.r, test_matcher.N);
    saveResult("./Result/Test.csv", gait_pct, dataLen);

    delete [] sensor_data;
}