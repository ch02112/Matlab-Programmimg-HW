function y=P1(n,x)
    m=[1 cumprod([1:2*n])]
    m=m(2*[0:n]+1);
    s=cumprod(ones(1,n+1)*(-1))*(-1);
    s=s./m;    
    temp=cumprod([ones(1,length(x));repmat(x,2*n,1)])';
    temp=temp(:,2*[0:n]+1);
    
    y=sum((temp.*(repmat(s,length(x),1)))');
    
end