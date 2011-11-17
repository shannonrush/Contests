function createSubmission(theta, csvTitle)
	data = csvread('data/cs-test.csv');
	testData = data(2:end,:);
	ids = testData(:,1);
	X = testData(:,3:end);
	X = nanToMean(X);
	X = featureNormalize(X);
	m=rows(X);
	X = [ones(m,1) X];
	p = X*theta;
	negs = find(p<0);
	for i=1:rows(negs)
		p(negs(i))=0;
	end
	bigs = find(p>1);
	for i=1:rows(bigs)
		p(bigs(i))=1;
	end
	submission = [ids,p];
	csvwrite(csvTitle,submission);
end