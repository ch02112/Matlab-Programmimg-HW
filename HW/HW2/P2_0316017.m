function [ outputans ] = P2_0316017 ( String )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% a is fractions and op is operator
[a op] =parse (String);
opsize = size(op);

%Calculate the answer
sum = a(1,:);
for i = 1:opsize(2)
    if(op(i) == '+')
        sum = add (sum , a(i+1,:));
    elseif(op(i) == '-')
        sum = subtract (sum , a(i+1,:));
    end
end
%output the answer
outans(1,2) = "/";
outans(1,1) = sum(1);
outans(1,3) = sum(2);
fprintf("%s%s%s",outans(1,1),outans(1,2),outans(1,3));
outputans = strjoin(outans);
end

function [ fractions,operation] = parse ( String )
%str2num    
c = char(String);
c(c==' ') = [];%delete space
fnum = 0;
onum = 0;
fflag = 0;% 0 is start to upper 1 is upper 2 is begin to lower 3 is lower 
csize = size(c);
for i = 1 : csize(2)
    if (c(i)>='0') && (c(i)<='9')%is numbers
        if (fflag == 0)
            fnum = fnum +1;
            fractions(fnum,1) = str2num(c(i));
            fractions(fnum,2) = 1;
            fflag = 1;
        elseif fflag == 1
            fractions(fnum,1) = fractions(fnum,1) * 10 + str2num(c(i));
            fractions(fnum,2) = 1;
        elseif fflag == 2
            fractions(fnum,2) = str2num(c(i));
            fflag = 3;
        elseif fflag == 3
            fractions(fnum,2) = fractions(fnum,2) * 10 + str2num(c(i));
        end
    elseif c(i) == '/'
        fflag = 2;
    elseif c(i) == '+'
        fflag = 0;
        onum = onum + 1;
        operation(onum) =  '+';
    elseif c(i) == '-'
        fflag = 0;
        onum = onum + 1;
        operation(onum) =  '-';
    end
end

end

function [ ans ] = add ( a1 ,a2 )
%a1 + a2
%a1 a2 are 2 vector
%ans = ans1 / ans2
ans1 = a1(1) .* a2(2) + a2(1) .* a1(2);
ans2 = a1(2) .* a2(2);
ans = [ans1 ans2];
ans = simplify(ans);
end

function [ ans ] = subtract ( a1 ,a2 )
%a1 - a2
%a1 a2 are 2 vector 
%ans = ans1 / ans2
ans1 = a1(1) .* a2(2) - a2(1) .* a1(2);
ans2 = a1(2) .* a2(2);
ans = [ans1 ans2];
ans = simplify(ans);
end

function [ ans ] = simplify ( a1 )
%a1  is a vector 
%ans = ans1 / ans2
if (a1(1)>0)
    maxfactor = my_gcd (a1(1),a1(2));
else
    maxfactor = my_gcd (-a1(1),a1(2));
end

ans1 = a1(1) / maxfactor;
ans2 = a1(2) / maxfactor;
ans = [ans1 ans2];
end

function [ ans ] = my_gcd ( m1 ,m2 )
%m1 m2 are 2 number to do gcd
%ans is a number of 
if m1 > m2
    temp = ceil(m1/m2)-1;
    b1 = m1 - m2*temp;
    if b1 == 0
        ans = m2;
    else
        ans = my_gcd(m2 , b1);
    end
elseif m1 < m2
    ans = my_gcd(m2 , m1);
else  
    ans = m1;
end
end






