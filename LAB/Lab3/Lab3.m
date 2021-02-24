
xi = -10:2:10;
m1=ones(1,11);
yi = -.03*xi.^2 + .1*xi + 2 + .5*(rand(1,length(xi))-.5);


hold on;
x1=[m1;xi]';
x2=[ones(1,11);xi;xi.*xi]';
x3=[ones(1,11);xi;xi.*xi;xi.*xi.*xi]';


L1=x1\yi';
plot(xi,x1*L1)

L2=x2\yi';
plot(xi,x2*L2)

L3=x3\yi';
plot(xi,x3*L3)

plot(xi,yi)



