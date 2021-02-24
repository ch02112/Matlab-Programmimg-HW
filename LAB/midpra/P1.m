function [ ans ] = P1( n , x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
ans= 0;
k = 0:n;
ans = sum( (((-1).^k) .* (x.^(2*k)) ./ factorial(2*k)))



end

