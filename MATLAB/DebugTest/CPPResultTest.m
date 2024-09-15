clc;
clear all;
close all;
expdata = 'Multispeed_Walk_AB.mat';
tstart = 5000 + 1;
tend = 7000;
gait_without_saving = sse_without_saving(expdata,tstart,tend);
% gait_with_saving = sse_with_saving(expdata,tstart,tend);
%% 

CPPResult_Trick = readmatrix("../CPPResult/Test_Trick.csv");
CPPResult_Plain = readmatrix("../CPPResult/Test_Plain.csv");
% CPPResult_PlainTest = readmatrix("../CPPResult/Test.csv");
% CPPResult_PlainTest = readmatrix("../CPPResult/Test_Plain_Eigen.csv");

%

figure(1)
clf;
hold on
plot(gait_without_saving,'LineWidth',4,'DisplayName',"SSE Plain")
% plot(gait_with_saving,'-.','LineWidth',2,'DisplayName',"SSE with save")

% plot(CPPResult_PlainTest(:,1),'-','LineWidth',2,'DisplayName',"CPP Test Plain");
plot(CPPResult_Plain(:,1),'--','LineWidth',2,'DisplayName',"CPP Plain");
plot(CPPResult_Trick(:,1),'--','LineWidth',2,'DisplayName',"CPP Trick");

legend()



%% 

function phase_prediction = sse_without_saving(experimentdata,tstart,tend)
Slow_AB = ReadYaml('Slow_AB_Reference.yaml');

acts = {'Slow_AB'};
reslts = {'Slow'};
activities = ["Walking 0.6 m/s"];
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

    tic
    for a = 1%:3 %:numel(reslts) % For each kernal

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
    [~, results.activity_index(t)] = min([results.Slow.min_SSE(t)]);

    [~, results.gait_index(t)] = min(results.(reslts{results.activity_index(t)}).SSE_vector.sum(t, :));

    results.phase_prediction(t) = results.gait_index(t)/length(kernal.(acts{results.activity_index(t)}).percent);
    results.activity_prediction(t) = activities(results.activity_index(t));


    toc
%     disp(toc-tic)
end

phase_prediction = results.phase_prediction;
end


%% 

function phase_prediction = sse_with_saving(experimentdata,tstart,tend)
Slow_AB = ReadYaml('Slow_AB_Reference.yaml');

acts = {'Slow_AB'};
reslts = {'Slow'};
activities = ["Walking 0.6 m/s"];
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
%         results.(reslts{a}).SSE_vector.(subs_kernal{s}).prev = zeros(length(time_considered), length(kernal.(acts{a}).(subs_kernal{s})));
%         results.(reslts{a}).SSE_vector.(subs_kernal{s}).new = zeros(length(time_considered), length(kernal.(acts{a}).(subs_kernal{s})));
        results.(reslts{a}).SSE_vector.sum.new = zeros(length(time_considered), length(kernal.(acts{a}).(subs_kernal{s})));
    end
end

% Run the time based for loop here:
% for t = 1:length(full_data_set.LShank)
for t = 1:length(time_considered)


    % Pretend like new data is coming in to the sub window for each leg segment:
    for s = 2:numel(subs_kernal)
        data_sub_window.(subs_kernal{s}) = [data_sub_window.(subs_kernal{s}); full_data_set.(subs_kernal{s})(time_considered(t))];
        kicked_data.(subs_kernal{s}) = data_sub_window.(subs_kernal{s})(1);
        data_sub_window.(subs_kernal{s})(1) = [];
    end

    tic
    for a = 1%:numel(reslts) % For each kernal
