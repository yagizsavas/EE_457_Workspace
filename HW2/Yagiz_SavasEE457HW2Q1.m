clear all
clc
close all
fprintf('Results for Golden Section Method:\n\n')
Golden_Section(@func1,1,6,0.02)
fprintf('Results for Fibonacci Method:\n\n')
Fibonacci_Method(@func1,1,6,0.02,0.02)