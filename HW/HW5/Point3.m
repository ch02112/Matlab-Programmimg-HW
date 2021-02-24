classdef Point3
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x ;
        y ;
        z ;
    end
    
    methods
        
        function obj = Point3(x,y,z)
            if nargin == 0
                obj.x=0.0;
                obj.y=0.0;
                obj.z=0.0;
               
           elseif nargin == 3 && isnumeric(x)&& isnumeric(y)&& isnumeric(z) && all(size(x)==size(y)) && all(size(y)==size(z))
               obj(1,numel(x)) = Point3;
               for ii = 1:numel(x)
                   obj(ii).x = double(x(ii));
                   obj(ii).y = double(y(ii));
                   obj(ii).z = double(z(ii));
               end
               obj = reshape(obj, size(x));
           else
             error('Input error!');
           end
        end
        
        function answ = norm(p)
            answ = zeros(size(p));
            for i = 1:numel(answ)
                answ(i) = sqrt(p(i).x*p(i).x + p(i).y*p(i).y + p(i).z*p(i).z);
            end
        end
        
        function answ = plus(p1,p2)
            
            if (isnumeric(p1))
                p1 = Point3(p1(1),p1(2),p1(3));
            end
            if (isnumeric(p2))
                p2 = Point3(p2(1),p2(2),p2(3));
            end
             
            if(numel(p1)==1&&numel(p2)==1)
                answ = p1;
                answ.x = p1.x + p2.x;
                answ.y = p1.y + p2.y;
                answ.z = p1.z + p2.z;
            elseif(numel(p1)==1)
                answ = p2;
                for i = 1:numel(answ)
                    answ(i).x = p1.x + p2(i).x;
                    answ(i).y = p1.y + p2(i).y;
                    answ(i).z = p1.z + p2(i).z;
                end
                
            elseif(numel(p2)==1)
                answ = p1;
                for i = 1:numel(answ)
                    answ(i).x = p2.x + p1(i).x;
                    answ(i).y = p2.y + p1(i).y;
                    answ(i).z = p2.z + p1(i).z;
                end
            else
                answ = p1;
                for i = 1:numel(answ)
                    answ(i).x = p2(i).x + p1(i).x;
                    answ(i).y = p2(i).y + p1(i).y;
                    answ(i).z = p2(i).z + p1(i).z;
                end
            end
        end
        
        function answ = minus(p1,p2)
            
            if (isnumeric(p1))
                p1 = Point3(p1(1),p1(2),p1(3));
            end
            if (isnumeric(p2))
                p2 = Point3(p2(1),p2(2),p2(3));
            end
             
            if(numel(p1)==1&&numel(p2)==1)
                answ = p1;
                answ.x = p1.x - p2.x;
                answ.y = p1.y - p2.y;
                answ.z = p1.z - p2.z;
            elseif(numel(p1)==1)
                answ = p2;
                for i = 1:numel(answ)
                    answ(i).x = p1.x - p2(i).x;
                    answ(i).y = p1.y - p2(i).y;
                    answ(i).z = p1.z - p2(i).z;
                end
                
            elseif(numel(p2)==1)
                answ = p1;
                for i = 1:numel(answ)
                    answ(i).x =  p1(i).x - p2.x;
                    answ(i).y =  p1(i).y - p2.y;
                    answ(i).z =  p1(i).z - p2.z;
                end
            else
                answ = p1;
                for i = 1:numel(answ)
                    answ(i).x = p1(i).x - p2(i).x;
                    answ(i).y = p1(i).y - p2(i).y;
                    answ(i).z = p1(i).z - p2(i).z;
                end
            end
        end
        
        function answ = eq(p1,p2)
            
            if (isnumeric(p1))
                p1 = Point3(p1(1),p1(2),p1(3));
            end
            if (isnumeric(p2))
                p2 = Point3(p2(1),p2(2),p2(3));
            end
             
            if(numel(p1)==1&&numel(p2)==1)
                answ = (p1.x == p2.x) && (p1.y == p2.y) && (p1.z == p2.z);
                
            elseif(numel(p1)==1)
                answ = zeros(size(p2));
                for i = 1:numel(answ)
                    answ(i) = (p1.x == p2(i).x) && (p1.y == p2(i).y) && (p1.z == p2(i).z);
                end
                
            elseif(numel(p2)==1)
                answ = zeros(size(p1));
                for i = 1:numel(answ)
                    answ(i) = (p1(i).x == p2.x) && (p1(i).y == p2.y) && (p1(i).z == p2.z);
                end
            else
                answ = zeros(size(p1));
                for i = 1:numel(answ)
                    answ(i) = (p1(i).x == p2(i).x) && (p1(i).y == p2(i).y) && (p1(i).z == p2(i).z);
                end
            end
        end
        
        
        function answ = sum(p,dim)
             if nargin == 1
                 dim = 1;
             elseif nargin == 2 && isscalar(dim)
                 %get the dim / sizep can get dim 
                 sizep = size(p);
                 
                 if dim > numel(sizep) || dim <1
                    dim = 1; 
                 end
             else
                 error('sum input error')
             end
             %start to calculate
              [temppoint3x,temppoint3y,temppoint3z] = sumsub(p,dim);
              answ = Point3(temppoint3x,temppoint3y,temppoint3z);
        end
        
        function [temppoint3x,temppoint3y,temppoint3z] = sumsub(p,dim)
            temppoint3x = zeros(size(p));
              temppoint3y = zeros(size(p));
              temppoint3z = zeros(size(p));
              for i = 1:numel(p)
                  temppoint3x(i) = p(i).x;
                  temppoint3y(i) = p(i).y;
                  temppoint3z(i) = p(i).z;
              end
              temppoint3x = sum(temppoint3x,dim);
              temppoint3y = sum(temppoint3y,dim);
              temppoint3z = sum(temppoint3z,dim);
        end
        
        function answ = mean(p,dim)
             if nargin == 1
                 dim = 1;
             elseif nargin == 2 && isscalar(dim)
                 %get the dim / sizep can get dim 
                 sizep = size(p);
                 if dim > numel(sizep) || dim <1
                    dim = 1; 
                 end
             else
                 error('mean input error')
             end
             [temppoint3x,temppoint3y,temppoint3z] = sumsub(p,dim);
             sizep = size(p);
            temppoint3x = temppoint3x./sizep(dim);
             temppoint3y = temppoint3y./sizep(dim);
             temppoint3z = temppoint3z./sizep(dim);
             answ = Point3(temppoint3x,temppoint3y,temppoint3z);
        end
        
        
        function disp(p)
            % get size
            [s1 ,s2] = size(p);
            for i = 1:s1
                string = ' ';
               for j = 1:s2
                   tempind = sub2ind([s1 s2] , i , j);
                   string(end+1) = '(';
                   string=strcat(string,num2str(p(tempind).x));
                   string(end+1) = ',';
                   string=strcat(string,num2str(p(tempind).y));
                   string(end+1) = ',';
                   string=strcat(string,num2str(p(tempind).z));
                   string(end+1) = ')';
                   for blk = 1:3
                       string(end+1) = ' ';
                   end
               end
               disp([string]);
            end
            
        end
        
    end
    
end

