clear;
close all;

subs = {'AB', 'PR'};
reslts = {'Slow'; 'Med'; 'Fast'; 'RA'; 'RD'; 'SA'; 'SD'};
other = {'activity_index', 'gait_index', 'phase_prediction', 'activity_prediction'};

% load the results data
% these include a 1000 point window added to the front during evaluation
AB.Slow = load('Slow_AB_Results.mat').results;
AB.Med = load('Med_AB_Results.mat').results;
AB.Fast = load('Fast_AB_Results.mat').results;

% load the results data
% these include everything, including RA/RD, stops, turns, etc. SS heel
% strikes have been identified and are used here
Ramps_AB = load('Ramps_AB_Results.mat').results;
AB_RA_datapoints = [31750:32307, 37266:37829, 42759:43306, 48032:48894, 54136:54702]-30501+1000;
AB_RD_datapoints = [34417:35257, 39844:40679, 45381:46221, 51308:52129, 56970:57812]-30501+1000;

% ditto (SA/SD)
Stairs_AB = load('Stairs_AB_Results.mat').results;
AB_SA_datapoints = [22552:23431, 30597:31453, 37892:38790]-22237+1000;
AB_SD_datapoints = [25791:26681, 41092:41675]-22237+1000;


%% Repeat the same process for PR data: ***********************************

% load the results data
% these include a 1000 point window added to the front during evaluation
PR.Slow = load('Slow_PR_Results.mat').results;
PR.Med = load('Med_PR_Results.mat').results;
PR.Fast = load('Fast_PR_Results.mat').results;

% load the results data
% these include everything, including RA/RD, stops, turns, etc. SS heel
% strikes have been identified and are used here
Ramps_PR = load('Ramps_PR_Results.mat').results;
PR_RA_datapoints = [42324:43020, 49429:50456, 57077:58081, 64320:65741, 72418:73113, 80129:80806]-41995+1000;
PR_RD_datapoints = [45780:46776, 53256:54250, 60708:61681, 68602:69591, 76299:77326, 83655:84681]-41995+1000;

% ditto (SA/SD)
Stairs_PR = load('Stairs_PR_Results.mat').results;
PR_SA_datapoints = [33393:34732, 43500:44798]-33393+1000;
PR_SD_datapoints = [38017:41088, 47974:51034]-33393+1000;


% Now keep only the steady state strides (for AB):
for iy = 1:length(other)
    for iz = 1:3
        AB.(reslts{iz}).(other{iy}) = AB.(reslts{iz}).(other{iy})(1001:end);
    end
    for iz = 4:5
        AB.(reslts{iz}).(other{iy}) = Ramps_AB.(other{iy})(eval(['AB_', reslts{iz}, '_datapoints']));
    end
    for iz = 6:7
        AB.(reslts{iz}).(other{iy}) = Stairs_AB.(other{iy})(eval(['AB_', reslts{iz}, '_datapoints']));
    end
end
for iy = 1:length(reslts)
    for iz = 1:3
        AB.(reslts{iz}).(reslts{iy}).SSE_vector.sum = AB.(reslts{iz}).(reslts{iy}).SSE_vector.sum(1001:end, :);
        AB.(reslts{iz}).(reslts{iy}).min_SSE = AB.(reslts{iz}).(reslts{iy}).min_SSE(1001:end);
    end
    for iz = 4:5
        AB.(reslts{iz}).(reslts{iy}).SSE_vector.sum = Ramps_AB.(reslts{iy}).SSE_vector.sum(eval(['AB_', reslts{iz}, '_datapoints']), :);
        AB.(reslts{iz}).(reslts{iy}).min_SSE = Ramps_AB.(reslts{iy}).min_SSE(eval(['AB_', reslts{iz}, '_datapoints']));
    end
    for iz = 6:7
        AB.(reslts{iz}).(reslts{iy}).SSE_vector.sum = Stairs_AB.(reslts{iy}).SSE_vector.sum(eval(['AB_', reslts{iz}, '_datapoints']), :);
        AB.(reslts{iz}).(reslts{iy}).min_SSE = Stairs_AB.(reslts{iy}).min_SSE(eval(['AB_', reslts{iz}, '_datapoints']));
    end
end

