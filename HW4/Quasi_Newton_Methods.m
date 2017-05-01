% Quasi-Newton methods for minimization of functions

% i) Three options are provided for the estimation of inverse Hessian, namely
% Rank one, DFP and BFSG algorithms. 
% ii) Alpha values are determined by using exact line search with secant
% method for each case. 

% Within this code some additional options for initial estimate of inverse
% Hessian is provided. You can provide your initial guess (satisfying size and symmetry conditions)
% or you can choose to start with identity matrix. By default program uses a random initial matrix. 

%%%
% Inputs:
% func: Function to be minimized
% initial: Starting point for iterations
% update: Update method for the calculation of estimation of inverse Hessian
% Three options are provided as;
% 1: Rank one algorithm (i.e. update=1 calculates inv(H) by rank one alg.)
% 2: DFP algorithm
% 3: BFSG algorithm
% iter: Bound of number of iterations (i.e. iter=100 results in 100 new point calculations)
% varargin: Initial estimate for inverse Hessian. Available options are;
% 'eye': starts with identity matrix
% matrix of your choice (should be in appropriate size and symmetric!)

%Outputs: 
% x: Variables which satisfy minimum function value
% value: Minimized function value
function [x,value]=Quasi_Newton_Methods(func,initial,update,iter,varargin)
    x=initial;
    k=0;
    len=length(x);
    if nargin==4
        H=rand(len); % Initialize H matrix by using a random matrix
        % rand(n) generates a full rank matrix whose entries are uniformly
        % distributed between 0 and 1. 
        H=H'*H; % Make H matrix symmetric
    elseif nargin==5
        if ischar(varargin{1})
            if varargin{1}=='eye'
            H=eye(len);
            end
        elseif size(varargin{1})==size(eye(len))
            if varargin{1}==(varargin{1})'
                H=varargin{1};
            else
                error('Initial estimate of inverse Hessian is not symmetric!')
            end
        else
           error('Unexpected input for inverse Hessian!');
        end
    else
       error('Too much input arguments!')
    end
    X=zeros(iter+1,len);
    func_val=zeros(iter+1,1);
    grad_new=Gradient(func,x); % Calculate the first gradient
    while k<=iter
        grad=grad_new;
        if normtwo(grad)==0 % Check the norm of the gradient
            break;
        else
            d=-H*grad;
        end
        alpha=ExactLineSearch(func,x,4,6,10^-4); % Calculate alpha by exact line search
        x=x+alpha*d; % Determine the next point
        grad_new=Gradient(func,x); % Calculate the gradient at the new point
        delx=alpha*d; % Calculate delta x and delta gradient values
        delgrad=grad_new-grad;
        % Update H values by chosen algorithm
        if update==1 % Rank one algorithm
            H=H+((delx-H*delgrad)*(delx-H*delgrad)')/(delgrad'*(delx-H*delgrad));
        elseif update==2 % DFP algorithm
            H=H+(delx*delx')/(delx'*delgrad)-((H*delgrad)*(H*delgrad)')/(delgrad'*H*delgrad);
        elseif update==3 %BFGS algorithm
            H=H+(1+(delgrad'*H*delgrad)/(delgrad'*delx))*((delx*delx')/(delx'*delgrad))...
                -(H*delgrad*delx'+delx*delgrad'*H')/(delgrad'*delx);
        end
        k=k+1;
        X(k,:)=x; % Keep the values for plotting the results
        func_val(k)=func(x);
    end
    value=func_val(end);
    k=1:k;
    % Plot the result vs iteration number
    figure
    plot(k,func_val(1:end),'LineWidth',1.5,'DisplayName','f(x)')
    legend('-DynamicLegend'); hold all
    for i=1:len
    plot(k,X(1:k(end),i),'LineWidth',1.5,'DisplayName',['x_' num2str(i)])
    legend('-DynamicLegend'); 
    end
    xlabel('Iteration Number')
end