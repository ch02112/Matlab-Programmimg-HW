function [ m , s ] = P5( sss )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
C=textscan(sss,'%s','Delimiter',' ');
CC = C{1};
num = size(CC);
temp=0;
nn=0;
for i=1:num(1)
    if(strcmp(CC(i),temp)==1)%same
        A(nn).count = A(nn).count +1;
    else
        nn=nn+1;
        temp=CC(i);
        A(nn).word = temp;
        A(nn).count = 1;
        A(nn).len = cellfun('length' , A(nn).word);
        
        %word(nn) = temp;
        %count(nn) = 1;
    end
end
[~, k] = sort([A.len] , 'descend');
A = A(k);
m=0;
nn = 0;

nnprint = size(A);
    for i = 1:nnprint(2)
        m = A(1).len;
        if A(i).len < m
            break;
        end
        nn=nn+1;
        s(nn) = A(i).word;
        disp ([A(i).word]);
    end




end

