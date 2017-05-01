clear all
clc
x=[-3,-1,0,1]';
[point,val]=Conjugate_Direction(@Powell,x,1,1000);
% print -depsc2 /home/yagiz/Desktop/courses/figure1.eps