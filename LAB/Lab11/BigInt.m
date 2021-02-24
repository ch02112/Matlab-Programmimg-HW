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
           elseif nargin == 1 && iscell(input)
               obj(1,numel(input)) = BigInt;
               for ii = 1:numel(input)
                   obj(ii).digits = input{ii} - '0';
               end
               obj = reshape(obj, size(input));
               
           elseif nargin == 1 && isnumeric(input) && numel(input)>1
               obj(1,numel(input)) = BigInt;
               for ii = 1:numel(input)
                   obj(ii).digits = num2str(input(ii)) - '0';
               end
               obj = reshape(obj, size(input));
               
           elseif nargin == 1 && isscalar(input)
               obj(1,1) = BigInt;
               obj(1).digits = num2str(input) - '0';
           elseif nargin == 1 && ischar(input)
               obj(1,1) = BigInt;
               obj(1).digits = input - '0';
           else
             error('Input error!');
           end
            
        end
        
        function s =  make_str(b1 , n)
            s = char(b1(n).digits+'0');
        end
        
        function f = plus(b1, b2)
            if (isnumeric(b1))
                 b1 = BigInt(b1);
            end
            
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             [t1 s1] = size(b1);
             [t2 s2] = size(b2);
             if (t1 == t2 && s1 == s2 && t2*s2 > 1)
                 anssum{t2,s2} = '0';
                   for i = 1:t2*s2
                     temp1 = BigInt(make_str(b1,i));
                     temp2 = BigInt(make_str(b2,i));
                     tempbigint = plussingle(temp1, temp2);
                     anssum{i} = make_str(tempbigint,1);
                   end
                   anssum = reshape(anssum, size(b2));
                   f = BigInt(anssum);
             elseif t1*s1 == 1 && t2*s2 == 1
                 f = plussingle(b1, b2);
             elseif t1*s1 == 1
                 anssum{t2,s2} = '0';
                   for i = 1:t2*s2
                     temp = BigInt(make_str(b2,i));
                     tempbigint = plussingle(b1, temp);
                     anssum{i} =make_str(tempbigint,1);
                   end
                   anssum = reshape(anssum, size(b2));
                   f = BigInt(anssum);
             elseif t2*s2 == 1
                anssum{t2,s2} = '0';
                   for i = 1:t1*s1
                     temp = BigInt(make_str(b1,i));
                     tempbigint = plussingle(b2, temp);
                     anssum{i} = make_str(tempbigint,1);
                   end
                   anssum = reshape(anssum, size(b1));
                   f = BigInt(anssum);
             else
                 error('plus size error!');
             end
        end
        
         function f = plussingle(b1, b2)
             if (isnumeric(b1))
                 b1 = BigInt(b1);
             end
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             [t s1] = size(b1(1).digits);
             [t s2] = size(b2(1).digits);
             if(s1>s2)
                 p1 = [0 b1(1).digits];
                 p2 = [zeros(1,s1-s2+1) b2(1).digits];
             elseif(s1<s2)
                 p2 = [0 b2(1).digits];
                 p1 = [zeros(1,s2-s1+1) b1(1).digits];
             else
                 p1 = [0 b1(1).digits];
                 p2 = [0 b2(1).digits];
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
         
         
         
         function f = eq(b1, b2)
             if (isnumeric(b1))
                 b1 = BigInt(b1);
             end
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             [t1 s1] = size(b1);
             [t2 s2] = size(b2);
             if (t1 == t2 && s1 == s2 && t2*s2 > 1)
                 anssum(t2,s2) = 0;
                   for i = 1:t2*s2
                     temp1 = BigInt(make_str(b1,i));
                     temp2 = BigInt(make_str(b2,i));
                     tempbigint = eqsingle(temp1, temp2);
                     anssum(i) = tempbigint;
                   end
                   anssum = reshape(anssum, size(b1));
                   f = anssum;
             elseif t1*s1 == 1 && t2*s2 == 1
                 f = eqsingle(b1, b2);
             elseif t1*s1 == 1
                 anssum(t2,s2) = 0;
                   for i = 1:t2*s2
                     temp = BigInt(make_str(b2,i));
                     tempbigint = eqsingle(b1, temp);
                     anssum(i) =tempbigint;
                   end
                   anssum = reshape(anssum, size(b1));
                   f = anssum;
             elseif t2*s2 == 1
                anssum(t2,s2) = 0;
                   for i = 1:t1*s1
                     temp = BigInt(make_str(b1,i));
                     tempbigint = eqsingle(b2, temp);
                     anssum(i) = tempbigint;
                   end
                   anssum = reshape(anssum, size(b1));
                   f = anssum;
             else
                 error('eq size error!');
             end
             
         end
         
         
         
         function t = eqsingle(b1, b2)
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
         
         
         
         function f = times(b1,b2)
             if (isnumeric(b1))
                 b1 = BigInt(b1);
            end
            
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             [t1 s1] = size(b1);
             [t2 s2] = size(b2);
             if (t1 == t2 && s1 == s2 && t2*s2 > 1)
                 anssum{t2,s2} = '0';
                   for i = 1:t2*s2
                     temp1 = BigInt(make_str(b1,i));
                     temp2 = BigInt(make_str(b2,i));
                     tempbigint = timessingle(temp1, temp2);
                     anssum{i} = make_str(tempbigint,1);
                   end
                   anssum = reshape(anssum, size(b2));
                   f = BigInt(anssum);
             elseif t1*s1 == 1 && t2*s2 == 1
                 f = timessingle(b1, b2);
             else
                 error('times size error!');
             end
             
         end
         
         
         function tt = timessingle(b1,b2)
             if (isnumeric(b1))
                 b1 = BigInt(b1);
             end
             if (isnumeric(b2))
                 b2 = BigInt(b2);
             end
             ftemp = conv([0 0 0 b1(1).digits],[0 0 0 b2(1).digits]);
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
             [t2 s2] = size(b);
             if(t2*s2==1)% one element 
                 [t s1] = size(b(1).digits);
                 while(b(1).digits(1) == 0 && s1>1)
                     b(1).digits = b(1).digits(2:end);
                     s1=s1-1;
                 end
                 str = make_str(b,1);
                 disp(str);
             else
                 
                 
                 for i = 1:t2*s2
                     [t s1] = size(b(i).digits);
                     while(b(i).digits(1) == 0 && s1>1)
                         b(i).digits = b(i).digits(2:end);
                         s1=s1-1;
                     end
                     tempcell = cell(1,numel(size(b)));
                     [tempcell{:}] = ind2sub(size(b),i);
                     tempcell = [tempcell{:}];
                     %d replacematrix repmat
                     str = make_str(b,i);
                     strscript = '(';
                     for iii = 1:numel(tempcell)
                         if(iii == numel(tempcell))
                             strscript(end+1) = int2str(tempcell(iii));
                             strscript(end+1) = ')';
                         else
                             strscript(end+1) = int2str(tempcell(iii));
                             strscript(end+1) = ',';
                         end
                     end
                     ansstr = ['( %d' repmat(' , %d',[1 numel(tempcell)-1]) ' ) %s\n'];
                     fprintf(ansstr,tempcell,str);
                     disp([ strscript,' ',str]);
                 end
             end
         end
        
         
         
    end
    
end

