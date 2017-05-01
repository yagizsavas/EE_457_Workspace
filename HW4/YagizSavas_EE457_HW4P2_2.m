clear all
clc
x=[3,-1,0,1]';
% Alpha=0.01, epsilon=0.2
[x_last,y]=Simulated_Annealing(@Powell,x,1000,0.01,0.2);
hold on
% Alpha=0.001, epsilon=0.2
[x_last,y]=Simulated_Annealing(@Powell,x,1000,0.001,0.2);

% print -depsc2 /home/yagiz/Desktop/courses/figure6.eps