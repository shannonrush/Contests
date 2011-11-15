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

% feature normalize Xs
Xtrain = featureNormalize(Xtrain);
Xcv = featureNormalize(Xcv);

lambda = 1;
[theta] = trainLinearReg([ones(rows(Xtrain), 1) Xtrain], ytrain, lambda);

% results for training data and cv data

pTrain = predict(theta, Xtrain, ytrain);
fprintf('Train Accuracy: %f\n', mean(double(round(pTrain) == ytrain)) * 100);
pcv = predict(theta,Xcv,ycv);
fprintf('CV Accuracy: %f\n', mean(double(round(pcv) == ycv)) * 100);

% calculate error for cv

errorcv = linearError(theta,Xcv,ycv);
fprintf('CV Error: %f\n', errorcv);

% learning curve
lambda = 0;
tenPercentTrain = ceil(.1*rows(Xtrain));
tenXtrain = Xtrain(1:tenPercentTrain,:);
tenytrain = ytrain(1:tenPercentTrain,:);
tenPercentcv = ceil(.1*rows(Xcv));
tenXcv = Xcv(1:tenPercentcv,:);
tenycv = ycv(1:tenPercentcv,:);
[error_train, error_val] = learningCurve([ones(rows(tenXtrain), 1) tenXtrain], tenytrain, [ones(size(tenXcv, 1), 1) tenXcv], tenycv, lambda);

plot(1:tenPercentTrain, error_train, 1:tenPercentTrain, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:tenPercentTrain
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

% create test submission


