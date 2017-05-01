% Armijo-Goldstein conditions for inexact line search
%%% IMPORTANT NOTE: User should adjust constants for the condition!!!!

%%% Inputs: 
% func: Function used for line search 
% point: Point around where the line search is carred out.
% g: Gradient of the function at the point.

%%% Outputs:
% alpha: Final step size
% iter: Number of iterations

function [alpha,iter]=Armijo_Goldstein(func,point,g)
    epsilon=0.2; % Constants for Armijo-Goldstein conditions
    alpha=1;
    tau_1=0.5;
    tau_2=1.5;
    eta=0.8;
    iter=0; % Start the counter
    phi=func(point); % Calculate function value at the point
    phi_prime=-g'*g;
    % Iterations will be terminated when it exceeds 200. 
    while((func(point-alpha*g)>(phi+epsilon*alpha*phi_prime) || func(point-alpha*g)<(phi+eta*alpha*phi_prime)) && iter<200)
        if func(point-alpha*g)>(phi+epsilon*alpha*phi_prime)
            alpha=tau_1*alpha; % Decrease alpha if it is too large
        elseif func(point-alpha*g)<(phi+eta*alpha*phi_prime)
            alpha=tau_2*alpha; % Increase alpha if it is too low
        end
    iter=iter+1; % Increase the counter
    end
end