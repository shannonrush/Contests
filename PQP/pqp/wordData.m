function [wordData,goodBag,badBag,dictionary]=wordData()
	
	% initialize
	data = csvread('subset.csv');
	m = rows(data);
	wordData = cell(m,3);
	goodBag = [];
	badBag = [];
	dictionary = [];
	
	fid = fopen('subset.csv');
	
	for i=1:m
		wordArray = [];
		txt = fgetl(fid);
		a = strsplit(txt,',');
		id = cell2mat(a(1));
		result = cell2mat(a(10));
		
		% create an array of words found in the 3 word features (name,description,caption), non-unique
		for r=7:9
			feature=cell2mat(a(r));
			b = split(num2str(feature),' ');
			for brow=1:rows(b)
				c = str2num(b(brow,:));
				wordArray = [wordArray,c];
			end
		end
		
		% if result is good add word array to goodBag, otherwise add to badBag
		if result==1
			goodBag = [goodBag,wordArray];
		else
			badBag = [badBag,wordArray];
		end
		
		% finally add wordArray to dictionary of all words (will be uniqued at the end)
		dictionary = [dictionary,wordArray];
		
		% create a cell array consisting of training row id, wordArray and the result
		wordData(i,:)={id,wordArray,result};
	end
	
	dictionary = unique(dictionary);
end