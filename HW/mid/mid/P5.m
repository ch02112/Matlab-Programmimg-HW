function [ ] = P5 ( map , vec )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%map = imread(im);
[sizem1 ,sizem2] = size(map);
sizem2 = sizem2 / 3;
x1 = vec(1);
x2 = vec(3);
y1 =vec(2);
y2 = vec(4);
if (x2<x1) | (y2<y1) | (x1>sizem2) | (y1>sizem1) | (x2<0) | (y2<0)
    image(map);
    
else
    mapc = imcomplement(map);
    if  (x2>sizem2) 
        x2 = sizem2;
    end
    if  (y2>sizem1) 
        y2 = sizem1;
    end
    if  (x1<1) 
        x1 = 1;
    end
    if  (y1<1) 
        y1 = 1;
    end
    for i = y1:y2
       for (j = x1:x2)
          map(i,j,1) = mapc(i,j,1);
          map(i,j,2) = mapc(i,j,2);
          map(i,j,3) = mapc(i,j,3);
       end
    end
    
    image(map);
    
end

end

