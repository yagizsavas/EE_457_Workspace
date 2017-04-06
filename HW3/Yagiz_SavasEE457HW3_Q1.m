clear all
close all
clc
[x,y,iter]=Descent(@Rosenbrock,[0,0,0]',0.001,1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure1.eps
[x1,y1,iter1]=Descent(@Rosenbrock,[0,0,0]',0.0001,1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure2.eps

