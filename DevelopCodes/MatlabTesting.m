

%% Read data and template

Template = readmatrix('slowTemplateRShank.csv');
Data = readmatrix('slowDataRShank.csv');
WindowLen = length(Template);
Pct = linspace(0,100,WindowLen);
theta = linspace(0,2*pi,WindowLen);

%% Init Figure

f = figure('Name','Phase Detection','Color', [1 1 1]);
clf
tiledlayout(4,1)

% nexttile
% polarplot(theta,resultmatalb,'-')
% hold on
% polarplot(theta,resultforloop,'--')

nexttile
plot_res_matlab = plot(0,0,'-','LineWidth',3);
hold on
plot_res_for = plot(0,0,'--','LineWidth',5);
grid on;
% set(gca,'visible','off');

nexttile([3,1])
hold on
plot_temp = plot(0,0,'LineWidth',3);
plot_data = plot(0,0,'LineWidth',3);
plot_temp_shift = plot(0,0,'--','LineWidth',5);

mm = minmax(Template);
margin = 0.3*abs(mm(1) - mm(2));
ylim(mm + [-0.5*margin margin]);

grid on;
legend('Template','Data','Shifted Temp','Location','northeast');
% set(gca,'visible','off');

frameSaver = FrameSaver('',f);

%% Conv then update plot

% DataInd = 4800;

for DataInd = 4800:20:length(Data)

    assert(DataInd >= WindowLen, sprintf('DataInd cannot < template length: %d', WindowLen));
    assert(DataInd <= length(Data), sprintf('DataInd cannot > data length: %d', length(Data)));
    
    DataWindowed = Data(DataInd-WindowLen+1:DataInd);
    
    resultmatalb = matlabconv(Template, DataWindowed);
    % resultforloop = cc_forloop(Template, DataWindowed);
    
    [~,ind] = max(resultmatalb);
    
    plot_res_matlab.XData = Pct;
    plot_res_matlab.YData = resultmatalb;
    
    % plot_res_for.XData = Pct;
    % plot_res_for.YData = resultforloop;
    
    plot_temp.XData = Pct;
    plot_temp.YData = Template;
    
    plot_data.XData = Pct;
    plot_data.YData = DataWindowed;
    
    plot_temp_shift.XData = Pct;
    plot_temp_shift.YData = Template([ind:WindowLen, 1:ind-1]);
    
    frameSaver.framepause(0.04);

end
frameSaver.finish();

function result = matlabconv(template, data)
    assert(length(template) == length(data));
    N = length(template);
    templatedouble = [template, template];
    kernel = flip(templatedouble);
    fullresult = conv(kernel,data);
    result = flip(fullresult(N:2*N-1));
end


function result = cc_forloop(template, data)
    assert(length(template) == length(data));
    N = length(template);
    result = zeros(1,N);
    for i = 1:N
        addup = 0;
        for j = 1:N
            addup = addup + data(j)*template(mod(j-i,N)+1);
        end
        result(i) = addup;
    end
    result = flip(result);
end
