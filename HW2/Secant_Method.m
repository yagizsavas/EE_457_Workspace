% Secant Method For Root Finding
% Inputs:
% func: Function whose minimum will be calculated
% initial_0: First initial point for iterations
% initial_1: Second initial point for iterations
% epsilon: Limit value for the difference between two iteration points

function Secant_Method(func,initial_0,initial_1,epsilon)
    tic % Start the timer
    handle=func;
    x_0=initial_0; % Pick two starting points
    x_1=initial_1;
    iteration=0; % Initialize the iteration counter
    while(abs(x_0-x_1)>epsilon)
        [y_0]=handle(x_0); % Calculate function value and first derivative for the first point
        [y_1]=handle(x_1); % Calculate function value and first derivative for the second point
        iteration=iteration+1; % Increase the counter
        fprintf('Iteration Number: %d, X Value: %.4f Function Value: %.4f \n', iteration,x_1, y_1)
        x_0_last=x_1; % Keep the value of second point
        x_1=x_1-((x_1-x_0)/(y_1-y_0))*y_1; % Calculate the new second point
        x_0=x_0_last; % Make the last second point new first point
    end
    fprintf('Root is at x= %.4f\n\n',x_1);
    toc % Stop the timer
end