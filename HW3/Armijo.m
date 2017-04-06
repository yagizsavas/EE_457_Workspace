% First Armijo condition for inexact line search
%%% IMPORTANT NOTE: User should adjust constants for the condition!!!!

%%% Inputs: 
% func: Function used for line search 
% point: Point around where the line search is carred out.
% g: Gradient of the function at the point.

%%% Outputs:
% alpha: Final step size
% iter: Number of iterations

function [alpha,iter]=Armijo(func,point,g)
    epsilon=0.001; % Constant for Armijo condition
    alpha=100;
    tau=0.5;
    iter=0; % Start the counter
    phi=func(point); % Calculate function value at the point
    phi_prime=-g'*g;
    % Iterations will be terminated when it exceeds 200. 
    while((func(point-alpha*g)>(phi+epsilon*alpha*phi_prime)) && iter<200)
        alpha=tau*alpha; % Decrease alpha until the condition is satisfied.
        iter=iter+1; % Increase the counter
    end
end