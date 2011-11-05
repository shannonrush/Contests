function testData=testData()
	
	% initialize
	data = csvread('test.csv');
	m = rows(data);
	testData = cell(m,2);
	
	fid = fopen(['test.csv']);
	
	for i=1:m
		wordArray = [];
		txt = fgetl(fid);
		a = strsplit(txt,',');
		id = cell2mat(a(1));
		
		% create an array of words found in the 3 word features (name,description,caption), non-unique
		for r=7:9
			feature=cell2mat(a(r));
			b = split(num2str(feature),' ');
			for brow=1:rows(b)
				c = str2num(b(brow,:));
				wordArray = [wordArray,c];
			end
		end
		
		% create a cell array consisting of training row id, wordArray
		testData(i,:)={id,wordArray};
	end
	
end