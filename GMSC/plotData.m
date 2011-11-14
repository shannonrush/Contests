function plotData(X, y, labels)

for i=1:columns(X)
	figure; % open a new figure window
	plot(X(:,i), y, 'rx', 'MarkerSize', 10); % Plot the data 
	ylabel('Serious Deliquency'); % Set the y−axis label 
	xlabel(char(labels(i,:))); % Set the x−axis label
	fprintf('Program paused. Press enter to continue.\n');
	pause;
end