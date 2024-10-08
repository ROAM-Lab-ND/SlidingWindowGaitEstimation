

% Set database path
csvpath = "../Data/DataBase_CSV/";
if ~exist(csvpath,'dir')
    % if dir doesn't exist, create one
    mkdir(csvpath);
end
% Clear all existing files under the datapath
system("rm -rf "+csvpath+"*");

YAML2CSV('Slow_AB_Reference.yaml', 1, "Slow", csvpath);
YAML2CSV('Med_AB_Reference.yaml', 2, "Med", csvpath);
YAML2CSV('Fast_AB_Reference.yaml', 3, "Fast", csvpath);
YAML2CSV('RA_AB_Reference.yaml', 4, "RA", csvpath);
YAML2CSV('RD_AB_Reference.yaml', 5, "RD", csvpath);
YAML2CSV('SA_AB_Reference.yaml', 6, "SA", csvpath);
YAML2CSV('SD_AB_Reference.yaml', 7, "SD", csvpath);

%%
collected_data = load('Collected_Data/Multispeed_Walk_AB.mat');
DATANAME = "Multispeed_Walk_AB";

data_length = length(collected_data.FullStudy.timestamp);
data_name = {'RThighAng', 'LThighAng', 'RShankAng', 'LShankAng'};
data_num  = length(data_name);

csvpath = "../Data/Experiment_CSV/";
if ~exist(csvpath,'dir')
    % if dir doesn't exist, create one
    mkdir(csvpath);
end
file_csv = fopen(csvpath + DATANAME + ".csv",'w');

% Output headers
fprintf(file_csv,'Dimension:%dx%d',data_num,data_length);
fprintf(file_csv,'\n');
for i = 1:data_num
    fprintf(file_csv,'%s,',data_name{i});
end
fprintf(file_csv,'\n');

% Output data
for i_time = 1:data_length
    for i_data = 1:data_num
        fprintf(file_csv,'%16.12f,',collected_data.FullStudy.(data_name{i_data})(i_time) );
    end
    fprintf(file_csv,'\n');
end

fclose(file_csv);