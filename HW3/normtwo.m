function result=normtwo(x)
    len=length(x);
    sum=0;
    for i=1:len
        sum=sum+x(i)^2;
    end
    result=sqrt(sum);
end