% Now keep only the steady state strides (for PR):
for iy = 1:length(other)
    for iz = 1:3
        PR.(reslts{iz}).(other{iy}) = PR.(reslts{iz}).(other{iy})(1001:end);
    end
    for iz = 4:5
        PR.(reslts{iz}).(other{iy}) = Ramps_PR.(other{iy})(eval(['PR_', reslts{iz}, '_datapoints']));
    end
    for iz = 6:7
        PR.(reslts{iz}).(other{iy}) = Stairs_PR.(other{iy})(eval(['PR_', reslts{iz}, '_datapoints']));
    end
end
for iy = 1:length(reslts)
    for iz = 1:3
        PR.(reslts{iz}).(reslts{iy}).SSE_vector.sum = PR.(reslts{iz}).(reslts{iy}).SSE_vector.sum(1001:end, :);
        PR.(reslts{iz}).(reslts{iy}).min_SSE = PR.(reslts{iz}).(reslts{iy}).min_SSE(1001:end);
    end
    for iz = 4:5
        PR.(reslts{iz}).(reslts{iy}).SSE_vector.sum = Ramps_PR.(reslts{iy}).SSE_vector.sum(eval(['PR_', reslts{iz}, '_datapoints']), :);
        PR.(reslts{iz}).(reslts{iy}).min_SSE = Ramps_PR.(reslts{iy}).min_SSE(eval(['PR_', reslts{iz}, '_datapoints']));
    end
    for iz = 6:7
        PR.(reslts{iz}).(reslts{iy}).SSE_vector.sum = Stairs_PR.(reslts{iy}).SSE_vector.sum(eval(['PR_', reslts{iz}, '_datapoints']), :);
        PR.(reslts{iz}).(reslts{iy}).min_SSE = Stairs_PR.(reslts{iy}).min_SSE(eval(['PR_', reslts{iz}, '_datapoints']));
    end
end


% Now create the activity classification accuracy confusion matrix

AB_confusion = [hist(AB.Slow.activity_index, 1:7); hist(AB.Med.activity_index, 1:7);...
    hist(AB.Fast.activity_index, 1:7); hist(AB.RA.activity_index, 1:7);...
    hist(AB.RD.activity_index, 1:7); hist(AB.SA.activity_index, 1:7);...
    hist(AB.SD.activity_index, 1:7)];

PR_confusion = [hist(PR.Slow.activity_index, 1:7); hist(PR.Med.activity_index, 1:7);...
    hist(PR.Fast.activity_index, 1:7); hist(PR.RA.activity_index, 1:7);...
    hist(PR.RD.activity_index, 1:7); hist(PR.SA.activity_index, 1:7);...
    hist(PR.SD.activity_index, 1:7)];

AB_classification_accuracy = sum(diag(AB_confusion))./sum(sum(AB_confusion));
PR_classification_accuracy = sum(diag(PR_confusion))./sum(sum(PR_confusion));

for iy = 1:length(reslts)
    AB.(reslts{iy}).PhaseGroundTruth = load(['AB_', (reslts{iy}), '_Phase_GT.mat']).phase_groundtruth;
    PR.(reslts{iy}).PhaseGroundTruth = load(['PR_', (reslts{iy}), '_Phase_GT.mat']).phase_groundtruth;

    AB.(reslts{iy}).PhaseError = abs(AB.(reslts{iy}).PhaseGroundTruth - AB.(reslts{iy}).phase_prediction)*100;
    PR.(reslts{iy}).PhaseError = abs(PR.(reslts{iy}).PhaseGroundTruth - PR.(reslts{iy}).phase_prediction)*100;

    AB.(reslts{iy}).PhaseError(AB.(reslts{iy}).PhaseError>50) = 100-AB.(reslts{iy}).PhaseError(AB.(reslts{iy}).PhaseError>50);
    PR.(reslts{iy}).PhaseError(PR.(reslts{iy}).PhaseError>50) = 100-PR.(reslts{iy}).PhaseError(PR.(reslts{iy}).PhaseError>50);

end

other2 = {'activity_index', 'gait_index', 'phase_prediction', 'activity_prediction', 'PhaseGroundTruth', 'PhaseError'};



