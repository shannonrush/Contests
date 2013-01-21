function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));

z = X * theta;
h = sigmoid(z);

J =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h))+(lambda/(2*m))*norm(theta([2:end]))^2;

regular = lambda/m .* theta;
regular(1) = 0; 

grad = (1/m).*X' * (h-y) + regular;

end