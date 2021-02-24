function [ uni sum ] = P4 ( structin )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
uni = unique (structin.K);
[su1 , su2] = size(uni);
sum = zeros(1,su2);
[s1 , s2] = size(structin.K);
[~, k] = sort([structin.K]);
structin.K = structin.K(k);
structin.N = structin.N(k);
index = 1;
flag = 0;
for(i=1:s2)
    if uni(index) == structin.K(i)
        if flag ==0
            sum(index) = structin.N(i);
            flag = 1;
        else
            sum(index) =sum(index) +  structin.N(i);
        end
    else
        index = index+1;
        sum(index) = structin.N(i);
    end
end


for i = 1:su2
   disp(["K=",uni(i),"   sum(N)=",sum(i)]);
    
end


end

