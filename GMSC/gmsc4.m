% main file for Give Me Some Credit kaggle competition
clear; close all; clc;

% read in data and separate into training and cross validation sets
data = csvread('data/cs-training.csv');
data = nanToMean(data);
data(:,3:end) = featureNormalize(data(:,3:end));

labels = ['RevolvingUtilizationOfUnsecuredLines';'age';'NumberOfTime30-59DaysPastDueNotWorse';'DebtRatio'; 'MonthlyIncome'; 'NumberOfOpenCreditLinesAndLoans'; 'NumberOfTimes90DaysLate'; 'NumberRealEstateLoansOrLines'; 'NumberOfTime60-89DaysPastDueNotWorse'; 'NumberOfDependents'];

% 60% of data used as training data
qtyTrain = ceil(0.6*rows(data));
trainData = data(2:qtyTrain,:);
Xtrain = trainData(:,3:end);
ytrain = trainData(:,2);

% 20% of data used as cross validation data
remainingData = data(qtyTrain+1:end,:);
qtycv = ceil(0.5*rows(remainingData));
cvData = remainingData(1:qtycv,:); 
Xcv = cvData(:,3:end);
ycv = cvData(:,2);

% 20% of data used as test data

testData = remainingData(qtycv+1:end,:);
Xtest = testData(:,3:end);
ytest = testData(:,2);

% find optimal feature set and create submission

optimalFeatures(Xtrain, ytrain, Xcv, ycv, Xtest, ytest);


