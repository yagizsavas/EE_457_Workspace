% Modified Newton's Algortihm for Optimization of multivariable functions
%%% Inputs:
% func: The function to be minimized
% initial: Initial guess for the input vector
% end_condition: Two stop conditions are provided within this code
% '1' for norm 2 difference of states (x-x_last< bound)
% '2' for norm 2 value of the gradient (grad(func)< bound)
% bound: Boundary condition for stop condition

%%% Outputs:
% final_vector: Vector values that minimize the function
% final_value: Minimum value of the function
% iteration: Number of iterations
% search_iter: Number of iterations for line search
% Function provides a plot output which indicates parameter 
% and function values at each iteration

function [final_vector,final_value,iteration,search_iter]=Modified_Newtons_Method(func,initial,end_condition,bound)
    x=initial;
    len=length(x); % Keep the length of the input vector
    x_last=x+ones(len,1); %dummy point
    iteration=0;
    search_iter=0;
    x_vector=zeros(10000,len); % Vectors to keep values for each iteration
    y_vector=zeros(10000,1);
    if end_condition==1 % First stop condition !
        while (normtwo(x-x_last)>=bound) % Stop iterating when the norm of difference falls below the bound.
            x_last=x;% Keep the last vector
            g=Gradient(func,x_last);
                if normtwo(g)~=0
                    [alpha,iter_search]=ExactLineSearch(func,x_last,0.5,0.6,10^-3);
                end
            x=x_last-alpha*inv(Hessian(func,x_last))*g;
            iteration=iteration+1; % Increase the iteration counter
            y_vector(iteration)=func(x); % Calculate the new function value at the next point
            x_vector(iteration,:)=x'; % Keep the information of the new point
            search_iter=search_iter+iter_search;
        end
    elseif end_condition==2 % Second stop condition !
        g=Gradient(func,x); % Calculate the gradient (numerically) at the initial point.
        while (normtwo(g)>=bound) % Stop iterating when the norm of the gradient falls below the bound.
            x_last=x;
            g=Gradient(func,x_last); % Calculate the gradient at the last point.
            if normtwo(g)~=0
                [alpha,iter_search]=ExactLineSearch(func,x_last,0.5,0.6,10^-3);
            end
            x=x_last-alpha*inv(Hessian(func,x_last))*g;
            iteration=iteration+1;
            y_vector(iteration)=func(x);
            x_vector(iteration,:)=x';
            search_iter=search_iter+iter_search;
        end
    end
    iteration=1:iteration; % Compose iteration vector for plotting purposes
    x_vector=x_vector(iteration,:); % Take only calculated part of vectors (get rid of the predefined excessive part)
    y_vector=y_vector(iteration,1);
    final_vector=x_vector(end,:);
    final_value=y_vector(end);
    figure
    plot(iteration,y_vector,'Color',[0 0.5 0],'LineWidth',1.5,'DisplayName','f(x)'); 
    legend('-DynamicLegend'); hold all
    for i=1:len
        plot(iteration,x_vector(:,i),'LineWidth',1.5,'DisplayName',['x_' num2str(i)]);
        legend('-DynamicLegend'); 
    end
    xlabel('Iteration number')
    iteration=iteration(end);
end