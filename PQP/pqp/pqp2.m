% Attempt 2 for Photo Quality Prediction kaggle contest. 

% analyzing "word" features only, combining all to make one common dictionary
% for each example, goal is to predict P(Good|[array of words in all 3 word features]) using naive bayes

% goodBag = csvread('goodBag.csv');
% badBag = csvread('badBag.csv'); 
% dictionary = csvread('dictionary.csv');
% yInfo = csvread('yInfo.csv');

data = dlmread('subset.csv');


