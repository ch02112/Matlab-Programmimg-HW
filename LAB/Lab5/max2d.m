function [ v,r,c,varargout ] = max2d( A,k,varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sizeA=size(A(:));
if nargin ~= 1
    sizek=size(k);
    if sizek(1)~= 1
        error('invalid input size2');
    elseif (k>sizeA(1))
        error('invalid input size3');
    elseif k<=1
        error('invalid input size');
    end
end

if (sizeA(1)==0)
    error('invalid input size1');
end


if nargin == 2
    if nargout == 3
        [temp,index] = sort(A(:),'descend');
        v = temp(1:k);
        r = index(1:k);
        [r,c] = ind2sub(size(A),r);
    elseif nargout == 2
        [temp,index] = sort(A(:),'descend');
        v = temp(1:k);
        r = index(1:k);
    elseif nargout == 1
        temp = sort(A(:),'descend');
        v = temp(1:k);
    else
        error('invalid output');
    end

elseif nargin == 1
    if nargout == 3
        [v,temp] = max(A(:));
        [r,c] = ind2sub(size(A),temp);
    elseif nargout == 2
        [v,r] = max(A(:));
    elseif nargout == 1
        v = max(A(:));
    else
        error('invalid output');
    end
else
    error('invalid input');
end
end

