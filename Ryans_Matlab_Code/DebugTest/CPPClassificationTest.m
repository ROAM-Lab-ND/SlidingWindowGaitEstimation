clc;
clear all;
close all;
expdata = 'Multispeed_Walk_AB.mat';
tstart = 4000 + 1;
tend = 7000;
[gait_plain, act_index_plain] = SSE_classification_plain(expdata,tstart,tend);

%% 

CPPResult_Trick = readmatrix("../CPPResult/Test_Trick.csv");
CPPResult_Plain = readmatrix("../CPPResult/Test_Plain.csv");
%% 


figure(1)
clf;
tiledlayout(2,1);
nexttile;
hold on
plot(gait_plain,'LineWidth',6,'DisplayName',"SSE Plain")
plot(CPPResult_Plain(:,1),'-','LineWidth',2,'DisplayName',"CPP without save");
plot(CPPResult_Trick(:,1),'--','LineWidth',2,'DisplayName',"CPP with save");
nexttile;
hold on
plot(act_index_plain,'LineWidth',6,'DisplayName',"SSE Plain")
plot(CPPResult_Plain(:,2),'-','LineWidth',2,'DisplayName',"CPP without save");
plot(CPPResult_Trick(:,2),'--','LineWidth',2,'DisplayName',"CPP with save");
legend


%% 


function [phase_prediction, activity_index] = SSE_classification_plain(experimentdata,tstart,tend)

Slow_AB = ReadYaml('Slow_AB_Reference.yaml');
Med_AB = ReadYaml('Med_AB_Reference.yaml');
Fast_AB = ReadYaml('Fast_AB_Reference.yaml');
RA_AB = ReadYaml('RA_AB_Reference.yaml');
RD_AB = ReadYaml('RD_AB_Reference.yaml');
SA_AB = ReadYaml('SA_AB_Reference.yaml');
SD_AB = ReadYaml('SD_AB_Reference.yaml');

acts = {'Slow_AB'; 'Med_AB'; 'Fast_AB'; 'RA_AB'; 'RD_AB'; 'SA_AB'; 'SD_AB'};
reslts = {'Slow'; 'Med'; 'Fast'; 'RA'; 'RD'; 'SA'; 'SD'};
activities = ["Walking 0.6 m/s", "Walking 0.8 m/s", "Walking 1.0 m/s", "Ramp Ascent", "Ramp Descent", "Stair Ascent", "Stair Descent"];
subs_kernal = fieldnames(Slow_AB);
subs_data = {'RThighAng'; 'LThighAng'; 'RShankAng'; 'LShankAng'};

% Creating a struct to conviniently house all kernals:
for a=1:numel(acts)
    for s=1:numel(subs_kernal)
        kernal.(acts{a}).(subs_kernal{s}) = cell2mat(eval([(acts{a}), '.', (subs_kernal{s})]))';
        double_kernal.(acts{a}).(subs_kernal{s}) = [kernal.(acts{a}).(subs_kernal{s}); kernal.(acts{a}).(subs_kernal{s})];
    end
end

% Creating a struct for the incoming data:
collected_data = load(experimentdata);
for s=1:numel(subs_data)
    full_data_set.(subs_kernal{s+1}) = collected_data.FullStudy.(subs_data{s});
end



% Initialize a bunch of stuff here to be zeros before the loop starts:

time_considered = tstart:tend; % 1:length(full_data_set.RThigh)

for s = 2:numel(subs_kernal)
    data_sub_window.(subs_kernal{s}) = zeros(600, 1); % this is just a moving subset of the incoming data, initialized to be all zeros in the beginning
    for a = 1:numel(reslts)
        % These are (time x n) dimension matrices. Each cell corresponds to
        % an SSE comparison between kernal and data. As you move columns,
        % you are sliding the kernal relative to the data. As you move
        % rows, you change time instances. SSE comparisons are the sum of
        % the SSE from each RThigh, LThigh, RShank, LShank.
        results.(reslts{a}).SSE_vector.sum = zeros(length(time_considered), length(kernal.(acts{a}).(subs_kernal{s})));
    end
end

% Run the time based for loop here:
% for t = 1:length(full_data_set.LShank)
for t = 1:length(time_considered)

    % Pretend like new data is coming in to the sub window for each leg segment:
    for s = 2:numel(subs_kernal)
        data_sub_window.(subs_kernal{s}) = [data_sub_window.(subs_kernal{s}); full_data_set.(subs_kernal{s})(time_considered(t))];
        data_sub_window.(subs_kernal{s})(1) = [];
    end

    for a = 1:3 %:numel(reslts) % For each kernal

        data_window_kernal_size.(reslts{a}).RThigh = data_sub_window.RThigh(end-length(kernal.(acts{a}).RThigh)+1:end);
        data_window_kernal_size.(reslts{a}).LThigh = data_sub_window.LThigh(end-length(kernal.(acts{a}).LThigh)+1:end);
        data_window_kernal_size.(reslts{a}).RShank = data_sub_window.RShank(end-length(kernal.(acts{a}).RShank)+1:end);
        data_window_kernal_size.(reslts{a}).LShank = data_sub_window.LShank(end-length(kernal.(acts{a}).LShank)+1:end);

        for n = 1:length(kernal.(acts{a}).percent) % For each sliding configuration

            results.(reslts{a}).SSE_vector.sum(t, n) =  sum(((data_sub_window.RThigh(end-length(kernal.(acts{a}).RThigh)+1:end)) - (double_kernal.(acts{a}).RThigh(n:n-1+length(kernal.(acts{a}).RThigh)))).^2) + ...
                                                        sum(((data_sub_window.LThigh(end-length(kernal.(acts{a}).LThigh)+1:end)) - (double_kernal.(acts{a}).LThigh(n:n-1+length(kernal.(acts{a}).LThigh)))).^2) + ...
                                                        sum(((data_sub_window.RShank(end-length(kernal.(acts{a}).RShank)+1:end)) - (double_kernal.(acts{a}).RShank(n:n-1+length(kernal.(acts{a}).RShank)))).^2) + ...
                                                        sum(((data_sub_window.LShank(end-length(kernal.(acts{a}).LShank)+1:end)) - (double_kernal.(acts{a}).LShank(n:n-1+length(kernal.(acts{a}).LShank)))).^2);
            
        end
        results.(reslts{a}).min_SSE(t) = min(results.(reslts{a}).SSE_vector.sum(t, :));
    end
    [~, results.activity_index(t)] = min([results.Slow.min_SSE(t), results.Med.min_SSE(t), results.Fast.min_SSE(t)]); %, results.RA.min_SSE, results.RD.min_SSE, results.SA.min_SSE, results.SD.min_SSE]);

    [~, results.gait_index(t)] = min(results.(reslts{results.activity_index(t)}).SSE_vector.sum(t, :));

    results.phase_prediction(t) = results.gait_index(t)/length(kernal.(acts{results.activity_index(t)}).percent);
    results.activity_prediction(t) = activities(results.activity_index(t));


end


phase_prediction = results.phase_prediction;
activity_index = results.activity_index;

end