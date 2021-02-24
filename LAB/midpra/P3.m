function [ output_args ] = P3 ( matrix )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n1,n2] = size(matrix);
% y = -a/b x -c/b x= -b/a y -c/a
x=[-10:10];
hold on;
for i = 1:n1
    disp i;
    if matrix(i,2) < matrix(i,1)
        y=[-10:10];
        x = - matrix(i,2) / matrix(i,1) * y - matrix(i,3)/matrix(i,1);
        plot(x,y);
        axis([-10 10 -10 10]);
    else
        x=[-10:10];
        y = -matrix(i,1) / matrix(i,2) * x - matrix(i,3) / matrix(i,2);
        plot (x,y);
        axis([-10 10 -10 10]);
    end
end

end

