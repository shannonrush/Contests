% Attempt 1 for Photo Quality Prediction kaggle contest.  

% Use logistic regression with columns 2-6 only, 
% treating all numerical features as numbers only (no different treatment based on the type of data)

% load training data and assign columns to X and y

data = csvread('training.csv');
X = data(:, [2:6]); y = data(:, 10);
featureScale(X);

% Initialize fitting parameters
initial_theta = zeros(size(X, 2), 1);

% Set regularization parameter lambda 
lambda = 1;

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = ...
	fminunc(@(t)(cost(t, X, y, lambda)), initial_theta, options);
	
% Compute accuracy on the training set
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);

% Create guess from test data
% testData = csvread('test.csv');
% testX = testData(:, [2, 3, 4, 5, 6]);
% ids = testData(:,1);
% testP = predict(theta, testX);
% guess = [ids,testP];
% csvwrite('guesses/guess.csv',guess);
