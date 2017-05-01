clear all
clc
x=[3,-1,0,1]';
% Alpha=0.01
[x_last,y]=Random_Search(@Powell,x,1000,0.01);
hold on
% Alpha=0.001
[x_last,y]=Random_Search(@Powell,x,1000,0.001);

% print -depsc2 /home/yagiz/Desktop/courses/figure5.eps