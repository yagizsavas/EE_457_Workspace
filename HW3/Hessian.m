function hessian=Hessian(func,point)
    len=length(point);
    direction_1=zeros(len,1);
    direction_2=zeros(len,1);
    hessian=zeros(len,len);
    epsilon=10^-5;
    for i=1:len
        direction_1(i)=1;
        for j=i:len
            direction_2(j)=1;
            hessian(i,j)=(func(point+epsilon*direction_1+epsilon*direction_2)-func(point+epsilon*direction_1-epsilon*direction_2)...
                -func(point-epsilon*direction_1+epsilon*direction_2)+func(point-epsilon*direction_1-epsilon*direction_2))/(4*epsilon^2);
            hessian(j,i)=hessian(i,j);
            direction_2=zeros(len,1);
        end
    direction_1=zeros(len,1);
    end
end