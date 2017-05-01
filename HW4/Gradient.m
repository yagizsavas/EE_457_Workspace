function grad=Gradient(func,x)
    len=length(x);
    direction=zeros(len,1);
    grad=zeros(len,1);
    for i=1:len
        direction(i)=1;
        h=zeros(len,1)+direction*10^-8;
        val_1=func(x+h);
        val_2=func(x-h);
        grad(i)=(val_1-val_2)/(2*h(i));
        direction=zeros(len,1);
    end
end