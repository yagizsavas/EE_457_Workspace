%Golden Section Method For Finding Minimum Value of A Function
% Inputs:
% func: Function whose minimum will be calculated
% x_min: minimum value for the interval that will be considered
% x_max: maximum value for the interval that will be considered
% uncertainty_interval: Final uncertainty interval length
function Golden_Section(func,x_min,x_max,uncertainty_interval)
    tic % Start the timer
    x=x_min:0.01:x_max; % Determine the interval on which iteration points will be shown
    handle=func;
    y=handle(x); % Calculate function values on each data point
    plot(x,y);
    xlabel('x value');
    ylabel('Function value');
    uncertainty=uncertainty_interval; % Determine the size of the final uncertainty interval
    a_last=x(1); % Initialize the lowest starting point
    b_last=x(end); % Initialize the highest starting point
    rho=(3-sqrt(5))/2; % Golden Ratio
    iteration=1; % start counting iterations
    interval=b_last-a_last; % Determine the first uncertainty interval

    while(abs(b_last-a_last)>uncertainty) % Run until the size of the interval is smaller than the desired uncertainty level
        if iteration==1 % If it is the first iteration determine TWO new points.
            a=a_last+rho*interval;
            b=b_last-rho*interval;
            val_a=handle(a);
            val_b=handle(b);
            if(val_a>val_b) % Check the higher point and determine the new interval 
                            % If the value of the lower boundary point is
                            % larger keep its value as a_last.
                a_last=a;
                lower_bound=val_b; % Function has its smallest value at point b for this iteration.
                interval=b_last-a_last; % Determine the size of the new interval
                if interval>uncertainty % This loop checks if another calculation is needed. 
                                        % If needed, do the calculations,
                                        % print the results of this step and
                                        % increase the iteration counter afterwards. 
                                        % Note that we only need one new data
                                        % point calculation in the next step.
                    a=b;
                    val_a=val_b;
                    b=b_last-rho*interval;
                    val_b=handle(b);
                end
            else % If the value of the higher boundary point is larger keep its value as b_last.
                b_last=b;
                lower_bound=val_a; % Function has its smallest value at point a for this iteration.
                interval=b_last-a_last;
                if interval>uncertainty
                    b=a;
                    val_b=val_a;
                    a=a_last+rho*interval;
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
                    b=b_last-rho*interval;
                    val_b=handle(b);
                end
            else
                b_last=b;
                lower_bound=val_a;
                interval=b_last-a_last;
                if interval>uncertainty
                    b=a;
                    val_b=val_a;
                    a=a_last+rho*interval;
                    val_a=handle(a);
                end
            end
        end
        fprintf('Iteration Number: %d, Uncertainty Interval: [%.3f, %.3f], Function Value: %.4f \n', iteration,a_last,b_last, lower_bound);
        iteration=iteration+1; % Increase the iteration counter
    end
    fprintf('\n')
    fprintf('Final Uncertainty Interval Length: %.4f\n\n', interval) % Print the final interval length
    toc % Stop the timer
    fprintf('\n')
end