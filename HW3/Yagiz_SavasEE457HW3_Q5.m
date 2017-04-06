clear all
close all
clc
[final_vector,final_value,iteration]=Newtons_Method(@Rosenbrock,[0,0,0]',1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure6.eps
