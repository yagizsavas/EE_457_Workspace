clear all
clc
data_x=1:26;
data_x=data_x';
data_y=[2.67750, 2.73102, 2.72662, 2.68096, 2.68090, 2.68424, 2.64755, 2.68472, 2.75736, 2.77880...
,2.77856, 2.88432, 2.92674, 2.92866 ,3.01290, 3.03274, 3.00027, 3.02782, 2.97552, 2.91740, 2.89356...
,2.88655, 2.85020, 2.89398, 2.86638, 2.85595]';
len=length(data_x);
one=ones(len,1);
A=[data_x, one];
b=data_y;
X=zeros(2,11);
F=zeros(11,1);
G=A(5:6,:)'*A(5:6,:); % Initial step
P=inv(G);
x=G\(A(5:6,:)'*b(5:6));
k=1;
X(:,k)=x;

for i=7:2:len-1 % Recursive Least Squares algorithm
        P=P-P*A(i:i+1,:)'*inv(eye(2)+A(i:i+1,:)*P*A(i:i+1,:)')*A(i:i+1,:)*P;
        x=x+P*A(i:i+1,:)'*(b(i:i+1)-A(i:i+1,:)*x);
        k=k+1;
        X(:,k)=x;
end

% Scatter data points and plot the fit line 
scatter(data_x,data_y);
hold on
plot(data_x(5:25),A(5:25,:)*X(:,end));
xlabel('Number of weeks')
ylabel('USD/TL')
txt1 = ['\leftarrow f(x)=' num2str(X(1,end)) 'x+' num2str(X(2,end)) ];
text(10,A(10,:)*X(:,end),txt1)
% print -depsc2 /home/yagiz/Desktop/courses/figure7.eps

figure
% Calculate function value and plot results
for i=1:k
    F(i)=(1/2)*(A(5:25,:)*X(:,i)-data_y(5:25))'*(A(5:25,:)*X(:,i)-data_y(5:25));
end
plot(1:k,F,'LineWidth',1.5); hold all
plot(1:k,X(1,:),'LineWidth',1.5);
plot(1:k,X(2,:),'LineWidth',1.5);

% Calculate Least Square Solutions using all data points and scatter
% results onto the same figure
x_total=inv(A'*A)*A'*b;
F_total=(1/2)*(A*x_total-data_y)'*(A*x_total-data_y);
scatter(k,x_total(1),50)
scatter(k,x_total(2),50)
scatter(k,F_total,50)
h=legend('$f(m^{(k)},c^{(k)})$','$m^{(k)}$','$c^{(k)}$','$m_{total}$','$c_{total}$','$f(m,c)_{total}$');
set(h,'interpreter','latex')
xlabel('Number of iterations (k)')
ylim([-0.5,5]);
% X(:,end)
% print -depsc2 /home/yagiz/Desktop/courses/figure8.eps

% Calculate the difference between two algorithms
diffx=x_total-X(:,end);
diffy=F_total-F(end);