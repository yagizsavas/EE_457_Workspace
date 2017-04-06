clear all
close all
clc
[x,y,iter,search_iter]=InexactDescent(@Rosenbrock,[0,0,0]',@Armijo,1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure4.eps