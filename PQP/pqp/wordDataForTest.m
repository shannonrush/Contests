function wordData=wordData()
	
	% initialize
	data = csvread('test.csv');
	m = rows(data);
	wordData = cell(m,3);		
	fid = fopen('test.csv');
			
	for i=1:m
		wordArray = [];
		txt = fgetl(fid);
		a = strsplit(txt,',');
		id = cell2mat(a(1));
		result = cell2mat(a(10));
				
		% create an array of words found in the 3 word features (name,description,caption), non-unique
		for r=7:9
			feature=cell2mat(a(row));
			b = split(num2str(feature),' ');
			for brow=1:rows(b)
				c = str2num(b(brow,:));
				wordArray = [wordArray,c];
			end
		end
				
		% create a cell array consisting of training row id, wordArray
		wordData(i,:)={id,wordArray};
	end
end