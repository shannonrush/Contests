function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));
J=((1/(2*m))*((X*theta - y)' * (X*theta - y)))+(lambda/(2*m))*norm(theta([2:end]))^2;
grad = (1/m) * (X'*(X*theta-y));
theta(1,:)=0;
grad = grad + ( (lambda/m) * theta);
grad = grad(:);

end