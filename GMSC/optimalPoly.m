function pdegree = optimalPoly(Xtrain,ytrain,Xcv,ycv)
	halfQty = ceil(.5*rows(Xcv));
	Xval = Xcv(1:halfQty,:);
	yval = ycv(1:halfQty,:);
	Xtest = Xcv(halfQty+1:end,:);
	ytest = ycv(halfQty+1:end,:);
	p = 10;
	lambda = 1;
	for i=1:p
		X = polyFeatures(Xtrain,i);
		polyTheta(i,:) = trainLinearReg([ones(rows(Xtrain), 1) Xtrain], ytrain, lambda);
		cverror(i) = linearError(polyTheta(i,:)', Xval, yval);
	end
	pdegree = 1;
	testError = linearError(polyTheta(pdegree,:)',Xtest,ytest);
	fprintf('test error from optimalPoly is: %f\n',testError);
end