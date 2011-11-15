function J = linearError(theta, X, y)
	% add ones to X
	m = rows(X);
	X = [ones(m,1) X];
	J = 1/(2*m)*(X*theta - y)' * (X*theta - y);
end