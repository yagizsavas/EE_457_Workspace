clear all
clc
t=0:0.4:10;
t=t';
y=[0.9783, 1.4617, 2.0580, 2.0265, 2.2238, 1.5446, 1.0970, 0.2566, -0.5050, -0.8899, -1.5676, -2.1563...
,-1.9748, -2.2858, -1.6735, -1.0813, -0.1376, 0.6637, 1.0799, 1.7931, 2.1022, 2.2608, 2.0701, 1.6185, 0.7138 0.1444]';
len=length(t);
J=zeros(len,3);
x=[1,1,1];
x_last=x*2;
r=y-x(1)*sin(x(2)*t+x(3));
i=0;
nu=100;
I=eye(length(x));
while normtwo(x-x_last)>10^-3
    x_last=x;
    J(:,1)=-sin(x(2)*t+x(3));
    J(:,2)=-t.*(x(1)*cos(x(2)*t+x(3)));
    J(:,3)=-x(1)*cos(x(2)*t+x(3));
    r=y-x(1)*sin(x(2)*t+x(3));
    x=x_last-inv(J'*J+nu*I)*J'*r; 
    i=i+1;
end
scatter(t,y); hold on
t=0:0.01:10;
plot(t,x(1)*sin(x(2)*t+x(3)))
xlabel('t values')
ylabel('y values')
txt1 = ['\leftarrow f(t)=' num2str(x(1)) 'sin(' num2str(x(2)) 't+' num2str(x(3)) ')' ];
text(1.7,x(1)*sin(x(2)*1.7+x(3)),txt1)

% print -depsc2 /home/yagiz/Desktop/courses/figure10.eps