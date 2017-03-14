function [y,y_dot,y_ddot]=func2(x)
    y=3*x.^4+7*cos(2*x);
    y_dot=12*x.^3-14*sin(2*x);
    y_ddot=36*x.^2-28*cos(2*x);
end