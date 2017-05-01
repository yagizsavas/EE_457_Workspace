clear all
clc
x=[3,-1,0,1]';
[point,val]=Quasi_Newton_Methods(@Powell,x,2,1000);

%Uncomment the following line to see what happens if we start Hessian estimate with identity matrix
% [point,val]=Quasi_Newton_Methods(@Powell,x,2,1000,'eye');

% print -depsc2 /home/yagiz/Desktop/courses/figure3.eps