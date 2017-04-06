clear all
close all
clc
[x,y,iter,search_iter]=InexactDescent(@Rosenbrock,[0,0,0]',@Armijo_Goldstein,1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure5.eps