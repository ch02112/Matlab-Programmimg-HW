function [ output_args ] = p3(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

jpgfiles = dir('*.jpg');
% get jpg size
[jpgnum t] = size(jpgfiles);
jpgcount = 1;
select = zeros(1,jpgnum);
c='z';
nojpg = 0;
pt = [50 50];
f1 = figure('Name','f1','Position',[0,150,650,500]);


if jpgnum < 1 
    figure(f1);
    nojpg = 1;
else
    figure(f1);
    hold on;
    tempstring = [ jpgfiles(jpgcount).name];
    pic = imread(tempstring);
    % set the 
    imshow(pic);
    rectangle('Position',[20 20 40 40],'FaceColor','y');
    title( ['(' ,num2str(jpgcount),'/',num2str(jpgnum),')  ',jpgfiles(jpgcount).name ]);
end

while 1
    if nojpg == 1
        break;
    end
    tt = waitforbuttonpress;
    if tt == 1
        c = get(gcf, 'CurrentCharacter');
        if c == 'p'
            % show jpgs
            
            figure(f1);
            jpgcount = (jpgcount-1);
            if jpgcount == 0
                jpgcount = jpgcount + jpgnum;
            end
             tempstring = [ jpgfiles(jpgcount).name];
            pic = imread(tempstring);
            imshow(pic);
            if select(jpgcount)==1
                 rectangle('Position',[20 20 40 40],'FaceColor','r');
            else
                 rectangle('Position',[20 20 40 40],'FaceColor','y');
            end
            title( ['(' ,num2str(jpgcount),'/',num2str(jpgnum),')  ',jpgfiles(jpgcount).name ]);
        elseif c == 'n'
            figure(f1);
            jpgcount = (jpgcount+1);
            if jpgcount > jpgnum
                jpgcount = jpgcount - jpgnum;
            end
             tempstring = [ jpgfiles(jpgcount).name];
             pic = imread(tempstring);
            imshow(pic);        
            % set the size( min max ) as (50  100)
            if select(jpgcount)==1
                 rectangle('Position',[20 20 40 40],'FaceColor','r');
            else
                 rectangle('Position',[20 20 40 40],'FaceColor','y');
            end
            title( ['(' ,num2str(jpgcount),'/',num2str(jpgnum),')  ',jpgfiles(jpgcount).name ]);
            
         else
            c
        end
        
       % process key board inputs
    else
        rrr = get(gca, 'CurrentPoint');
        pt = rrr(1, 1:2)
        %set square 101*101
        %pt= set (pt ,highlighsize , pic ,f1);
        if pt(1)>20 && pt(1)<60 && pt(2)>20 && pt(2)<60
            if(select(jpgcount) == 0)
                select(jpgcount)=1;
            else
                select(jpgcount)=0;
            end
             tempstring = [ jpgfiles(jpgcount).name];
            pic = imread(tempstring);
            imshow(pic);
            if select(jpgcount)==1
                 rectangle('Position',[20 20 40 40],'FaceColor','r');
            else
                 rectangle('Position',[20 20 40 40],'FaceColor','y');
            end
            title( ['(' ,num2str(jpgcount),'/',num2str(jpgnum),')  ',jpgfiles(jpgcount).name ]);
            
        end
    end
    
    
end


end