%         for s = 2:numel(subs_kernal)
        data_window_kernal_size.(reslts{a}).RThigh = data_sub_window.RThigh(end-length(kernal.(acts{a}).RThigh)+1:end);
        data_window_kernal_size.(reslts{a}).LThigh = data_sub_window.LThigh(end-length(kernal.(acts{a}).LThigh)+1:end);
        data_window_kernal_size.(reslts{a}).RShank = data_sub_window.RShank(end-length(kernal.(acts{a}).RShank)+1:end);
        data_window_kernal_size.(reslts{a}).LShank = data_sub_window.LShank(end-length(kernal.(acts{a}).LShank)+1:end);

            for n = 1:length(kernal.(acts{a}).percent) % For each sliding configuration
            
                if t == 1
                    results.(reslts{a}).SSE_vector.sum.new(t, n) = sum(((data_sub_window.RThigh(end-length(kernal.(acts{a}).RThigh)+1:end)) - (double_kernal.(acts{a}).RThigh(n:n-1+length(kernal.(acts{a}).RThigh)))).^2) + ...
                                                        sum(((data_sub_window.LThigh(end-length(kernal.(acts{a}).LThigh)+1:end)) - (double_kernal.(acts{a}).LThigh(n:n-1+length(kernal.(acts{a}).LThigh)))).^2) + ...
                                                        sum(((data_sub_window.RShank(end-length(kernal.(acts{a}).RShank)+1:end)) - (double_kernal.(acts{a}).RShank(n:n-1+length(kernal.(acts{a}).RShank)))).^2) + ...
                                                        sum(((data_sub_window.LShank(end-length(kernal.(acts{a}).LShank)+1:end)) - (double_kernal.(acts{a}).LShank(n:n-1+length(kernal.(acts{a}).LShank)))).^2);
                else
                    if n == 1
                        results.(reslts{a}).SSE_vector.sum.new(t, n) = results.(reslts{a}).SSE_vector.sum.new(t-1, end) + (data_window_kernal_size.(reslts{a}).RThigh(end)-kernal.(acts{a}).RThigh(end))^2 - (kicked_data.RThigh-kernal.(acts{a}).RThigh(end))^2 + ...
                            (data_window_kernal_size.(reslts{a}).LThigh(end)-kernal.(acts{a}).LThigh(end))^2 - (kicked_data.LThigh-kernal.(acts{a}).LThigh(end))^2 + ...
                            (data_window_kernal_size.(reslts{a}).RShank(end)-kernal.(acts{a}).RShank(end))^2 - (kicked_data.RShank-kernal.(acts{a}).RShank(end))^2 + ...
                            (data_window_kernal_size.(reslts{a}).LShank(end)-kernal.(acts{a}).LShank(end))^2 - (kicked_data.LShank-kernal.(acts{a}).LShank(end))^2;
                    else
                        results.(reslts{a}).SSE_vector.sum.new(t, n) = results.(reslts{a}).SSE_vector.sum.new(t-1, n-1) + (data_window_kernal_size.(reslts{a}).RThigh(end)-kernal.(acts{a}).RThigh(n-1))^2 - (kicked_data.RThigh-kernal.(acts{a}).RThigh(n-1))^2 + ...
                            (data_window_kernal_size.(reslts{a}).LThigh(end)-kernal.(acts{a}).LThigh(n-1))^2 - (kicked_data.LThigh-kernal.(acts{a}).LThigh(n-1))^2 + ...
                            (data_window_kernal_size.(reslts{a}).RShank(end)-kernal.(acts{a}).RShank(n-1))^2 - (kicked_data.RShank-kernal.(acts{a}).RShank(n-1))^2 + ...
                            (data_window_kernal_size.(reslts{a}).LShank(end)-kernal.(acts{a}).LShank(n-1))^2 - (kicked_data.LShank-kernal.(acts{a}).LShank(n-1))^2;
                    end
                end

%                 results.(reslts{a}).SSE_vector.sum_final(t, n) = results.(reslts{a}).SSE_vector.sum.new(t, n);

            end
                
%             results.(reslts{a}).SSE_vector.sum.prev = results.(reslts{a}).SSE_vector.sum.new;   
            
%             results.(reslts{a}).SSE_vector.sum(t, n) =  sum(((data_sub_window.RThigh(end-length(kernal.(acts{a}).RThigh)+1:end)) - (double_kernal.(acts{a}).RThigh(n:n-1+length(kernal.(acts{a}).RThigh)))).^2) + ...
%                                                         sum(((data_sub_window.LThigh(end-length(kernal.(acts{a}).LThigh)+1:end)) - (double_kernal.(acts{a}).LThigh(n:n-1+length(kernal.(acts{a}).LThigh)))).^2) + ...
%                                                         sum(((data_sub_window.RShank(end-length(kernal.(acts{a}).RShank)+1:end)) - (double_kernal.(acts{a}).RShank(n:n-1+length(kernal.(acts{a}).RShank)))).^2) + ...
%                                                         sum(((data_sub_window.LShank(end-length(kernal.(acts{a}).LShank)+1:end)) - (double_kernal.(acts{a}).LShank(n:n-1+length(kernal.(acts{a}).LShank)))).^2);
            
%         end
        results.(reslts{a}).min_SSE(t) = min(results.(reslts{a}).SSE_vector.sum.new(t, :));
    end

    [~, results.activity_index(t)] = min([results.Slow.min_SSE(t)]);

    [~, results.gait_index(t)] = min(results.(reslts{results.activity_index(t)}).SSE_vector.sum.new(t, :));

    results.phase_prediction(t) = results.gait_index(t)/length(kernal.(acts{results.activity_index(t)}).percent);
    results.activity_prediction(t) = activities(results.activity_index(t));


    toc
%     disp(toc-tic)
end

phase_prediction = results.phase_prediction;
end

