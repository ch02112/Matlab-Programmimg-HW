array2=zeros(n);
middle=(n+1)/2;

v2=[1:n];
Dx = repmat (v2 , n ,1);
Dy = Dx';

middle=array2+middle;

D2=(middle-Dx).*(middle-Dx)+(middle-Dy).*(middle-Dy);

R2 = array2+r*r;

tmparray2 = D2<R2;
for ii=[1:n]
    fprintf('%d',tmparray2(ii, : ));
    fprintf('\n');
end
fprintf([repmat('%d',1 ,n) '\n'],tmparray2);



