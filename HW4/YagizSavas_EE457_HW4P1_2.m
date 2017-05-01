clear all
clc
x=[3,-1,0,1]';
[point,val]=Quasi_Newton_Methods(@Powell,x,1,1000);

%Uncomment the following line to see what happens if we start Hessian estimate with identity matrix
% [point,val]=Quasi_Newton_Methods(@Powell,x,1,1000,'eye');

%Uncomment the following line to see what happens if we do not calculate the gradient of function numerically.
% [point,val]=Quasi_Exact(@Powell,x,1,1000);

% print -depsc2 /home/yagiz/Desktop/courses/figure2.eps