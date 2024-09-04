#include <sys/types.h>
#include <dirent.h>
#include <string>
#include <iostream>
#include <cstring>
#include <vector>
#include "helper.hpp"

// #define MODE MODE_TRICK
#define MODE_PLAIN 0
#define MODE_TRICK 1


#ifdef MODE
    #if MODE == MODE_PLAIN
        // Compiling motion matcher with plain mode (no computation saving)
        #include "MotionMatcher_Plain.hpp"
        // #error "PLAIN is under dev."
    #elif MODE == MODE_TRICK
        // Compiling motion matcher with trick mode (with computation saving)
        #include "MotionMatcher_Trick.hpp"
    #else
        #error "Bad MODE definitation, must be MODE_PLAIN or MODE_TRICK"
    #endif
#else
    #error "MODE is not defined"
#endif

int m, len;
float* sensor_data;
float* newData;

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
        
    // #ifdef DEBUG
    // cout << "sensor_data:" << endl;
    // #endif //DEBUG
    
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

std::vector<std::string> getCSVFilesInFolder(const std::string& folderPath) {
    std::vector<std::string> csvFiles;
    DIR *dir;
    struct dirent *ent;
    if ((dir = opendir(folderPath.c_str())) != NULL) {
        while ((ent = readdir(dir)) != NULL) {
            std::string filename = ent->d_name;
            if (filename.length() >= 4 && 
                filename.compare(filename.length() - 4, 4, ".csv") == 0) {
                std::string filePath = folderPath + "/" + filename;
                csvFiles.push_back(filePath);
            }
        }
        closedir(dir);
    } else {
        perror("Unable to open directory");
    }
    return csvFiles;
}

int main(int argc, char* argv[]){
    if (argc < 6) {
        std::cerr << "Usage: program_name path_to_motion_lib data_file time_start time_end output_file" << std::endl;
        return 1; // Return error code to indicate insufficient args
    }

    string motionLibPath = argv[1];
    string dataFile = argv[2];
    int time_start = stoi(argv[3]);
    int time_end = stoi(argv[4]);
    string outputFileName = argv[5];

    // std::vector<std::string> csvFiles = getCSVFilesInFolder(motionLibPath);
    getCSVFilesInFolder(motionLibPath);


    // Load motion library
    int num_motion = 1;//csvFiles.size();
    vector<MotionMatcher> motion_lib;
    motion_lib.reserve(num_motion);
    // for(const auto& file : csvFiles) {
    //     motion_lib.emplace_back(file);
    // }
    for (size_t i_motion = 0; i_motion < num_motion; ++i_motion) {
        motion_lib.emplace_back("/Users/whitebook/Desktop/ConvolutionGaitPhaseEstimation/Data/DataBase_CSV/Slow_AB_Reference.csv");
    }

    float* motion_score = new float[num_motion];
    
    // Load experiment data
    loadData(dataFile);

    // Set a reasonalbe interval for test
    int dataLen = time_end - time_start;
    float gait_pct[dataLen];
  
    cout << "Start" << endl;
    float* best_motion;
    int motion_index;
    auto start_total = high_resolution_clock::now();
    for (size_t i = time_start; i < time_end; ++i) {
        // Each data frame
        newData = sensor_data + (i * m);
        for (size_t i_motion = 0; i_motion < num_motion; ++i_motion) {
            motion_score[i_motion] = motion_lib[i_motion].pushData(newData);
        }
        best_motion = min_element(motion_score, motion_score + num_motion);
        motion_index = best_motion - motion_score;
        gait_pct[i-time_start] = motion_lib[motion_index].getGait();
    }  
    auto end_total   = high_resolution_clock::now();
    auto duration_total = duration_cast<microseconds>(end_total - start_total);
    double duration_total_time = double(duration_total.count());
    
    cout << "Total Time (us): " << duration_total_time << endl;
    cout << "Time Per Data (us): " << duration_total_time/dataLen << endl;
    cout << "Max Frequency (Hz): " << (1000000.0*dataLen)/duration_total_time << endl;

    // saveResult(outputFileName, test_matcher.r, test_matcher.N);
    saveResult(outputFileName, gait_pct, dataLen);

    delete [] sensor_data;
    delete [] motion_score;
    
    return 0;
}