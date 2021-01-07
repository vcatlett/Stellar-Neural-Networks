clc;

% YOU EDIT THESE TWO LINES
% Boolean for if you want a plot of the boundaries 
% Note: It takes awhile if you put "true"
include_plot = false; % EDIT THIS (if you want to)

% Boolean for if you want to print the cost
print_cost = false; % EDIT THIS (if you want to)

% NO MORE EDITS NEEDED
% feel free to mess around with it, though
% This will just make the plots have LaTex font everywhere
set(0,'defaulttextinterpreter','latex');
set(0,'DefaultTextFontname', 'CMU Serif');
set(0,'DefaultAxesFontName', 'CMU Serif');

% Read in the data
%
% It's called "clean_HR" because I cleaned up the original data
% and it nicely creates the Hertzsprung?Russell Diagram
% Except it doesn't have white dwarfs
% Because those have weird spectra and I didn't want to deal with that
data = readtable('clean_HR.csv');

% Set what fractions of the data to loop over
train_frac = [0.5, 0.6, 0.7, 0.8, 0.9];

% Set the fit degrees to loop over
% Greater than 4 will not plot
fit_degree = [1, 2, 3, 4];

% Create an array which will hold the accuracies
% of each fraction/degree combination
results = zeros(length(fit_degree), length(train_frac));

for i = 1:1:length(train_frac)
    for j = 1:1:length(fit_degree)
        % Prints the current train fraction and fit degree
        fprintf('Train Fraction: %i',train_frac(i));
        fprintf('Fit Degree: %i',fit_degree(j));
        
        % Calls the function which does the calculations
        correct_frac = Find_Boundaries(data, train_frac(i), fit_degree(j), include_plot, print_cost);
        
        % Prints the resulting accuracy as a percentage
        fprintf('The classification is %.2f%% accurate\n',correct_frac*100);
        
        % Saves the accuracy as a percentage in the results array
        results(j, i) = correct_frac*100;
    end
end