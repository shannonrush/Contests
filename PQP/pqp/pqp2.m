% Attempt 2 for Photo Quality Prediction kaggle contest. 

% analyzing "word" features only, combining all to make one common dictionary
% for each example, goal is to predict P(Good|[array of words in all 3 word features]) using naive bayes

data = csvread('training.csv');
m = rows(data);
wordData = cell(m,3);

fid = fopen('training.csv')
for i=1:m
	wordArray = [];
	txt = fgetl(fid);
	a = split(txt,',');
	id = str2num(a(1,:));
	result = str2num(a(10,:));
	for row=7:9
		b = split(txt(row,:),' ');
		for brow=1:rows(b)
			newRow = rows(wordArray)+1;
			wordArray(newRow) = str2num(b(brow,:));
		end
	end
	wordData(i,:)={id,wordArray,result};
end



