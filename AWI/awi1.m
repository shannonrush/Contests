%% Initialization
clear all; close all; clc

%% Load Data
%  The first two columns contains the exam scores and the third column
%  contains the label.

data = csvread('features/features_train.csv');
X = data(:, 2:end); 
y = data(:, 1); % This is the author

% Initialize fitting parameters
initial_theta = zeros(size(X, 2), 1);

% Set regularization parameter lambda to 1 (you should vary this)
lambda = 1;

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

% Compute accuracy on our training set
p = predict(theta, X);
fprintf(p);
% fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);