classdef P1
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x1;
        y1;
        x2;
        y2;
        empty;
    end
    
    methods
        function obj = P1(xi1,yi1,xi2,yi2)
            if nargin == 0
                obj.x1=0.0;
                obj.y1=0.0;
                obj.x2=0.0;
                obj.y2=0.0;
                obj(:).empty = 1;
               
           elseif nargin == 4 && isnumeric(xi1)&& isnumeric(yi1)&& isnumeric(xi2)&& isnumeric(yi2) && all(size(xi1)==size(yi1)) && all(size(xi1)==size(xi2)) && all(size(xi1)==size(yi2))
               obj(1,numel(xi1)) = P1;
               for ii = 1:numel(xi1)
                   obj(ii).x1 = double(xi1(ii));
                   obj(ii).y1 = double(yi1(ii));
                   obj(ii).x2 = double(xi2(ii));
                   obj(ii).y2 = double(yi2(ii));
                   if(obj(ii).x1>=obj(ii).x2)||(obj(ii).y1>=obj(ii).y2)
                       obj(ii).empty = 1;
                   else
                       obj(ii).empty = 0;
                   end
                   
               end
               obj = reshape(obj, size(xi1));
           else
             error('Input error!');
           end
        end
        
        function answ = and(p1,p2)
                answ = p1;
                for i = 1:numel(answ)
                    answ(i).x1 = max(p2(i).x1 , p1(i).x1);
                    answ(i).y1 = max(p2(i).y1 , p1(i).y1);
                    answ(i).x2 = min(p2(i).x2 , p1(i).x2);
                    answ(i).y2 = min(p2(i).y2 , p1(i).y2);
                    if(answ(i).x1>=answ(i).x2)||(answ(i).y1>=answ(i).y2)
                       answ(i).empty = 1;
                    end
                end
                
        end
        
        function answ = or(p1,p2)
                answ = p1;
                for i = 1:numel(answ)
                    answ(i).x1 = min(p2(i).x1 , p1(i).x1);
                    answ(i).y1 = min(p2(i).y1 , p1(i).y1);
                    answ(i).x2 = max(p2(i).x2 , p1(i).x2);
                    answ(i).y2 = max(p2(i).y2 , p1(i).y2);
                    if(answ(i).x1>=answ(i).x2)||(answ(i).y1>=answ(i).y2)
                       answ(i).empty = 1;
                    end
                end
                
        end
        
        function answ = draw(p)
            figure(1);
            close(1);
            figure(1);
            for i=1:numel(p)
                if(p(i).empty == 0)
                    rectangle('Position',[p(i).x1 p(i).y1 p(i).x2-p(i).x1 p(i).y2-p(i).y1]);
                end
                
            end
            
        end
        
        
        
        function disp(p)
            % get size
                [s1 ,s2] = size(p);
                for i = 1:s1
                    string = ' ';
                    for j = 1:s2
                        tempind = sub2ind([s1 s2] , i , j);
                        if p(tempind).empty == 1
                             string=strcat(string,'<empty>');
                             for blk = 1:3
                                string(end+1) = ' ';
                             end
                        else
                           string(end+1) = '(';
                           string=strcat(string,num2str(p(tempind).x1));
                           string(end+1) = ',';
                           string=strcat(string,num2str(p(tempind).y1));
                           string(end+1) = ',';
                            string=strcat(string,num2str(p(tempind).x2));
                            string(end+1) = ',';
                            string=strcat(string,num2str(p(tempind).y2));
                           string(end+1) = ')';
                        end
                        for blk = 1:3
                            string(end+1) = ' ';
                        end
                    end
                    disp([string]);
                end
            
        end
        
        
        
    end
    
end

