function [y,y_dot,y_ddot]=func1(x)
    y=3*exp(2-x)+4*log(2*x);
    y_dot=-3*exp(2-x)+4*x.^-1;
    y_ddot=6*exp(2-x)-4*x.^-2;
end

