clc
clear all
close all
fprintf('Results for Golden Section Method:\n\n')
Golden_Section(@func2,0.5,2,0.02);
fprintf('Results for Newtons Method:\n\n')
Newtons_Method(@func2,0.5,0.5,2,10^-5)