for iy = 1:length(other2)
    for iz = 1:length(reslts)
        for iz2 = 1:length(reslts)
            AB_new.(reslts{iz}).(other2{iy}).all = AB.(reslts{iz}).(other2{iy});
            AB_new.(reslts{iz}).(reslts{iz2}).SSE_vector.sum = AB.(reslts{iz}).(reslts{iz2}).SSE_vector.sum;
            AB_new.(reslts{iz}).(reslts{iz2}).min_SSE = AB.(reslts{iz}).(reslts{iz2}).min_SSE;
            PR_new.(reslts{iz}).(other2{iy}).all = PR.(reslts{iz}).(other2{iy});
            PR_new.(reslts{iz}).(reslts{iz2}).SSE_vector.sum = PR.(reslts{iz}).(reslts{iz2}).SSE_vector.sum;
            PR_new.(reslts{iz}).(reslts{iz2}).min_SSE = PR.(reslts{iz}).(reslts{iz2}).min_SSE;
        end
    end
end


for iz = 1:length(reslts)
    for iy = [1 2 3 5 6]
        AB_HS_indices = find(AB_new.(reslts{iz}).PhaseGroundTruth.all==0);
        PR_HS_indices = find(PR_new.(reslts{iz}).PhaseGroundTruth.all==0);
        avg_length_AB = mean(diff(AB_HS_indices));
        avg_length_PR = mean(diff(PR_HS_indices));
        for i = 2:length(AB_HS_indices)
            AB_new.(reslts{iz}).(other2{iy}).strides.raw{i-1} = AB_new.(reslts{iz}).(other2{iy}).all(AB_HS_indices(i-1):(AB_HS_indices(i)-1));
            AB_new.(reslts{iz}).(other2{iy}).strides.normed{i-1} = interp1(linspace(0, 100, length(cell2mat(AB_new.(reslts{iz}).(other2{iy}).strides.raw(i-1)))), cell2mat(AB_new.(reslts{iz}).(other2{iy}).strides.raw(i-1)), linspace(0, 100, avg_length_AB));
        end
        for i2 = 2:length(PR_HS_indices)
            PR_new.(reslts{iz}).(other2{iy}).strides.raw{i2-1} = PR_new.(reslts{iz}).(other2{iy}).all(PR_HS_indices(i2-1):(PR_HS_indices(i2)-1));
            PR_new.(reslts{iz}).(other2{iy}).strides.normed{i2-1} = interp1(linspace(0, 100, length(cell2mat(PR_new.(reslts{iz}).(other2{iy}).strides.raw(i2-1)))), cell2mat(PR_new.(reslts{iz}).(other2{iy}).strides.raw(i2-1)), linspace(0, 100, avg_length_PR));
        end
    end

    AB_new.(reslts{iz}).avgPhaseError = mean(AB_new.(reslts{iz}).PhaseError.all);
    AB_new.(reslts{iz}).stdPhaseError = std(AB_new.(reslts{iz}).PhaseError.all);
    AB_new.(reslts{iz}).maxPhaseError = max(AB_new.(reslts{iz}).PhaseError.all);
    AB_new.(reslts{iz}).rmsPhaseError = rms(AB_new.(reslts{iz}).PhaseError.all);
    % Add in the sensitivity here as well (1/length(kernal))

    PR_new.(reslts{iz}).avgPhaseError = mean(PR_new.(reslts{iz}).PhaseError.all);
    PR_new.(reslts{iz}).stdPhaseError = std(PR_new.(reslts{iz}).PhaseError.all);
    PR_new.(reslts{iz}).maxPhaseError = max(PR_new.(reslts{iz}).PhaseError.all);
    PR_new.(reslts{iz}).rmsPhaseError = rms(PR_new.(reslts{iz}).PhaseError.all);
    % Add in the sensitivity here as well (1/length(kernal))

end

AB_rms_accuracy = [AB_new.Slow.avgPhaseError; AB_new.Med.avgPhaseError;...
    AB_new.Fast.avgPhaseError; AB_new.RA.avgPhaseError;...
    AB_new.RD.avgPhaseError; AB_new.SA.avgPhaseError;...
    AB_new.SD.avgPhaseError];

PR_rms_accuracy = [PR_new.Slow.avgPhaseError; PR_new.Med.avgPhaseError;...
    PR_new.Fast.avgPhaseError; PR_new.RA.avgPhaseError;...
    PR_new.RD.avgPhaseError; PR_new.SA.avgPhaseError;...
    PR_new.SD.avgPhaseError];



