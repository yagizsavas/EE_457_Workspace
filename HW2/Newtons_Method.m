% Newton's Method For Finding The Minimum of Functions
% Inputs:
% func: Function whose minimum will be calculated
% initial_guess: Initial point for iterations
% x_min: minimum value for the interval that will be considered
% x_max: maximum value for the interval that will be considered
% epsilon: Limit value for the difference between two iteration points
function Newtons_Method(func,initial_guess,x_min,x_max,epsilon)
    tic % Start the timer
    x=x_min:0.01:x_max; % Initialize the interval
    handle=func;
    y=handle(x); % Calculate function values
    plot(x,y); 
    xlabel('x value');
    ylabel('Function value');
    x_0=initial_guess; % Pick a starting point
    x_last=x_0+1; % Dummy parameter for the first iteration. 
    iteration=0; % Start iteration counter
    while(abs(x_0-x_last)>epsilon)
        [y,y_dot,y_ddot]=handle(x_0); % Calculate function value, first and second derivatives
        iteration=iteration+1; % Increase the iteration counter
        fprintf('Iteration Number: %d, X Value: %.4f, Function Value: %.4f \n', iteration,x_0, y)
        x_last=x_0; % Keep the last iteration point for comparison
        x_0=x_0-(y_dot/y_ddot); % Calculate the next iteration point
    end
    fprintf('\n')
    toc % Stop the timer
end