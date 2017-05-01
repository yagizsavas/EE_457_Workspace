% Naive Random Search Algorithm

% Within this code some additional options for neighborhood selection is provided. 
% Neighborhood of x(k)-alpha<x(k+1)<x(k)+alpha is used and alpha= 0.01 is
% used by default. It is assumed that neighborhood has uniform distribution

%%%
% Inputs:
% func: Function to be minimized
% initial: Starting point for iterations
% iter: Bound of number of iterations (i.e. iter=100 results in 100 new point calculations)
% varargin: alpha. Length of neighborhood set will be 2*alpha !

%Outputs:
% x: Final point
% funval: Final function value 
function [x,funval]=Random_Search(func,init,iter,varargin)
    x=init;
    len=length(x);
    F=zeros(iter,1);
    if nargin==4
        alpha=varargin{1}*ones(len,1);
    else
        alpha=0.01;
    end
    for i=1:iter % Naive Random Search Algorithm
        x_new=(x-alpha)+2*alpha.*rand(len,1);
        if func(x_new)<func(x) 
            x=x_new;
        end
        F(i)=func(x);
    end
    funval=F(end);
    plot(1:iter,F,'LineWidth',1,'DisplayName',['\alpha =' num2str(alpha(1))])
    legend('-DynamicLegend')
    ylabel('Function Value')
    xlabel('Iteration Number')
end

