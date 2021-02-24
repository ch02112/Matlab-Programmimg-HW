function [ output_args ] = P8 ( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
figure(1);
axis([0 1 0 1]);
hold on;
%ini
r=0.1;
c='z';
colort='r';
wid = 1;
txt = ['color=' , colort ,'width=',num2str(wid) ,'radius=',num2str(r)]
ttexttemp = text(0.1,0.9,txt);

while 1
 %some processing here
    figure(1); % you need a figure to receive the events
    %show something in the figure
    tt = waitforbuttonpress;
    if tt == 1
        c = get(gcf, 'CurrentCharacter');
        if c >='1' && c <='9'
            wid = c - '0';
        elseif c == '+'
            r=r*1.1;
        elseif c == '-'
            r=r*0.9;
        elseif c == 'X'
            cla;
            ttexttemp = text(0.1,0.9,txt);
        elseif c == 'q'
            break;
        elseif c == 'r' || c=='b'|| c=='k'|| c=='w'|| c=='y'|| c=='c'|| c=='m'|| c=='g'
            colort = c;
        end
        txt = ['color=' , colort ,' width=',num2str(wid) ,' radius=',num2str(r)]
        set(ttexttemp,'string',txt); 
        
        
       % process key board inputs
    else
        rrr = get(gca, 'CurrentPoint');
        pt = rrr(1, 1:2); % coordinates in 2-D
        %process mouse clicks
        plot( cosd(0:360)*r + pt(1)  , sind(0:360)*r + pt(2),'LineWidth',wid,'Color',colort);
        
        if c == 'q'
            break;
        end
    end
end

end

