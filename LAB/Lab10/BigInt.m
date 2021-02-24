classdef BigInt
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        digits = 0;
    end
    
    methods
        
        function obj = BigInt(input)
           if nargin == 0
             obj.digits = 0;
           elseif nargin == 1 && isscalar(input)
             obj.digits = num2str(input) - '0';
           elseif nargin == 1 && ischar(input)
               obj.digits = input - '0';
           else
             error('Input error!');
           end
            
        end
        
        function s =  make_str(b1)
            s = char(b1.digits+'0');
        end
        
        
         function f = plus(b1, b2)
             if (isnumeric(b1))
                 b1 = BigInt(b1);
             end
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             [t s1] = size(b1.digits);
             [t s2] = size(b2.digits);
             if(s1>s2)
                 p1 = [0 b1.digits];
                 p2 = [zeros(1,s1-s2+1) b2.digits];
             elseif(s1<s2)
                 p2 = [0 b2.digits];
                 p1 = [zeros(1,s2-s1+1) b1.digits];
             else
                 p1 = [0 b1.digits];
                 p2 = [0 b2.digits];
             end
             ftemp = p1 + p2;
             [t s3] = size(ftemp);
             for i = s3:-1:2
                if(ftemp(i) >= 10)
                   ftemp(i) = ftemp(i) -10;
                   ftemp(i-1) = ftemp(i-1) +1;
                end
             end
             f= BigInt(char(ftemp+'0'));
         end
         
         function t = eq(b1, b2)
             [t s1] = size(b1.digits);
             [t s2] = size(b2.digits);
             if(s1>s2)
                 p1 = [0 b1.digits];
                 p2 = [zeros(1,s1-s2+1) b2.digits];
             elseif(s1<s2)
                 p2 = [0 b2.digits];
                 p1 = [zeros(1,s2-s1+1) b1.digits];
             else
                 p1 = [0 b1.digits];
                 p2 = [0 b2.digits];
             end
            t = all(p1 == p2);
         end
         
         function tt = times(b1,b2)
             if (isnumeric(b1))
                 b1 = BigInt(b1);
             end
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             ftemp = conv([0 0 0 b1.digits],[0 0 0 b2.digits]);
             [t2 s3] = size(ftemp);
             for i = s3:-1:2
                while(ftemp(i) >= 10)
                   ftemp(i) = ftemp(i) -10;
                   ftemp(i-1) = ftemp(i-1) +1;
                end
             end
             tt=BigInt(char(ftemp+'0'));
         end
         
         function disp(b)
             [t s1] = size(b.digits);
             while(b.digits(1) == 0 && s1>1)
                 b.digits = b.digits(2:end);
                 s1=s1-1;
             end
             str = make_str(b);
             disp(str);
         end
        
    end
    
end

