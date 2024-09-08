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
#define MODE_PLAIN_EIGEN 2
#define MODE_TRICK_EIGEN 3

#define CLASSIFICATION

#ifdef MODE
    #if MODE == MODE_PLAIN
        // Compiling motion matcher with plain mode (no computation saving)
        #include "MotionMatcher_Plain.hpp"
        // #error "PLAIN is under dev."
    #elif MODE == MODE_TRICK
        // Compiling motion matcher with trick mode (with computation saving)
        #include "MotionMatcher_Trick.hpp"
    #elif MODE == MODE_PLAIN_EIGEN
        // Compiling motion matcher with plain mode (no computation saving)
        #include "MotionMatcher_Plain_Eigen.hpp"
        // #error "PLAIN is under dev."
    #elif MODE == MODE_TRICK_EIGEN
        // Compiling motion matcher with trick mode (with computation saving)
        #include "MotionMatcher_Trick_Eigen.hpp"
    #else
        #error "Bad MODE definitation, must be MODE_PLAIN, MODE_TRICK, MODE_PLAIN_EIGEN, or MODE_TRICK_EIGEN"
    #endif
#else
    #error "MODE is not defined"
#endif

int m, len;
float* sensor_data;
float* newData;

void loadData(string data_path){

    ///////// Load data File //////////
    ifstream data_file(data_path, ios::in);
    
    string linestr;
    vector<string> line_split;
    vector<string> field_split;
    vector<string> vector_split;

    bool hasDim = false;
    getline(data_file,linestr);
    SplitString(linestr,line_split,";");
    for (const string& line_split_str : line_split) {
        field_split.clear();
        SplitString(line_split_str,field_split,":");
        if (field_split[0] == "Name") {
            // Do nothing
        }else if (field_split[0] == "ID") {
            // Do nothing
        }else if (field_split[0] == "Dimension") {
            vector_split.clear();
            SplitString(field_split[1],vector_split,"x");
            m = atoi(vector_split[0].c_str()); // Number of channels
            len = atoi(vector_split[1].c_str()); // Length of data
            hasDim = true;
        }else {
            #ifdef DEBUG
            cout << "Warning while reading csv file: " << data_path << endl;
            cout << "Unknown field in header term: " << line_split_str << endl;
            #endif
        }
    }

    if (!hasDim) {
        std::cerr << "Error whiler eading csv file: " << data_path << std::endl;
        std::cerr << "Dimensions are not defined" << std::endl;
        exit(1);
    }

    // Flush the header line for signal name
    // Can be used for future
    getline(data_file,linestr);

    sensor_data  = new float[m * len];
        
    // #ifdef DEBUG
    // cout << "sensor_data:" << endl;
    // #endif //DEBUG
    
    for (int i_time = 0; i_time < len; ++i_time){
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

    std::vector<std::string> csvFiles = getCSVFilesInFolder(motionLibPath);


    // Load motion library
    vector<MotionMatcher> motion_lib;
    #ifdef CLASSIFICATION
    int num_motion = csvFiles.size();
    motion_lib.reserve(num_motion);
    for(const auto& file : csvFiles) {
        motion_lib.emplace_back(file);
    }
    #else
    int num_motion = 1;
    motion_lib.reserve(num_motion);
    for (size_t i_motion = 0; i_motion < num_motion; ++i_motion) {
        motion_lib.emplace_back("/Users/whitebook/Desktop/ConvolutionGaitPhaseEstimation/Data/DataBase_CSV/Slow_AB_Reference.csv");
    }
    #endif

    float* motion_score = new float[num_motion];
    
    // Load experiment data
    loadData(dataFile);

    // Set a reasonalbe interval for test
    int dataLen = time_end - time_start;
    float gait_pct[dataLen];
    int  motion_ID[dataLen];
  
    cout << "Start" << endl;
    float* best_motion;
    int motion_index;
    auto start_total = high_resolution_clock::now();
    for (size_t i = time_start; i < time_end; ++i) {
        // Each data frame

        #ifdef DETAIL_PRINT
        cout << "Tiem step:" << i << endl;
        #endif //DETAIL_PRINT
        newData = sensor_data + (i * m);
        for (size_t i_motion = 0; i_motion < num_motion; ++i_motion) {
            motion_score[i_motion] = motion_lib[i_motion].pushData(newData);
        }
        best_motion = min_element(motion_score, motion_score + num_motion);
        motion_index = best_motion - motion_score;
        gait_pct[i-time_start] = motion_lib[motion_index].getGait();
        motion_ID[i-time_start] = motion_lib[motion_index].getID();
    }  
    auto end_total   = high_resolution_clock::now();
    auto duration_total = duration_cast<microseconds>(end_total - start_total);
    double duration_total_time = double(duration_total.count());
    
    cout << "Total Time (us): " << duration_total_time << endl;
    cout << "Time Per Data (us): " << duration_total_time/dataLen << endl;
    cout << "Max Frequency (Hz): " << (1000000.0*dataLen)/duration_total_time << endl;

    // saveResult(outputFileName, test_matcher.r, test_matcher.N);
    saveResult(outputFileName, gait_pct, motion_ID, dataLen);

    delete [] sensor_data;
    delete [] motion_score;
    
    return 0;
}