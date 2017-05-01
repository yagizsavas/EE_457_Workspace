% Quasi-Newton methods for minimization of functions

% i) Three options are provided for the estimation of inverse Hessian, namely
% Rank one, DFP and BFSG algorithms. 
% ii) Alpha values are determined by using exact line search with secant
% method for each case. 

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

%Outputs: 
% x: Variables which satisfy minimum function value
% value: Minimized function value
function [x,value]=Quasi_Exact(func,initial,update,iter)
    x=initial;
    k=0;
    len=length(x);
    H=eye(len); % Initialize H matrix by using a random matrix
    % rand(n) generates a full rank matrix whose entries are uniformly
    % distributed between 0 and 1. 
    X=zeros(iter+1,len);
    func_val=zeros(iter+1,1);
    [~,grad_new]=func(x); % Calculate the first gradient
    while k<=iter
        grad=grad_new;
        if normtwo(grad)==0 % Check the norm of the gradient
            break;
        else
            d=-H*grad;
        end
        alpha=ExactLineSearch(func,x,4,6,10^-4); % Calculate alpha by exact line search
        x=x+alpha*d; % Determine the next point
        [~,grad_new]=func(x); % Calculate the gradient at the new point
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
        [func_val(k),~]=func(x);
    end
    value=func_val(end);
    k=1:k;
    % Plot the result vs iteration number
    figure
    for i=1:len
    plot(k,X(1:k(end),i))
    hold on
    end
    plot(k,func_val)
end