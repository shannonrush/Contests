% Attempt 2 for Photo Quality Prediction kaggle contest. 

% analyzing "word" features only, combining all to make one common dictionary
% for each example, goal is to predict P(Good|[array of words in all 3 word features]) using naive bayes

% training
[wordData, goodBag, badBag, dictionary]=wordData();
p = predict2(wordData,goodBag,badBag,dictionary);

% testing
% wordData=wordDataForTest();
% p = predict2(wordData,goodBag,badBag,dictionary);
