function [y,y_dot]=func3(x)
    y=2*x.^5+3*x-3;
    y_dot=10*x.^4+3;
end