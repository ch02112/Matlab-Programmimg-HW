function [ output_args ] = P2 ( n )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

v1 = [1:n];
mapx = repmat (v1 , n , 1);
mapy = mapx';
z =zeros (n);
z=z+ (n+1)/2
zz = max( abs(z - mapx) , abs (z - mapy));
temp =zeros (n);
temp = temp + ((n-1)/2)
temp = temp - zz;
output_args = temp;




end

