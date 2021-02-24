

n=100; [x,y]=meshgrid(-n:2:n,-n:2:n); % the grid points
z1=sin((x-.002*x.*x)/n*5).^2+1;
z2=sin((x+2*y)/n*2).^2+.5;
t1=80; w1=t1*t1./((x-20).^2+(y-40).^2+t1*t1);
z=z1.*z2.*w1*1000+rand(size(z1))*.1; % values of the grid points

localmax = imregionalmax(z);

hold on;
contourf(z);
contour(localmax);

temp=find(localmax);
[m,k]=ind2sub(101,temp);

text(k,m,num2str(round(z(localmax))));





