clear all
close all
clc
[x,y,iter,line_iter]=SteepestDescent(@Rosenbrock,[0,0,0]',1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure3.eps