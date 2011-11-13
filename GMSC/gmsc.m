% main file for Give Me Some Credit kaggle competition

% read in data and separate into training and cross validation sets
data = csvread('data/cs-training.csv');

% 70% of data used as training data
qtyTrain = ceil(.7*rows(data));
trainData = data(2:qtyTrain,:);
Xtrain = trainData(:,3:end);
ytrain = trainData(:,2);

% 30% of data used as cross validation data
cvData = data(qtyTrain+1:end,:);
Xcv = cvData(:,3:end);
ycv = cvData(:,2);