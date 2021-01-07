% NNStart_HR.m
% Group of Victoria Catlett, Amanda Ehnis, and Evan Meade
% Code by Evan Meade
% 
% This script uses built-in methods to classify spectral types.
%
% The script iterates over different neural network parameters
% for NNStart and averages performance over multiple runs.
% This allows the user to see the impact of hidden layer size
% and training percentage on overall performance. Additionally,
% it provides a visualization of the final network.
%
% NOTE: With default parameters, script takes about 1 hour to
% execute per loop. To shorten run time, change either
% num_loops or max_hidden_layer_size.


% Clears all prior variables and outputs
clear all;
clc;

% Reads in dataset of stars classified by spectral type
T = readtable('clean_HR.csv');
% x parameters: [B-V color index; absolute magnitude]
x = transpose(table2array(T(:,1:2)));
% t is a unit binary vector denoting type: [O, B, A, F, G, K, M]
t = transpose(table2array(T(:,4:10)));


% Generates list of different parameter combinations
configs = [];
max_hidden_layer_size = 24;
for hidden_layer_size = 1:1:max_hidden_layer_size
    for percentage_for_training = 50:10:90
        configs = [configs; hidden_layer_size percentage_for_training/100];
    end
end


% Initializes array to store performance results
results = [];

% Iterates over all parameter configurations multiple times to average
num_loops = 10;
for loop = 1:1:num_loops
    
    % Iterates NNStart methods over all parameter configurations
    for run = 1:1:(size(configs,1))
        
        % Reads in NNStart parameters for appropriate configuration
        num_hid = configs(run,1);
        prc_train = configs(run,2);
        
        % Selects training function:
        % 'Scaled conjugate gradient backpropagation'
        % Selected here for memory efficiency and speed due to large
        % dataset size
        trainFcn = 'trainscg';

        % Creates pattern recognition network
        hiddenLayerSize = num_hid;
        net = patternnet(hiddenLayerSize, trainFcn);

        % Defines pre- and post-processing functions for data
        net.input.processFcns = {'removeconstantrows','mapminmax'};

        % Defines random division of cases into training, validation, and
        % testing subsets
        net.divideFcn = 'dividerand';
        net.divideMode = 'sample';
        
        % Defines percentages of data to be used for training, validation,
        % and testing
        net.divideParam.trainRatio = prc_train;
        net.divideParam.valRatio = 5/100;
        net.divideParam.testRatio = 5/100;

        % Selects performance function to be used in evaluation:
        % 'Cross-entropy'
        % Selected here to match the classification network's output
        net.performFcn = 'crossentropy';

        % Defines plots to be shown in network training progress window
        net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
            'plotconfusion', 'plotroc'};

        % Trains the network
        [net,tr] = train(net,x,t);

        % Tests the network with built-in methods
        y = net(x);
        e = gsubtract(t,y);
        performance = perform(net,t,y);
        tind = vec2ind(t);
        yind = vec2ind(y);
        percentErrors = sum(tind ~= yind)/numel(tind);

        % Recalculates training, validation and test performance
        trainTargets = t .* tr.trainMask{1};
        valTargets = t .* tr.valMask{1};
        testTargets = t .* tr.testMask{1};
        trainPerformance = perform(net,trainTargets,y);
        valPerformance = perform(net,valTargets,y);
        testPerformance = perform(net,testTargets,y);
        
        % Calculates percentage of cases misclassified
        conf = confusion(t,y);
        
        % Appends parameters and performance to results
        results = [results; num_hid prc_train trainPerformance valPerformance testPerformance conf];

    end
    
end

% Generates a stellar classification function based on the last generated
% NNStart network
genFunction(net, 'NN_HR');


% Averages results over all runs
av_results = [];
n = size(configs,1);
for i = 1:1:n
    sum_row = results(i,:);
    for j = 1:1:(num_loops - 1)
        sum_row = sum_row + results(j*n+i,:);
    end
    sum_row = sum_row / num_loops;
    av_results = [av_results; sum_row];
end


% Plots Results


% Sets fonts
set(0,'DefaultTextInterpreter','latex');
set(0,'DefaultTextFontName','CMU Serif');
set(0,'DefaultAxesFontName','CMU Serif');

% Initializes average error vectors for each training percentage
e_50 = [];
e_60 = [];
e_70 = [];
e_80 = [];
e_90 = [];

