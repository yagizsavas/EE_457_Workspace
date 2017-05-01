% Exact line search with Secant Method
%%% Inputs: 
% func: The function to be minimized
% point: on which the gradient of the function is calculated
% alpha_1: first initial guess for alpha
% alpha_2: second initial guess for alpha
% epsilon: stop condition for secant algortihm (alpha-alpha_last)< epsilon

%%% Outputs:
% alpha_1: Optimum alpha value which achieves minimum decrease
% iteration: Number of iterations

function [alpha_1,iteration]=ExactLineSearch(func,point,alpha_1,alpha_0,epsilon)
    iteration=0; % Initialize the iteration counter
    g=Gradient(func,point); % Calculate the gradient at the point
    while(abs(alpha_1-alpha_0)>epsilon)
        point_0=point-alpha_0*g; % Determine new two points
        point_1=point-alpha_1*g;
        ydot_0=-1*Gradient(func,point)'*Gradient(func,point_0); % Calculate first derivative for the first point
        ydot_1=-1*Gradient(func,point)'*Gradient(func,point_1); % Calculate first derivative for the second point
        iteration=iteration+1; % Increase the counter
        alpha_1_last=alpha_1; % Keep the value of second point
        alpha_1=alpha_1-((alpha_1-alpha_0)/(ydot_1-ydot_0))*ydot_1; % Calculate the new second point
        alpha_0=alpha_1_last; % Make the last second point new first point
    end
    
end
