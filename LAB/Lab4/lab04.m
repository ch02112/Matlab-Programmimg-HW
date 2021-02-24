hold on
n=100; [x,y]=meshgrid(-n:2:n,-n:2:n); % the grid points
z1=sin((x-.002*x.*x)/n*5).^2+1;
z2=sin((x+2*y)/n*2).^2+.5;
t1=80; w1=t1*t1./((x-20).^2+(y-40).^2+t1*t1);
z=z1.*z2.*w1*1000+rand(size(z1))*.1; % values of the grid points
ind_x=2:n;
ind_y=2:n;
[xx,yy]=find( z(ind_x,ind_y)>z(ind_x+1,ind_y) & z(ind_x,ind_y)>z(ind_x-1,ind_y) & z(ind_x,ind_y)>z(ind_x,ind_y+1) & z(ind_x,ind_y)>z(ind_x,ind_y-1) & z(ind_x,ind_y)>z(ind_x+1,ind_y+1) & z(ind_x,ind_y)>z(ind_x+1,ind_y-1) & z(ind_x,ind_y)>z(ind_x-1,ind_y+1) & z(ind_x,ind_y)>z(ind_x-1,ind_y-1))    
contourf(x,y,z);
text(yy*2-100,xx*2-100,num2str(round(z(yy*101+xx+1))));
plot(yy*2-100,xx*2-100,'^r')
