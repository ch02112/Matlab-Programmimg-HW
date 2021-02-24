function [ output_args ] = P4 ( im )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A = imread(im);
B = fliplr (A);
C = flipud (A);
D = flipud (B);
F = [B A;D C];
image(F);
end

