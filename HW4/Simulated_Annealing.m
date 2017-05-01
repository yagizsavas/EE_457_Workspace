% Naive Random Search Algorithm

% Within this code some additional options for neighborhood selection and probability of choosing an ascent
% direction are provided. 
% Neighborhood of x(k)-alpha<x(k+1)<x(k)+alpha is used and alpha= 0.01 is
% used by default. It is assumed that neighborhood has uniform distribution.
% Probability of updating the search point although it is not a descent
% direction is by default 0.1. User can provide other specific values. 

%%%
% Inputs:
% func: Function to be minimized
% initial: Starting point for iterations
% iter: Bound of number of iterations (i.e. iter=100 results in 100 new point calculations)
% varargin{1}: alpha. Length of neighborhood set will be 2*alpha !
% varargin{2}: epsilon. Probability of updating the search point although
% it is not a descent direction.

%Outputs:
% x: Final point
% funval: Final function value 
function [x,funval]=Simulated_Annealing(func,init,iter,varargin)
    x=init;
    len=length(x);
    F=zeros(iter,1);
    if nargin>3
        if nargin==4
            alpha=varargin{1}*ones(len,1);
            eps=0.1;
        elseif nargin==5
            alpha=varargin{1}*ones(len,1);
            eps=varargin{2};
        end
    else
        alpha=0.01;
        eps=0.1;
    end
    for i=1:iter % Simulated Annealing Algorithm
        x_new=(x-alpha)+2*alpha.*rand(len,1);
        if func(x_new)<func(x) || rand(1)<eps % update an ascent direction with p=0.1
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

