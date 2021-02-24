function [ output_args ] = P1 ( m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for(n=1:m)
    anss=0;
    for k = 1:n
        anss =anss + 1./(k.*(k+1));
    end
    y(n) = anss
end
n=[1:m];
plot(n,y,'o-m');

end

