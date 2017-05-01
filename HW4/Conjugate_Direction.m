% Conjuge Gradient Algortihm 
% Beta values that is used to determine conjugate directions are calculated
% by Polak-Ribiere formula

%%%
% Inputs:
% func: Function to be minimized
% initial: Starting point for iterations
% line_search_method: Search method to be used for line search. Three
% options(1,2,3) are provided within this code;
% 1: Exact Line Search with Secant Method
% 2: Inexact Line Search with first Armijo conditions
% 3: Inexact Line Search with Armijo-Goldstein conditions
% iter: Bound of number of iterations (i.e. iter=100 results in 100 new point calculations)

%Outputs: 
% x: Variables which satisfy minimum function value
% value: Minimized function value
function [x,value]=Conjugate_Direction(func,initial,line_search_method,iter)
    x=initial;
    len=length(x);
    X=zeros(iter+1,len);
    func_val=zeros(iter+1,1);
    k=0; % Initialize iterations
    % Determine the line search method
    if line_search_method==1
        Search=@ExactLineSearch;
    elseif line_search_method==2
        Search=@Armijo;
    elseif line_search_method==3
        Search=@Armijo_Goldstein;
    end    
    while k<=iter % While loop turns for iter times
        if k==0
            % Conjugate Gradient Algorithm for the first step
            g_first=Gradient(func,x);
            if normtwo(g_first)==0
                break;
            else
                d=-g_first;
            end
            if line_search_method==1
                alpha=Search(func,x,6,10,10^-5);
            else
                alpha=Search(func,x,g_first);
            end
            x=x+alpha*d;

            g_last=Gradient(func,x);
            if normtwo(g_last)==0
                break;
            else
                beta=g_last'*(g_last-g_first)/(g_first'*g_first);
                d=-g_last+beta*d;
            end
        else
            % Conjugate Gradient Algortihm after the first step
            g_first=g_last;
            if line_search_method==1
                alpha=Search(func,x,6,10,10^-5);
            else
                alpha=Search(func,x,g_first);
            end
            x=x+alpha*d;

            g_last=Gradient(func,x);
            if  normtwo(g_last)==0
                break
            else
                beta=g_last'*(g_last-g_first)/(g_first'*g_first);
                d=-g_last+beta*d;
            end
        end  
        k=k+1;
        X(k,:)=x';
        func_val(k)=func(x);
    end
    value=func_val(end);
    k=1:k;
    % Plot the result vs iteration number
    figure
    plot(k,func_val(1:k(end)),'LineWidth',1.5,'DisplayName','f(x)')
    legend('-DynamicLegend'); hold all
    for i=1:len
        plot(k,X(1:k(end),i),'LineWidth',1.5,'DisplayName',['x_' num2str(i)])
        legend('-DynamicLegend'); 
    end
    xlabel('Iteration Number')
end