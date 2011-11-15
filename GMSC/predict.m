function p = predict(theta, X, y)
	% add column of ones to X
	m=rows(X);
	X = [ones(m,1) X];
	p = X*theta;
end