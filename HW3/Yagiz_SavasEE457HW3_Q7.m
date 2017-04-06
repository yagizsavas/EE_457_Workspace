clear all
close all
clc
[final_vector,final_value,iteration,search_iter]=Inexact_Modified_Newtons_Method(@Rosenbrock,[0,0,0]',@Armijo,1,10^-4);
% print -depsc2 /home/yagiz/Desktop/courses/figure8.eps
