function YAML2CSV(DATAFILE, ID, name, csvpath)
% YAML2CSV Read yaml file and save as in csv
% Input: yaml file name

DATA = ReadYaml(char(DATAFILE));
DATANAME = replace(DATAFILE,".yaml","");

% Get size and kernel info
kernel_length = length(DATA.percent);
DATA = rmfield(DATA,"percent");
kernel_name = fieldnames(DATA);
kernel_num  = length(kernel_name);



file_csv = fopen(csvpath + DATANAME + ".csv",'w');

% Output headers
fprintf(file_csv,'Name:%s;ID:%d;Dimension:%dx%d',name,ID,kernel_num,kernel_length);
fprintf(file_csv,'\n');
for i = 1:kernel_num
    fprintf(file_csv,'%s,',kernel_name{i});
end
fprintf(file_csv,'\n');

% Output data
for i_time = 1:kernel_length
    for i_kernel = 1:kernel_num
        fprintf(file_csv,'%16.12f,',DATA.(kernel_name{i_kernel}){i_time} );
    end
    fprintf(file_csv,'\n');
end


fclose(file_csv);
end