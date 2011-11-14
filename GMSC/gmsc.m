% main file for Give Me Some Credit kaggle competition
clear; close all; clc;

% read in data and separate into training and cross validation sets
data = csvread('data/cs-training.csv');
data = nanToMean(data);
labels = ['RevolvingUtilizationOfUnsecuredLines';'age';'NumberOfTime30-59DaysPastDueNotWorse';'DebtRatio'; 'MonthlyIncome'; 'NumberOfOpenCreditLinesAndLoans'; 'NumberOfTimes90DaysLate'; 'NumberRealEstateLoansOrLines'; 'NumberOfTime60-89DaysPastDueNotWorse'; 'NumberOfDependents'];

% 70% of data used as training data
qtyTrain = ceil(.7*rows(data));
trainData = data(2:qtyTrain,:);
Xtrain = trainData(:,3:end);
ytrain = trainData(:,2);

% 30% of data used as cross validation data
cvData = data(qtyTrain+1:end,:);
Xcv = cvData(:,3:end);
ycv = cvData(:,2);

% feature normalize X
Xtrain = featureNormalize(Xtrain);

lambda = 0;
[theta] = trainLinearReg([ones(rows(Xtrain), 1) Xtrain], ytrain, lambda);



