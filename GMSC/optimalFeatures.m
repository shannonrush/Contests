function combinations = optimalFeatures(Xtrain,ytrain,Xcv,ycv,Xtest,ytest)
	clear;
	%OPTIMALFEATURES takes a matrix X and finds the error for different feature sets using cross validation and test data
	% and returns the theta from the feature set with the lowest test error
	
	% features=columns(Xtrain);
	features=5;
	numRows = 0;
	r=1;
	for i=1:features
		numRows = numRows + (2^(features-i));
	end
	combinations = zeros(numRows,features);
	for feature=1:features
		dims = (features-feature)+1;
		for row=r:(2^(features-feature))
			value = feature;
			for dim=1:dims
				combinations(row,dim) = value;
				value++;
			end
		end
		r = r + 2^(features-feature);
	end

	
end

	
