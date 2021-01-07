% net_mapper.m
% Group of Victoria Catlett, Amanda Ehnis, and Evan Meade
% Code by Evan Meade
% 
% This script constructs multiple network boundary visualizations.
% 
% After a neural network is constructed and a function nnHR is
% constructed out of it, this script can map the classification
% boundaries and compare them to a map of points it correctly
% and incorrectly classifies for comparison. Also requires
% that the input data x and the target data t are still in the
% workspace.


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


% Initializes new figure with 2x2 subplot grid
figure(1);
a = subplot(2,2,1);

% Plots classification boundaries over entire domain
contourf(bv, mag, hr_grid);
colormap(parula(6));
xlabel('Color (B-V)');
ylabel('Absolute Magnitude');
title('nnHR Paramater Boundaries');
set(gca, 'YDir', 'reverse');


% Initializes arrays for correct and incorrect points
correct = [];
incorrect = [];

% Searches through all points and sorts them based on if they are correctly
% classified by the network
for i = 1:1:size(t,2)
    [t_max, t_ind] = max(t(:,i));
    [y_max, y_ind] = max(y(:,i));
    if t_ind == y_ind
        correct = [correct x(:,i)];
    else
        incorrect = [incorrect x(:,i)];
    end
end


% Plots classification boundaries with both correctly and incorrectly
% classified points
b = subplot(2,2,2);
hold on;
contourf(bv, mag, hr_grid);
xlabel('Color (B-V)');
ylabel('Absolute Magnitude');
title('nnHR: All Classifications');
cor = scatter(correct(1,:),correct(2,:),.25,[0,0,0]);
incor = scatter(incorrect(1,:),incorrect(2,:),.25,[.75,0,0]);
set(gca, 'YDir', 'reverse');


% Plots classification boundaries with correctly classified points
c = subplot(2,2,3);
hold on;
contourf(bv, mag, hr_grid);
xlabel('Color (B-V)');
ylabel('Absolute Magnitude');
title('nnHR: Correct Classifications');
scatter(correct(1,:),correct(2,:),.25,[0,0,0]);
set(gca, 'YDir', 'reverse');


% Plots classification boundaries with incorrectly classified points
d = subplot(2,2,4);
hold on;
contourf(bv, mag, hr_grid);
xlabel('Color (B-V)');
ylabel('Absolute Magnitude');
title('nnHR: Incorrect Classifications');
scatter(incorrect(1,:),incorrect(2,:),.25,[.75,0,0]);
set(gca, 'YDir', 'reverse');