% Defines hidden layer size vector (x-axis when plotted)
xp = 1:1:num_hid;

% Fills average error vectors
for i = 0:1:(num_hid - 1)
    e_50 = [e_50; av_results(i*5+1,5)];
    e_60 = [e_60; av_results(i*5+2,5)];
    e_70 = [e_70; av_results(i*5+3,5)];
    e_80 = [e_80; av_results(i*5+4,5)];
    e_90 = [e_90; av_results(i*5+5,5)];
end

% Plots average error against hidden layer size
cmap = colormap(jet(5));
figure(1);
a = subplot(1,2,1);
hold on;
plot(xp, e_50, 'Color',cmap(1,:),'LineWidth',2);
plot(xp, e_60, 'Color',cmap(2,:),'LineWidth',2);
plot(xp, e_70, 'Color',cmap(3,:),'LineWidth',2);
plot(xp, e_80, 'Color',cmap(4,:),'LineWidth',2);
plot(xp, e_90, 'Color',cmap(5,:),'LineWidth',2);
title('Test Error vs. Hidden Layer Size', 'FontSize', 20);
xlabel('Hidden Layer Size', 'FontSize', 15);
ylabel('Test Error', 'FontSize', 15);
legend('50% Training', '60% Training', '70% Training', '80% Training', '90% Training');


% Initializes new subplot for percentage misclassified
b = subplot(1,2,2);
hold on;

% Initializes average percentage misclassified vectors for each training percentage
m_50 = [];
m_60 = [];
m_70 = [];
m_80 = [];
m_90 = [];

% Defines hidden layer size vector (x-axis when plotted)
xp = 1:1:num_hid;

% Fills average percentage misclassified vectors
for i = 0:1:(num_hid - 1)
    m_50 = [m_50; 100*av_results(i*5+1,6)];
    m_60 = [m_60; 100*av_results(i*5+2,6)];
    m_70 = [m_70; 100*av_results(i*5+3,6)];
    m_80 = [m_80; 100*av_results(i*5+4,6)];
    m_90 = [m_90; 100*av_results(i*5+5,6)];
end

% Plots average percentage misclassified against hidden layer size
plot(xp, m_50, 'Color',cmap(1,:),'LineWidth',2);
plot(xp, m_60, 'Color',cmap(2,:),'LineWidth',2);
plot(xp, m_70, 'Color',cmap(3,:),'LineWidth',2);
plot(xp, m_80, 'Color',cmap(4,:),'LineWidth',2);
plot(xp, m_90, 'Color',cmap(5,:),'LineWidth',2);
title('Percent Misclassified vs. Hidden Layer Size', 'FontSize', 20);
xlabel('Hidden Layer Size', 'FontSize', 15);
ylabel('% Misclassified', 'FontSize', 15);
legend('50% Training', '60% Training', '70% Training', '80% Training', '90% Training');


% Begins new figure for plotting trained net's classification boundaries
figure(2);

% Defines interval of B-V index to be mapped from input range
bv_min = min(x(1,:));
bv_max = max(x(1,:));
bv_n = 1000;
bv_h = (bv_max - bv_min) / bv_n;
bv = bv_min:bv_h:bv_max;

% Defines interval of absolute magnitude to be mapped from input range
mag_min = min(x(2,:));
mag_max = max(x(2,:));
mag_n = 1000;
mag_h = (mag_max - mag_min) / mag_n;
mag = mag_min:mag_h:mag_max;

% Initializes grid of spectral paramaters to be classified
hr_grid = zeros(mag_n+1, bv_n+1);

% Evaluates trained network at each parameter combination in the domain
for i = 1:1:(mag_n+1)
    for j = 1:1:(bv_n+1)
        line = nnHR([bv(j); mag(i)]);
        [max_val, max_ind] = max(line);
        hr_grid(i,j) = max_ind;
    end
end

% Plots the parameter space classification boundaries
contourf(bv, mag, hr_grid, 'LineStyle', 'none');
p = 229/255;
colormap([1 1 p; p 1 p; p 1 1; p p 1; 1 p 1; p p p]);
xlabel('B-V Color Index (mag)');
ylabel('Absolute Magnitude (mag)');
title('NNStart Highest-Probability Classes');
set(gca, 'YDir', 'reverse');
