function [ A ] = lab7 ( fn , sort_mode)
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
fclose(fid);

if sort_mode == "word"
    [~, k] = sort([A.word]);
    A = A(k);
elseif sort_mode == "count"
    [~, k] = sort([A.count] , 'descend');
    A = A(k);
elseif sort_mode == "len"
    [~, k] = sort([A.len]);
    A = A(k);
    
end






nnprint = size(A);
if nargout==0
    for i = 1:nnprint(2)
        %str= sprintf ('%s%10d',word(i),count(i));
        %disp(str);
        disp ([A(i).word,A(i).count]);
    end
end


end