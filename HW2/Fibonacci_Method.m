%Fibonacci Method For Finding Minimum Value of A Function
% Inputs:
% func: Function whose minimum will be calculated
% x_min: minimum value for the interval that will be considered
% x_max: maximum value for the interval that will be considered
% uncertainty_interval: Final uncertainty interval length
% final_epsilon: Epsilon value that will be used in the last iteration
function Fibonacci_Method(func,x_min,x_max,uncertainty_interval,final_epsilon)
    tic % Start the timer
    x=x_min:0.01:x_max; % Determine the interval on which iteration points will be shown
    handle=func;
    y=handle(x); % Calculate function values on each data point
    plot(x,y); 
    xlabel('x value');
    ylabel('Function value');
    a_last=x(1); % Initialize the lowest starting point
    b_last=x(end); % Initialize the highest starting point
    epsilon=final_epsilon; % Determine the regressor value that is used in last iteration
    uncertainty=uncertainty_interval; % Determine the size of the final uncertainty interval
    interval=b_last-a_last; % Determine the initial size of the uncertainty interval
    fib_N=(1+2*epsilon)*interval/uncertainty; % Determine how many fibonnacci number will be used.
    fib_N=ceil(fib_N); % Round the required value to the smallest greater integer
    fib=zeros(fib_N,1); % Initialize fibonacci vector with zeros
    fib(1)=0; % Initialize first two fibonacci numbers
    fib(2)=1;
    i=2;
    while (fib(i)<fib_N) % Calculate Fibonacci numbers and put them into the zero vector
        fib(i+1)=fib(i)+fib(i-1);
        i=i+1;
    end
    fib=fib(3:i); % Cut off the first two fibonacci numbers which will not be used
    rho=zeros(length(fib)-1,1); % Initialize ratio vector with zeros
    for i=1:length(fib)-1 % Calculate ratios for each iteration
        if i==length(fib)-1
          rho(i)=1-(fib(length(fib)-i)/fib(length(fib)+1-i)+epsilon);  
        else
        rho(i)=1-(fib(length(fib)-i)/fib(length(fib)+1-i));
        end
    end


    iteration=1; % Initialize the iteration number
    while(abs(interval)>uncertainty)
        if iteration==1 % If it is the first iteration calculate two points 
            a=a_last+rho(iteration)*interval; 
            b=b_last-rho(iteration)*interval;
            val_a=handle(a);
            val_b=handle(b);
            if(val_a>val_b) % Check the higher point and determine the new interval 
                            % If the value of the lower boundary point is
                            % larger keep its value as a_last.
                a_last=a;
                lower_bound=val_b;  % Function has its smallest value at point b for this iteration.
                interval=b_last-a_last; % Determine the size of the new interval
                if interval>uncertainty % This loop checks if another calculation is needed. 
                                        % If needed, do the calculations,
                                        % print the results of this step and
                                        % increase the iteration counter afterwards. 
                                        % Note that we only need one new data
                                        % point calculation in the next step.
                    a=b;
                    val_a=val_b;
                    b=b_last-rho(iteration+1)*interval;
                    val_b=handle(b);
                end
            else % If the value of the higher boundary point is larger keep its value as b_last.
                b_last=b;
                lower_bound=val_a; % Function has its smallest value at point a for this iteration.
                interval=b_last-a_last;
                if interval>uncertainty
                    b=a;
                    val_b=val_a;
                    a=a_last+rho(iteration+1)*interval;
                    val_a=handle(a);
                end
            end
        else % If iteration number is not one, do the same calculations.
            if(val_a>val_b)
                a_last=a;
                lower_bound=val_b;
                interval=b_last-a_last;
                if interval>uncertainty
                    a=b;
                    val_a=val_b;
                    b=b_last-rho(iteration+1)*interval;
                    val_b=handle(b);
                end
            else
                b_last=b;
                lower_bound=val_a;
                interval=b_last-a_last;
                if interval>uncertainty
                    b=a;
                    val_b=val_a;
                    a=a_last+rho(iteration+1)*interval;
                    val_a=handle(a);
                end
            end
        end
        fprintf('Iteration Number: %d, Uncertainty Interval: [%.3f, %.3f], Function Value: %.4f \n', iteration,a_last,b_last, lower_bound);
        iteration=iteration+1; % Increase the iteration counter
    end
    fprintf('\n')
    fprintf('Final Uncertainty Interval Length: %.4f\n\n', interval)  % Print the final interval length
    toc % Stop the timer
    fprintf('\n')
end