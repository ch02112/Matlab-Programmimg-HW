function [ word count ] = lab6 ( fn )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


fid = fopen(fn,'rt');
C = textscan(fid, '%s','Delimiter','. ,');
C=lower(C{1});
CC=sort(C);


num = size(CC);
temp=0;
nn=0;
for i=2:num(1)
    if(strcmp(CC(i),temp)==1)%same
        count(nn) = count(nn) +1;
    else
        nn=nn+1;
        temp=CC(i);
        word(nn) = temp;
        count(nn) = 1;
    end
end


fclose(fid);

nnprint = size(count);
if nargout==0
    for i = 1:nnprint(2)
        %str= sprintf ('%s%10d',word(i),count(i));
        %disp(str);
        disp ([word(i),count(i)]);
    end
end
ttt("sssss")
end



function [ a ] = ttt ( fn )
    disp(fn);
end


