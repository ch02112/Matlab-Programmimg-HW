function [ output_args ] = P3 ( array )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[n1 n2] = size(array);
colormap = [1 1 0 ; 1 0 1 ; 0 1 1 ; 1 0 0 ; 0 1 0; 0 0 1 ; 1 1 0 ; 1 0 1  ];
hold on;
%y= ax+b a= y1-y2 / x1-x2
for i = 1:n1
    x1 = array(i,1);
    x2 = array(i,3);
    y1 =array(i,2);
    y2 = array(i,4);
    axis([-10 10 -10 10]);
    if(abs(x1-x2) < abs(y1 - y2))
       ya= [y1 y2 -10 10];
       yya = [y1 y2];
       xa = (x1-x2)/(y1-y2) * ya +(x1 - (x1-x2)/(y1-y2)*y1);
       xxa = (x1-x2)/(y1-y2) * yya +(x1 - (x1-x2)/(y1-y2)*y1);
       plot(xa,ya,'color',colormap(mod(i,6),:));
       plot(xxa,yya,'o','color',colormap(mod(i,6),:));
    else
        x = [x1 x2 -10 10];
        xx = [x1 x2];
        yy =  (y1-y2)/(x1-x2) * xx + (y1 - ((y1-y2)/(x1-x2))*x1); 
        y =  (y1-y2)/(x1-x2) * x + (y1 - ((y1-y2)/(x1-x2))*x1) ;
        plot(x,y,'color',colormap(mod(i,6),:));
        plot(xx,yy,'o','color',colormap(mod(i,6),:));
    end
    

end

