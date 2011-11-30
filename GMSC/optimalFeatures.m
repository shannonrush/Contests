function combinations = optimalFeatures(Xtrain,ytrain,Xcv,ycv,Xtest,ytest)
	%OPTIMALFEATURES takes a matrix X and finds the error for different feature sets using cross validation and test data
	% and returns the theta from the feature set with the lowest test error
	
	lambda=10;
	numFeatures=columns(Xtrain);
	elements = [1:numFeatures];
	combinations = {};
	cverror=[];
	for i=2:numFeatures
		results = unique(sort (perms (elements)(:,[1:i]), 2), 'rows');
		for r=1:rows(results)
			feature_set = results(r,:);
			combinations(columns(combinations)+1) = feature_set;
			theta = trainLinearReg([ones(rows(Xtrain), 1) Xtrain(:,feature_set)], ytrain, lambda);
			cverror(columns(cverror)+1) = linearError(theta, Xcv(:,feature_set), ycv);
		end
	end
	
	
	

	
end

	
