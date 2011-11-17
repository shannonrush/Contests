% main file for Give Me Some Credit kaggle competition
% attempt 3: Linear Regression, convert NA to mean, feature normalize, regularization, using all training data for training

clear; close all; clc;

% read in data and separate into training and cross validation sets
data = csvread('data/cs-training.csv');
data = nanToMean(data);

% use 100% of data for training

Xtrain = data(:,3:end);
ytrain = data(:,2); 

% feature normalize Xs
Xtrain = featureNormalize(Xtrain);

lambda = 10;
[theta] = trainLinearReg([ones(rows(Xtrain), 1) Xtrain], ytrain, lambda);

% results for training data

pTrain = predict(theta, Xtrain, ytrain);
fprintf('Train Accuracy: %f\n', mean(double(round(pTrain) == ytrain)) * 100);

% create test submission

createSubmission(theta, 'submit3.csv');
